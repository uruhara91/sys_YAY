#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <time.h>

// --- CONSTANTS ---
const char* FREEZE_LIST_PATH = "/data/adb/modules/sys_YAY/core/freeze.txt";
const char* GAME_LIST_PATH   = "/data/adb/modules/sys_YAY/core/games.txt";
const char* CMD_PATH         = "/proc/mtk_battery_cmd/current_cmd";
const char* BAT_CAP_PATH     = "/sys/class/power_supply/battery/capacity";
const char* BAT_STATUS_PATH  = "/sys/class/power_supply/battery/status";
const char* GOV_PATH         = "/sys/devices/system/cpu/cpufreq/policy6/scaling_governor";
const char* BRIGHTNESS_PATH  = "/sys/class/leds/lcd-backlight/brightness";
const char* CGROUP_TOP_APP   = "/dev/cpuset/top-app/cgroup.procs";

const char* BYPASS_ON  = "0 1\n";
const char* BYPASS_OFF = "0 0\n";
const int MIN_BATTERY = 80;

#define AT_FDCWD -100
#define PKG_BUFFER_SIZE 4096
#define CMD_BUFFER_SIZE 8192

// --- INLINE ASSEMBLY SYSCALLS (AARCH64) ---

static inline int sys_open(const char *path, int flags, int mode) {
    register long x0 asm("x0") = AT_FDCWD;
    register long x1 asm("x1") = (long)path;
    register long x2 asm("x2") = flags;
    register long x3 asm("x3") = mode;
    register long x8 asm("x8") = 56; // __NR_openat
    asm volatile("svc #0" : "=r"(x0) : "r"(x0), "r"(x1), "r"(x2), "r"(x3), "r"(x8) : "memory");
    return (int)x0;
}

static inline ssize_t sys_read(int fd, void *buf, size_t count) {
    register long x0 asm("x0") = fd;
    register long x1 asm("x1") = (long)buf;
    register long x2 asm("x2") = count;
    register long x8 asm("x8") = 63; // __NR_read
    asm volatile("svc #0" : "=r"(x0) : "r"(x0), "r"(x1), "r"(x2), "r"(x8) : "memory");
    return (ssize_t)x0;
}

static inline ssize_t sys_write(int fd, const void *buf, size_t count) {
    register long x0 asm("x0") = fd;
    register long x1 asm("x1") = (long)buf;
    register long x2 asm("x2") = count;
    register long x8 asm("x8") = 64; // __NR_write
    asm volatile("svc #0" : "=r"(x0) : "r"(x0), "r"(x1), "r"(x2), "r"(x8) : "memory");
    return (ssize_t)x0;
}

static inline int sys_close(int fd) {
    register long x0 asm("x0") = fd;
    register long x8 asm("x8") = 57; // __NR_close
    asm volatile("svc #0" : "=r"(x0) : "r"(x0), "r"(x8) : "memory");
    return (int)x0;
}

static inline void sys_nanosleep(long sec) {
    struct timespec { long tv_sec; long tv_nsec; } req = { sec, 0 };
    register long x0 asm("x0") = (long)&req;
    register long x1 asm("x1") = 0;
    register long x8 asm("x8") = 101; // __NR_nanosleep
    asm volatile("svc #0" : : "r"(x0), "r"(x1), "r"(x8) : "memory");
}

// --- OPTIMIZED HELPERS ---

void write_to_file(const char* path, const char* val) {
    int fd = sys_open(path, O_WRONLY, 0);
    if (fd >= 0) {
        size_t len = 0;
        while (val[len]) len++; // fast strlen
        sys_write(fd, val, len);
        sys_close(fd);
    }
}

int read_int(const char* path) {
    char buf[16];
    int fd = sys_open(path, O_RDONLY, 0);
    if (fd < 0) return -1;
    ssize_t len = sys_read(fd, buf, sizeof(buf) - 1);
    sys_close(fd);
    if (len > 0) {
        buf[len] = '\0';
        return atoi(buf);
    }
    return -1;
}

int android_system(const char* cmd) {
    pid_t pid = fork();
    if (pid == 0) {
        // Child
        int dev_null = sys_open("/dev/null", O_WRONLY, 0);
        if (dev_null > 0) {
            dup2(dev_null, 1);
            dup2(dev_null, 2);
            sys_close(dev_null);
        }
        execl("/system/bin/sh", "sh", "-c", cmd, NULL);
        _exit(127);
    }
    int status;
    waitpid(pid, &status, 0);
    return status;
}

int is_screen_on() {
    int val = read_int(BRIGHTNESS_PATH);
    if (val == -1) return 1;
    return (val > 0);
}

int is_charging() {
    char buf[64];
    int fd = sys_open(BAT_STATUS_PATH, O_RDONLY, 0);
    if (fd < 0) return 1;
    ssize_t len = sys_read(fd, buf, sizeof(buf) - 1);
    sys_close(fd);
    if (len > 0) {
        buf[len] = '\0';
        if (strstr(buf, "Discharging") || strstr(buf, "Not")) return 0;
    }
    return 1;
}

void get_top_app_cgroup(char* buffer, size_t size) {
    buffer[0] = '\0';
    FILE* fp = fopen(CGROUP_TOP_APP, "r");
    if (!fp) return;

    char pid_str[16];
    char cmdline_path[64];
    char pkg_temp[256];

    while (fgets(pid_str, sizeof(pid_str), fp)) {
        pid_str[strcspn(pid_str, "\r\n")] = 0;
        int pid = atoi(pid_str);

        if (pid > 0) {
            snprintf(cmdline_path, sizeof(cmdline_path), "/proc/%d/cmdline", pid);

            // Optimized read for high-freq proc polling
            int fd = sys_open(cmdline_path, O_RDONLY, 0);
            if (fd >= 0) {
                ssize_t len = sys_read(fd, pkg_temp, sizeof(pkg_temp) - 1);
                sys_close(fd);

                if (len > 0) {
                    pkg_temp[len] = '\0';
                    if (strchr(pkg_temp, '.') != NULL && pkg_temp[0] != '/') {
                        strncpy(buffer, pkg_temp, size - 1);
                        buffer[size - 1] = '\0';
                        break;
                    }
                }
            }
        }
    }
    fclose(fp);
}

// Keep standard I/O for file lists to handle parsing robustness
int get_file_content_list(const char* path, char* buffer, size_t size) {
    FILE* file = fopen(path, "r");
    if (!file) return 0;

    char line[256];
    size_t current_len = 0;
    buffer[0] = '\0';

    while (fgets(line, sizeof(line), file)) {
        line[strcspn(line, "\r\n")] = 0;
        if (line[0] == '\0' || line[0] == '#' || line[0] == '[') continue;

        size_t line_len = strlen(line);
        if (current_len + line_len + 2 < size) {
            strcat(buffer, line);
            strcat(buffer, " ");
            current_len += line_len + 1;
        }
    }
    fclose(file);
    return (current_len > 0);
}

void apply_freeze(int enable) {
    char pkg_list[PKG_BUFFER_SIZE];
    char final_cmd[CMD_BUFFER_SIZE];

    if (!get_file_content_list(FREEZE_LIST_PATH, pkg_list, sizeof(pkg_list))) return;

    if (enable) {
        // Optimized command chain
        snprintf(final_cmd, sizeof(final_cmd),
                 "cmd package suspend %s >/dev/null; "
                 "for p in %s; do cmd activity force-stop $p >/dev/null; done &",
                 pkg_list, pkg_list);
    } else {
        snprintf(final_cmd, sizeof(final_cmd),
                 "cmd package unsuspend %s >/dev/null &",
                 pkg_list);
    }
    android_system(final_cmd);
}

void apply_bypass(int enable) {
    write_to_file(CMD_PATH, enable ? BYPASS_ON : BYPASS_OFF);
}

int is_performance_mode() {
    char buf[64];
    int fd = sys_open(GOV_PATH, O_RDONLY, 0);
    if (fd < 0) return 0;
    int len = sys_read(fd, buf, sizeof(buf) - 1);
    sys_close(fd);
    if (len > 0) {
        buf[len] = '\0';
        return (strstr(buf, "perf") != NULL || strstr(buf, "userspace") != NULL);
    }
    return 0;
}

void check_and_apply_game_config(const char* current_app) {
    FILE* file = fopen(GAME_LIST_PATH, "r");
    if (!file) return;

    char line[256];
    char cmd_buf[512];

    while (fgets(line, sizeof(line), file)) {
        line[strcspn(line, "\r\n")] = 0;
        if (line[0] == '#' || line[0] == '\0' || line[0] == '[') continue;

        char* token_pkg = strtok(line, ":");
        char* token_scale = strtok(NULL, ":");

        if (token_pkg && token_scale && strcmp(token_pkg, current_app) == 0) {
            snprintf(cmd_buf, sizeof(cmd_buf),
                     "device_config put game_overlay %s mode=2,downscaleFactor=%s; "
                     "cmd game mode performance %s >/dev/null",
                     token_pkg, token_scale, token_pkg);
            android_system(cmd_buf);
            break;
        }
    }
    fclose(file);
}

void smart_wait_screen_off() {
    while (1) {
        if (is_screen_on()) return;
        sys_nanosleep(5); // Idle Check Interval
    }
}

int main() {
    int last_freeze_state = -1;
    int last_bypass_state = -1;
    char last_app[128] = "";
    char current_app[128];

    // Main Loop
    while (1) {
        if (!is_screen_on()) {
            smart_wait_screen_off();
            last_app[0] = '\0';
            continue;
        }

        int perf_mode = is_performance_mode();
        int battery = read_int(BAT_CAP_PATH);
        int charging = is_charging();

        if (battery < 0) battery = 100;

        get_top_app_cgroup(current_app, sizeof(current_app));

        if (strcmp(current_app, last_app) != 0) {
            if (strlen(current_app) > 0) {
                check_and_apply_game_config(current_app);
            }
            strncpy(last_app, current_app, sizeof(last_app));
        }

        int target_freeze = perf_mode ? 1 : 0;
        if (target_freeze != last_freeze_state) {
            apply_freeze(target_freeze);
            last_freeze_state = target_freeze;
        }

        int target_bypass = (perf_mode && battery >= MIN_BATTERY && charging) ? 1 : 0;
        if (!charging && last_bypass_state == 1) {
            target_bypass = 0;
        }

        if (target_bypass != last_bypass_state) {
            apply_bypass(target_bypass);
            last_bypass_state = target_bypass;
        }

        sys_nanosleep(8); // Active Interval
    }
    return 0;
}
