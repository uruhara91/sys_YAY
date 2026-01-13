#!/system/bin/sh

sleep 5

echo "=== Applying Rules ===" >> "$LOG_FILE"

cmd appops set com.google.android.networkstack.tethering 63 deny
cmd appops set com.google.android.networkstack.tethering 40 deny
cmd appops set com.mediatek.gba 63 deny
cmd appops set com.mediatek.gba 40 deny
cmd appops set com.android.cts.priv.ctsshim 63 deny
cmd appops set com.android.cts.priv.ctsshim 40 deny
cmd appops set com.google.android.youtube 63 deny
cmd appops set com.google.android.youtube 40 deny
pm disable com.google.android.youtube/com.google.android.gms.measurement.AppMeasurementReceiver
pm disable com.google.android.youtube/com.google.android.gms.measurement.AppMeasurementService
pm disable com.google.android.youtube/androidx.work.impl.diagnostics.DiagnosticsReceiver
pm disable com.google.android.youtube/com.google.android.gms.measurement.AppMeasurementJobService
cmd appops set com.transsion.statisticalsales 40 deny
cmd appops set com.transsion.statisticalsales 63 deny
cmd appops set com.zaz.translate 40 deny
cmd appops set com.zaz.translate 63 deny
cmd appops set com.android.internal.display.cutout.emulation.corner 63 deny
cmd appops set com.android.internal.display.cutout.emulation.corner 40 deny
cmd appops set com.google.android.ext.services 63 deny
cmd appops set com.google.android.ext.services 40 deny
pm disable com.google.android.ext.services/android.ext.services.notification.Assistant
pm disable com.google.android.ext.services/androidx.work.impl.diagnostics.DiagnosticsReceiver
cmd appops set com.android.internal.display.cutout.emulation.double 63 deny
cmd appops set com.android.internal.display.cutout.emulation.double 40 deny
cmd appops set com.android.dynsystem 40 deny
cmd appops set com.android.dynsystem 63 deny
cmd appops set com.transsion.plat.appupdate 40 deny
cmd appops set com.transsion.plat.appupdate 63 deny
cmd appops set com.android.theme.icon.pebble 40 deny
cmd appops set com.android.theme.icon.pebble 63 deny
cmd appops set com.google.android.googlequicksearchbox 40 deny
cmd appops set com.google.android.googlequicksearchbox 63 deny
cmd appops set md.obsidian 63 deny
cmd appops set md.obsidian 40 deny
cmd appops set com.talpa.hiservice 40 deny
cmd appops set com.talpa.hiservice 63 deny
cmd appops set com.transsion.phonemaster 40 deny
cmd appops set com.transsion.phonemaster 63 deny
cmd appops set com.android.providers.calendar 63 deny
cmd appops set com.android.providers.calendar 40 deny
cmd appops set com.transsion.manualguide 40 deny
cmd appops set com.transsion.manualguide 63 deny
cmd appops set com.google.android.apps.googleassistant 40 deny
cmd appops set com.google.android.apps.googleassistant 63 deny
cmd appops set in.krosbits.musicolet 63 deny
cmd appops set in.krosbits.musicolet 40 deny
pm disable in.krosbits.musicolet/androidx.work.impl.diagnostics.DiagnosticsReceiver
cmd appops set com.android.providers.media 63 deny
cmd appops set com.android.providers.media 40 deny
cmd appops set com.transsion.bookmarks 40 deny
cmd appops set com.transsion.bookmarks 63 deny
cmd appops set com.android.networkstack.tethering.overlay 63 deny
cmd appops set com.android.networkstack.tethering.overlay 40 deny
cmd appops set com.google.android.onetimeinitializer 40 deny
cmd appops set com.google.android.onetimeinitializer 63 deny
cmd appops set com.google.android.ext.shared 63 deny
cmd appops set com.google.android.ext.shared 40 deny
cmd appops set com.shazam.android 63 deny
cmd appops set com.shazam.android 40 deny
pm disable com.shazam.android/com.google.android.gms.measurement.AppMeasurementReceiver
pm disable com.shazam.android/com.google.android.gms.measurement.AppMeasurementService
pm disable com.shazam.android/androidx.work.impl.diagnostics.DiagnosticsReceiver
pm disable com.shazam.android/com.google.android.gms.measurement.AppMeasurementJobService
cmd appops set com.android.internal.systemui.navbar.gestural_wide_back 63 deny
cmd appops set com.android.internal.systemui.navbar.gestural_wide_back 40 deny
cmd appops set com.mediatek.location.lppe.main 63 deny
cmd appops set com.mediatek.location.lppe.main 40 deny
cmd appops set com.shopeepay.id 63 deny
cmd appops set com.shopeepay.id 40 deny
pm disable com.shopeepay.id/com.google.android.gms.measurement.AppMeasurementReceiver
pm disable com.shopeepay.id/com.google.android.gms.measurement.AppMeasurementService
pm disable com.shopeepay.id/androidx.work.impl.diagnostics.DiagnosticsReceiver
pm disable com.shopeepay.id/com.google.android.gms.measurement.AppMeasurementJobService
cmd appops set com.android.wallpapercropper 63 deny
cmd appops set com.android.wallpapercropper 40 deny
cmd appops set com.transsion.magicfont 40 deny
cmd appops set com.transsion.magicfont 63 deny
cmd appops set com.transsion.magicshow 40 deny
cmd appops set com.transsion.magicshow 63 deny
cmd appops set com.android.theme.icon.vessel 40 deny
cmd appops set com.android.theme.icon.vessel 63 deny
cmd appops set com.mediatek.schpwronoff 40 deny
cmd appops set com.mediatek.schpwronoff 63 deny
cmd appops set com.android.theme.color.cinnamon 40 deny
cmd appops set com.android.theme.color.cinnamon 63 deny
cmd appops set com.mediatek.SettingsProviderResOverlay 63 deny
cmd appops set com.mediatek.SettingsProviderResOverlay 40 deny
cmd appops set com.idea.questionnaire 40 deny
cmd appops set com.idea.questionnaire 63 deny
cmd appops set com.mediatek.gnss.nonframeworklbs 40 deny
cmd appops set com.mediatek.gnss.nonframeworklbs 63 deny
cmd appops set com.mediatek.systemuiresoverlay 63 deny
cmd appops set com.mediatek.systemuiresoverlay 40 deny
cmd appops set com.transsion.aivoiceassistant 40 deny
cmd appops set com.transsion.aivoiceassistant 63 deny
cmd appops set com.android.theme.icon_pack.rounded.systemui 40 deny
cmd appops set com.android.theme.icon_pack.rounded.systemui 63 deny
cmd appops set com.whatsapp 63 deny
cmd appops set com.whatsapp 40 deny
pm disable com.whatsapp/androidx.work.impl.diagnostics.DiagnosticsReceiver
cmd appops set com.android.networkstack.tethering.inprocess.overlay 63 deny
cmd appops set com.android.networkstack.tethering.inprocess.overlay 40 deny
cmd appops set com.android.theme.icon.taperedrect 40 deny
cmd appops set com.android.theme.icon.taperedrect 63 deny
cmd appops set com.transsion.agingfunction 40 deny
cmd appops set com.transsion.agingfunction 63 deny
cmd appops set com.android.wifi.resources.overlay 63 deny
cmd appops set com.android.wifi.resources.overlay 40 deny
cmd appops set com.android.cellbroadcast.overlay 40 deny
cmd appops set com.android.cellbroadcast.overlay 63 deny
cmd appops set com.android.externalstorage 63 deny
cmd appops set com.android.externalstorage 40 deny
cmd appops set com.mediatek.ygps 40 deny
cmd appops set com.mediatek.ygps 63 deny
cmd appops set com.mediatek.simprocessor 40 deny
cmd appops set com.mediatek.simprocessor 63 deny
cmd appops set com.android.htmlviewer 63 deny
cmd appops set com.android.htmlviewer 40 deny
cmd appops set com.android.companiondevicemanager 63 deny
cmd appops set com.android.companiondevicemanager 40 deny
cmd appops set jp.naver.line.android 63 deny
cmd appops set jp.naver.line.android 40 deny
cmd appops set com.android.bluetooth.auto_generated_rro_product__ 63 deny
cmd appops set com.android.bluetooth.auto_generated_rro_product__ 40 deny
cmd appops set com.google.android.apps.messaging 63 deny
cmd appops set com.google.android.apps.messaging 40 deny
pm disable com.google.android.apps.messaging/com.google.android.gms.measurement.AppMeasurementReceiver
pm disable com.google.android.apps.messaging/com.google.android.gms.measurement.AppMeasurementService
pm disable com.google.android.apps.messaging/androidx.work.impl.diagnostics.DiagnosticsReceiver
pm disable com.google.android.apps.messaging/com.google.android.gms.measurement.AppMeasurementJobService
pm disable com.google.android.apps.messaging/com.google.android.ims.service.JibeService
pm disable com.google.android.apps.messaging/com.google.android.apps.messaging.diagnostics.ui.DiagnosticsActivity
cmd appops set com.google.android.networkstack.tethering.overlay 63 deny
cmd appops set com.google.android.networkstack.tethering.overlay 40 deny
cmd appops set com.mediatek.engineermode 63 deny
cmd appops set com.mediatek.engineermode 40 deny
cmd appops set com.facemoji.lite.transsion 40 deny
cmd appops set com.facemoji.lite.transsion 63 deny
cmd appops set com.android.theme.icon_pack.rounded.android 40 deny
cmd appops set com.android.theme.icon_pack.rounded.android 63 deny
cmd appops set com.transsion.faceidsub 63 deny
cmd appops set com.transsion.faceidsub 40 deny
cmd appops set com.westalgo.factorycamera 40 deny
cmd appops set com.westalgo.factorycamera 63 deny
cmd appops set com.discord 63 deny
cmd appops set com.discord 40 deny
pm disable com.discord/com.google.android.gms.analytics.AnalyticsReceiver
pm disable com.discord/androidx.work.impl.diagnostics.DiagnosticsReceiver
pm disable com.discord/com.google.android.gms.analytics.AnalyticsJobService
pm disable com.discord/com.google.android.gms.analytics.AnalyticsService
cmd appops set uz.unnarsx.cherrygram 63 deny
cmd appops set uz.unnarsx.cherrygram 40 deny
pm disable uz.unnarsx.cherrygram/com.google.android.gms.measurement.AppMeasurementReceiver
pm disable uz.unnarsx.cherrygram/com.google.android.gms.measurement.AppMeasurementService
pm disable uz.unnarsx.cherrygram/com.google.android.gms.measurement.AppMeasurementJobService
cmd appops set com.mediatek.omacp 40 deny
cmd appops set com.mediatek.omacp 63 deny
cmd appops set app.komikku 63 deny
cmd appops set app.komikku 40 deny
pm disable app.komikku/com.google.android.gms.measurement.AppMeasurementReceiver
pm disable app.komikku/com.google.android.gms.measurement.AppMeasurementService
pm disable app.komikku/androidx.work.impl.diagnostics.DiagnosticsReceiver
pm disable app.komikku/com.google.android.gms.measurement.AppMeasurementJobService
cmd appops set com.mixplorer.silver 63 deny
cmd appops set com.mixplorer.silver 40 deny
cmd appops set com.android.networkstack.inprocess.overlay 63 deny
cmd appops set com.android.networkstack.inprocess.overlay 40 deny
cmd appops set com.android.systemui.os.overlay 63 deny
cmd appops set com.android.systemui.os.overlay 40 deny
cmd appops set com.transsion.overlaysuw.resoverlay 40 deny
cmd appops set com.transsion.overlaysuw.resoverlay 63 deny
cmd appops set com.android.theme.icon_pack.circular.themepicker 40 deny
cmd appops set com.android.theme.icon_pack.circular.themepicker 63 deny
cmd appops set com.google.android.configupdater 63 deny
cmd appops set com.google.android.configupdater 40 deny
cmd appops set com.transsion.dualapp 63 deny
cmd appops set com.transsion.dualapp 40 deny
cmd appops set com.google.android.providers.media.module 63 deny
cmd appops set com.google.android.providers.media.module 40 deny
cmd appops set com.google.android.overlay.modules.permissioncontroller 63 deny
cmd appops set com.google.android.overlay.modules.permissioncontroller 40 deny
cmd appops set com.infinix 63 deny
cmd appops set com.infinix 40 deny
cmd appops set com.google.ar.core 40 deny
cmd appops set com.google.ar.core 63 deny
cmd appops set com.android.vending 63 deny
cmd appops set com.android.vending 40 deny
pm disable com.android.vending/com.google.android.finsky.systemcomponentupdateui.common.SystemComponentUpdateActivity
pm disable com.android.vending/com.google.android.finsky.systemupdate.receivers.RebootReadinessReceiver
pm disable com.android.vending/com.google.android.finsky.systemupdateactivity.SystemUpdateActivity
pm disable com.android.vending/com.google.android.finsky.systemupdate.receivers.UnattendedUpdatePreparedReceiver
cmd appops set com.android.pacprocessor 63 deny
cmd appops set com.android.pacprocessor 40 deny
cmd appops set com.android.simappdialog 63 deny
cmd appops set com.android.simappdialog 40 deny
cmd appops set com.android.internal.display.cutout.emulation.hole 63 deny
cmd appops set com.android.internal.display.cutout.emulation.hole 40 deny
cmd appops set com.android.internal.display.cutout.emulation.tall 63 deny
cmd appops set com.android.internal.display.cutout.emulation.tall 40 deny
cmd appops set com.android.networkstack.overlay 63 deny
cmd appops set com.android.networkstack.overlay 40 deny
cmd appops set com.android.certinstaller 63 deny
cmd appops set com.android.certinstaller 40 deny
cmd appops set com.transsion.theme.icon 63 deny
cmd appops set com.transsion.theme.icon 40 deny
cmd appops set com.android.theme.color.black 40 deny
cmd appops set com.android.theme.color.black 63 deny
cmd appops set com.android.carrierconfig 63 deny
cmd appops set com.android.carrierconfig 40 deny
cmd appops set com.android.theme.color.green 40 deny
cmd appops set com.android.theme.color.green 63 deny
cmd appops set com.android.contacts 63 deny
cmd appops set com.android.contacts 40 deny
cmd appops set com.android.theme.icon_pack.rounded.launcher 40 deny
cmd appops set com.android.theme.icon_pack.rounded.launcher 63 deny
cmd appops set com.android.egg 40 deny
cmd appops set com.android.egg 63 deny
cmd appops set com.android.stk 40 deny
cmd appops set com.android.stk 63 deny
cmd appops set com.android.backupconfirm 63 deny
cmd appops set com.android.backupconfirm 40 deny
cmd appops set com.android.statementservice 63 deny
cmd appops set com.android.statementservice 40 deny
cmd appops set com.trassion.infinix.xclub 40 deny
cmd appops set com.trassion.infinix.xclub 63 deny
cmd appops set com.google.android.gm 63 deny
cmd appops set com.google.android.gm 40 deny
pm disable com.google.android.gm/androidx.work.impl.diagnostics.DiagnosticsReceiver
cmd appops set com.mediatek.mdmlsample 40 deny
cmd appops set com.mediatek.mdmlsample 63 deny
cmd appops set com.transsion.datatransfer 40 deny
cmd appops set com.transsion.datatransfer 63 deny
cmd appops set com.android.settings.intelligence 63 deny
cmd appops set com.android.settings.intelligence 40 deny
cmd appops set com.mediatek.frameworkresoverlay 63 deny
cmd appops set com.mediatek.frameworkresoverlay 40 deny
cmd appops set com.transsion.faceid 63 deny
cmd appops set com.transsion.faceid 40 deny
cmd appops set com.google.android.permissioncontroller 63 deny
cmd appops set com.google.android.permissioncontroller 40 deny
cmd appops set com.google.android.setupwizard 40 deny
cmd appops set com.google.android.setupwizard 63 deny
cmd appops set com.transsion.insync 40 deny
cmd appops set com.transsion.insync 63 deny
cmd appops set com.mediatek.batterywarning 40 deny
cmd appops set com.mediatek.batterywarning 63 deny
cmd appops set com.android.printspooler 63 deny
cmd appops set com.android.printspooler 40 deny
cmd appops set com.android.dreams.basic 40 deny
cmd appops set com.android.dreams.basic 63 deny
cmd appops set com.google.android.overlay.modules.ext.services 63 deny
cmd appops set com.google.android.overlay.modules.ext.services 40 deny
cmd appops set com.google.android.apps.wellbeing 40 deny
cmd appops set com.google.android.apps.wellbeing 63 deny
cmd appops set com.google.android.dialer 63 deny
cmd appops set com.google.android.dialer 40 deny
pm disable com.google.android.dialer/androidx.work.impl.diagnostics.DiagnosticsReceiver
cmd appops set com.google.android.apps.nbu.files 40 deny
cmd appops set com.google.android.apps.nbu.files 63 deny
cmd appops set com.google.android.captiveportallogin 63 deny
cmd appops set com.google.android.captiveportallogin 40 deny
cmd appops set com.android.theme.icon_pack.circular.settings 40 deny
cmd appops set com.android.theme.icon_pack.circular.settings 63 deny
cmd appops set com.google.android.apps.maps 63 deny
cmd appops set com.google.android.apps.maps 40 deny
pm disable com.google.android.apps.maps/androidx.work.impl.diagnostics.DiagnosticsReceiver
cmd appops set com.google.android.modulemetadata 63 deny
cmd appops set com.google.android.modulemetadata 40 deny
cmd appops set com.transsion.wezone 40 deny
cmd appops set com.transsion.wezone 63 deny
cmd appops set com.talpa.share 40 deny
cmd appops set com.talpa.share 63 deny
cmd appops set com.transsion.calendar 40 deny
cmd appops set com.transsion.calendar 63 deny
cmd appops set com.hoffnung 63 deny
cmd appops set com.hoffnung 40 deny
pm disable com.hoffnung/com.transsion.aibox.service.AiBoxService
cmd appops set com.android.cellbroadcastreceiver 63 deny
cmd appops set com.android.cellbroadcastreceiver 40 deny
cmd appops set com.google.android.webview 63 deny
cmd appops set com.google.android.webview 40 deny
cmd appops set com.transsion.zahooc 40 deny
cmd appops set com.transsion.zahooc 63 deny
cmd appops set com.google.android.syncadapters.contacts 63 deny
cmd appops set com.google.android.syncadapters.contacts 40 deny
cmd appops set com.google.android.calculator 63 deny
cmd appops set com.google.android.calculator 40 deny
cmd appops set com.google.android.packageinstaller 63 deny
cmd appops set com.google.android.packageinstaller 40 deny
cmd appops set com.transsion.childmode.resoverlay 40 deny
cmd appops set com.transsion.childmode.resoverlay 63 deny
cmd appops set com.transsion.applock 63 deny
cmd appops set com.transsion.applock 40 deny
pm disable com.transsion.applock/com.google.android.gms.measurement.AppMeasurementReceiver
pm disable com.transsion.applock/com.google.android.gms.measurement.AppMeasurementService
pm disable com.transsion.applock/com.google.android.gms.measurement.AppMeasurementJobService
pm disable com.transsion.applock/com.transsion.applock.activity.AdSettingActivity
cmd appops set com.google.android.gms 63 deny
cmd appops set com.google.android.gms 40 deny
pm disable com.google.android.gms/com.google.android.gms.analytics.AnalyticsTaskService
pm disable com.google.android.gms/com.google.android.gms.analytics.service.AnalyticsService
pm disable com.google.android.gms/com.google.android.gms.update.SystemUpdateActivity
pm disable com.google.android.gms/com.google.android.gms.analytics.AnalyticsReceiver
pm disable com.google.android.gms/com.google.android.gms.update.UpdateFromSdCardService
pm disable com.google.android.gms/com.google.android.gms.update.SystemUpdateGcmTaskService
pm disable com.google.android.gms/com.google.android.gms.update.phone.PopupDialog
pm disable com.google.android.gms/com.google.android.gms.update.UpdateFromSdCardActivity
pm disable com.google.android.gms/com.google.android.gms.update.OtaSuggestionActivity
pm disable com.google.android.gms/com.google.android.gms.analytics.AnalyticsService
pm disable com.google.android.gms/com.google.android.gms.measurement.service.MeasurementBrokerService
pm disable com.google.android.gms/com.google.android.gms.update.SystemUpdatePersistentListenerService
pm disable com.google.android.gms/com.google.android.gms.measurement.AppMeasurementReceiver
pm disable com.google.android.gms/com.google.android.gms.ads.AdRequestBrokerService
pm disable com.google.android.gms/com.google.android.gms.measurement.AppMeasurementService
pm disable com.google.android.gms/com.google.android.gms.measurement.PackageMeasurementService
pm disable com.google.android.gms/com.google.android.gms.measurement.PackageMeasurementTaskService
pm disable com.google.android.gms/com.google.android.gms.measurement.PackageMeasurementReceiver
pm disable com.google.android.gms/com.google.android.gms.measurement.AppMeasurementJobService
pm disable com.google.android.gms/com.google.android.gms.analytics.internal.PlayLogReportingService
pm disable com.google.android.gms/com.google.android.gms.update.SystemUpdateService
cmd appops set com.google.android.ims 40 deny
cmd appops set com.google.android.ims 63 deny
cmd appops set com.google.android.partnersetup 63 deny
cmd appops set com.google.android.partnersetup 40 deny
cmd appops set com.transsion.fmradio 40 deny
cmd appops set com.transsion.fmradio 63 deny
cmd appops set com.transsion.thunderback 63 deny
cmd appops set com.transsion.thunderback 40 deny
cmd appops set com.google.android.overlay.gmsconfig.gsa 40 deny
cmd appops set com.google.android.overlay.gmsconfig.gsa 63 deny
cmd appops set com.android.carrierdefaultapp 40 deny
cmd appops set com.android.carrierdefaultapp 63 deny
cmd appops set com.transsion.batterylab 40 deny
cmd appops set com.transsion.batterylab 63 deny
cmd appops set com.transsion.magazineservice.xos 40 deny
cmd appops set com.transsion.magazineservice.xos 63 deny
cmd appops set com.android.proxyhandler 63 deny
cmd appops set com.android.proxyhandler 40 deny
cmd appops set com.transsion.aftersalecalibrationtool 40 deny
cmd appops set com.transsion.aftersalecalibrationtool 63 deny
cmd appops set com.android.internal.display.cutout.emulation.waterfall 63 deny
cmd appops set com.android.internal.display.cutout.emulation.waterfall 40 deny
cmd appops set com.talpa.hibrowser 40 deny
cmd appops set com.talpa.hibrowser 63 deny
cmd appops set com.reallytek.wg 40 deny
cmd appops set com.reallytek.wg 63 deny
cmd appops set com.google.android.connectivity.resources 63 deny
cmd appops set com.google.android.connectivity.resources 40 deny
cmd appops set com.google.android.printservice.recommendation 63 deny
cmd appops set com.google.android.printservice.recommendation 40 deny
cmd appops set org.fossify.gallery 63 deny
cmd appops set org.fossify.gallery 40 deny
cmd appops set po.ncmw.dffeakwoywn 63 deny
cmd appops set po.ncmw.dffeakwoywn 40 deny
cmd appops set com.google.android.documentsui 63 deny
cmd appops set com.google.android.documentsui 40 deny
cmd appops set com.transsion.hamal 40 deny
cmd appops set com.transsion.hamal 63 deny
cmd appops set com.android.providers.partnerbookmarks 40 deny
cmd appops set com.android.providers.partnerbookmarks 63 deny
cmd appops set com.android.wallpaper.livepicker 40 deny
cmd appops set com.android.wallpaper.livepicker 63 deny
cmd appops set com.silead.factorytest 40 deny
cmd appops set com.silead.factorytest 63 deny
cmd appops set com.facebook.system 40 deny
cmd appops set com.facebook.system 63 deny
cmd appops set idm.internet.download.manager.plus 63 deny
cmd appops set idm.internet.download.manager.plus 40 deny
cmd appops set com.transsion.tabe 40 deny
cmd appops set com.transsion.tabe 63 deny
cmd appops set com.google.android.networkstack.overlay 63 deny
cmd appops set com.google.android.networkstack.overlay 40 deny
cmd appops set com.android.theme.icon_pack.filled.launcher 40 deny
cmd appops set com.android.theme.icon_pack.filled.launcher 63 deny
cmd appops set com.mediatek.mdmconfig 40 deny
cmd appops set com.mediatek.mdmconfig 63 deny
cmd appops set net.bat.store 40 deny
cmd appops set net.bat.store 63 deny
cmd appops set com.android.theme.icon_pack.circular.launcher 40 deny
cmd appops set com.android.theme.icon_pack.circular.launcher 63 deny
cmd appops set com.transsion.nephilim 40 deny
cmd appops set com.transsion.nephilim 63 deny
cmd appops set com.android.shell 63 deny
cmd appops set com.android.shell 40 deny
cmd appops set com.transsion.soundrecorder 40 deny
cmd appops set com.transsion.soundrecorder 63 deny
cmd appops set com.transsion.trancare 40 deny
cmd appops set com.transsion.trancare 63 deny
cmd appops set com.android.settings.auto_generated_rro_product__ 63 deny
cmd appops set com.android.settings.auto_generated_rro_product__ 40 deny
cmd appops set com.transsion.wifiplaytogether 40 deny
cmd appops set com.transsion.wifiplaytogether 63 deny
cmd appops set com.shopee.id 63 deny
cmd appops set com.shopee.id 40 deny
pm disable com.shopee.id/com.google.android.gms.measurement.AppMeasurementReceiver
pm disable com.shopee.id/com.google.android.gms.measurement.AppMeasurementService
pm disable com.shopee.id/androidx.work.impl.diagnostics.DiagnosticsReceiver
pm disable com.shopee.id/com.google.android.gms.measurement.AppMeasurementJobService
cmd appops set com.transsion.letswitch 40 deny
cmd appops set com.transsion.letswitch 63 deny
cmd appops set com.android.theme.color.orchid 40 deny
cmd appops set com.android.theme.color.orchid 63 deny
cmd appops set com.google.android.apps.youtube.music 63 deny
cmd appops set com.google.android.apps.youtube.music 40 deny
pm disable com.google.android.apps.youtube.music/com.google.android.gms.measurement.AppMeasurementReceiver
pm disable com.google.android.apps.youtube.music/com.google.android.gms.measurement.AppMeasurementService
pm disable com.google.android.apps.youtube.music/androidx.work.impl.diagnostics.DiagnosticsReceiver
pm disable com.google.android.apps.youtube.music/com.google.android.gms.measurement.AppMeasurementJobService
cmd appops set com.android.theme.color.purple 40 deny
cmd appops set com.android.theme.color.purple 63 deny
cmd appops set com.transsion.calculator 40 deny
cmd appops set com.transsion.calculator 63 deny
cmd appops set tech.palm.id 40 deny
cmd appops set tech.palm.id 63 deny
cmd appops set com.google.android.marvin.talkback 40 deny
cmd appops set com.google.android.marvin.talkback 63 deny
cmd appops set com.android.theme.color.ocean 40 deny
cmd appops set com.android.theme.color.ocean 63 deny
cmd appops set com.android.theme.color.space 40 deny
cmd appops set com.android.theme.color.space 63 deny
cmd appops set com.android.internal.systemui.navbar.threebutton 63 deny
cmd appops set com.android.internal.systemui.navbar.threebutton 40 deny
cmd appops set com.brave.browser 63 deny
cmd appops set com.brave.browser 40 deny
cmd appops set com.mediatek.emcamera 40 deny
cmd appops set com.mediatek.emcamera 63 deny
cmd appops set com.android.launcher3 63 deny
cmd appops set com.android.launcher3 40 deny
cmd appops set com.silead.fingerprint 40 deny
cmd appops set com.silead.fingerprint 63 deny
cmd appops set com.dergoogler.mmrl.wx 63 deny
cmd appops set com.dergoogler.mmrl.wx 40 deny
pm disable com.dergoogler.mmrl.wx/androidx.work.impl.diagnostics.DiagnosticsReceiver
cmd appops set com.transsion.camera 63 deny
cmd appops set com.transsion.camera 40 deny
pm disable com.transsion.camera/com.google.android.gms.measurement.AppMeasurementReceiver
pm disable com.transsion.camera/com.google.android.gms.measurement.AppMeasurementService
pm disable com.transsion.camera/com.google.android.gms.measurement.AppMeasurementJobService
pm disable com.transsion.camera/com.google.android.gms.measurement.AppMeasurementInstallReferrerReceiver
cmd appops set com.google.android.overlay.gmsconfig.common 63 deny
cmd appops set com.google.android.overlay.gmsconfig.common 40 deny
cmd appops set com.debug.loggerui 40 deny
cmd appops set com.debug.loggerui 63 deny
cmd appops set com.android.internal.systemui.navbar.gestural_extra_wide_back 63 deny
cmd appops set com.android.internal.systemui.navbar.gestural_extra_wide_back 40 deny
cmd appops set com.transsion.health 40 deny
cmd appops set com.transsion.health 63 deny
cmd appops set com.android.sharedstoragebackup 63 deny
cmd appops set com.android.sharedstoragebackup 40 deny
cmd appops set com.facebook.services 40 deny
cmd appops set com.facebook.services 63 deny
cmd appops set com.gallery20 40 deny
cmd appops set com.gallery20 63 deny
cmd appops set com.android.theme.icon_pack.filled.settings 40 deny
cmd appops set com.android.theme.icon_pack.filled.settings 63 deny
cmd appops set com.transsion.XOSLauncher 63 deny
cmd appops set com.transsion.XOSLauncher 40 deny
pm disable com.transsion.XOSLauncher/com.google.android.gms.measurement.AppMeasurementReceiver
pm disable com.transsion.XOSLauncher/com.facebook.CurrentAccessTokenExpirationBroadcastReceiver
pm disable com.transsion.XOSLauncher/com.google.android.gms.analytics.AnalyticsReceiver
pm disable com.transsion.XOSLauncher/com.google.android.gms.measurement.AppMeasurementService
pm disable com.transsion.XOSLauncher/com.transsion.theme.common.XThemeMain
pm disable com.transsion.XOSLauncher/com.google.android.gms.analytics.AnalyticsJobService
pm disable com.transsion.XOSLauncher/com.facebook.FacebookActivity
pm disable com.transsion.XOSLauncher/com.google.android.gms.measurement.AppMeasurementJobService
pm disable com.transsion.XOSLauncher/com.google.android.gms.measurement.AppMeasurementInstallReferrerReceiver
pm disable com.transsion.XOSLauncher/com.google.android.gms.analytics.AnalyticsService
cmd appops set com.android.mmitest 40 deny
cmd appops set com.android.mmitest 63 deny
cmd appops set com.scorpio.securitycom 63 deny
cmd appops set com.scorpio.securitycom 40 deny
cmd appops set com.transsion.phonemanager 40 deny
cmd appops set com.transsion.phonemanager 63 deny
cmd appops set com.google.android.trichromelibrary 63 deny
cmd appops set com.google.android.trichromelibrary 40 deny
cmd appops set com.android.se 63 deny
cmd appops set com.android.se 40 deny
cmd appops set com.funbase.xradio 40 deny
cmd appops set com.funbase.xradio 63 deny
cmd appops set com.android.bips 63 deny
cmd appops set com.android.bips 40 deny
cmd appops set com.android.musicfx 63 deny
cmd appops set com.android.musicfx 40 deny
cmd appops set com.transsion.filemanagerx 40 deny
cmd appops set com.transsion.filemanagerx 63 deny
cmd appops set com.android.theme.icon.teardrop 40 deny
cmd appops set com.android.theme.icon.teardrop 63 deny
cmd appops set com.rlk.weathers 40 deny
cmd appops set com.rlk.weathers 63 deny
cmd appops set com.android.theme.icon_pack.rounded.themepicker 40 deny
cmd appops set com.android.theme.icon_pack.rounded.themepicker 63 deny
cmd appops set com.android.chrome 40 deny
cmd appops set com.android.chrome 63 deny
cmd appops set com.transsion.childmode 40 deny
cmd appops set com.transsion.childmode 63 deny
cmd appops set com.transsion.carlcare 40 deny
cmd appops set com.transsion.carlcare 63 deny
cmd appops set com.android.theme.icon_pack.filled.systemui 40 deny
cmd appops set com.android.theme.icon_pack.filled.systemui 63 deny
cmd appops set com.google.android.overlay.modules.packageinstaller 63 deny
cmd appops set com.google.android.overlay.modules.packageinstaller 40 deny
cmd appops set com.google.android.tts 40 deny
cmd appops set com.google.android.tts 63 deny
cmd appops set com.android.wifi.resources 63 deny
cmd appops set com.android.wifi.resources 40 deny
cmd appops set com.android.calllogbackup 40 deny
cmd appops set com.android.calllogbackup 63 deny
cmd appops set com.android.theme.font.notoserifsource 63 deny
cmd appops set com.android.theme.font.notoserifsource 40 deny
cmd appops set com.android.theme.icon_pack.filled.android 40 deny
cmd appops set com.android.theme.icon_pack.filled.android 63 deny
cmd appops set com.transsion.scanningrecharger 40 deny
cmd appops set com.transsion.scanningrecharger 63 deny
cmd appops set com.google.android.feedback 40 deny
cmd appops set com.google.android.feedback 63 deny
cmd appops set com.android.theme.icon_pack.circular.systemui 40 deny
cmd appops set com.android.theme.icon_pack.circular.systemui 63 deny
cmd appops set io.github.muntashirakon.AppManager 63 deny
cmd appops set io.github.muntashirakon.AppManager 40 deny
cmd appops set com.google.android.overlay.modules.permissioncontroller.forframework 63 deny
cmd appops set com.google.android.overlay.modules.permissioncontroller.forframework 40 deny
cmd appops set com.google.android.calendar 63 deny
cmd appops set com.google.android.calendar 40 deny
pm disable com.google.android.calendar/androidx.work.impl.diagnostics.DiagnosticsReceiver
cmd appops set com.android.managedprovisioning 63 deny
cmd appops set com.android.managedprovisioning 40 deny
cmd appops set com.transsion.repaircard 40 deny
cmd appops set com.transsion.repaircard 63 deny
cmd appops set com.google.mainline.telemetry 40 deny
cmd appops set com.google.mainline.telemetry 63 deny
cmd appops set com.mediatek.callrecorder 63 deny
cmd appops set com.mediatek.callrecorder 40 deny
cmd appops set com.transsion.overlaysuw 40 deny
cmd appops set com.transsion.overlaysuw 63 deny
cmd appops set com.facebook.lite 63 deny
cmd appops set com.facebook.lite 40 deny
pm disable com.facebook.lite/com.facebook.analyticslite.memory.MemoryDumpUploadService
pm disable com.facebook.lite/com.facebook.analytics2.logger.legacy.uploader.Analytics2UploadService
pm disable com.facebook.lite/com.facebook.ads.AudienceNetworkActivity
pm disable com.facebook.lite/com.facebook.analytics2.logger.service.LollipopUploadSafeService
pm disable com.facebook.lite/com.facebook.analytics2.logger.legacy.uploader.LollipopUploadService
pm disable com.facebook.lite/com.facebook.analytics2.logger.legacy.uploader.AlarmBasedUploadService
pm disable com.facebook.lite/com.facebook.analytics2.logger.legacy.uploader.HighPriUploadRetryReceiver
cmd appops set com.mediatek.gnssdebugreport 40 deny
cmd appops set com.mediatek.gnssdebugreport 63 deny
cmd appops set com.android.settings.os.overlay 63 deny
cmd appops set com.android.settings.os.overlay 40 deny
cmd appops set com.transsnet.store 40 deny
cmd appops set com.transsnet.store 63 deny
cmd appops set com.android.theme.icon.squircle 40 deny
cmd appops set com.android.theme.icon.squircle 63 deny
cmd appops set com.android.storagemanager 63 deny
cmd appops set com.android.storagemanager 40 deny
cmd appops set com.transsion.teop 40 deny
cmd appops set com.transsion.teop 63 deny
cmd appops set com.android.bookmarkprovider 63 deny
cmd appops set com.android.bookmarkprovider 40 deny
cmd appops set com.theme.icondefaultshape 63 deny
cmd appops set com.theme.icondefaultshape 40 deny
cmd appops set com.itc.autotest 40 deny
cmd appops set com.itc.autotest 63 deny
cmd appops set com.google.android.projection.gearhead 40 deny
cmd appops set com.google.android.projection.gearhead 63 deny
cmd appops set android.autoinstalls.config.transsion.device 40 deny
cmd appops set android.autoinstalls.config.transsion.device 63 deny
cmd appops set com.mediatek.lbs.em2.ui 40 deny
cmd appops set com.mediatek.lbs.em2.ui 63 deny
cmd appops set com.android.cts.ctsshim 40 deny
cmd appops set com.android.cts.ctsshim 63 deny
cmd appops set com.google.android.overlay.modules.modulemetadata.forframework 63 deny
cmd appops set com.google.android.overlay.modules.modulemetadata.forframework 40 deny
cmd appops set com.sh.smart.caller 40 deny
cmd appops set com.sh.smart.caller 63 deny
cmd appops set com.android.vpndialogs 63 deny
cmd appops set com.android.vpndialogs 40 deny
cmd appops set com.transsion.systemupdate 40 deny
cmd appops set com.transsion.systemupdate 63 deny
cmd appops set com.android.theme.icon_pack.filled.themepicker 40 deny
cmd appops set com.android.theme.icon_pack.filled.themepicker 63 deny
cmd appops set com.android.wallpaperbackup 40 deny
cmd appops set com.android.wallpaperbackup 63 deny
cmd appops set com.android.providers.blockednumber 63 deny
cmd appops set com.android.providers.blockednumber 40 deny
cmd appops set com.garena.game.df 63 deny
cmd appops set com.garena.game.df 40 deny
cmd appops set com.android.emergency 40 deny
cmd appops set com.android.emergency 63 deny
cmd appops set com.transsion.livewallpaper.voyage 40 deny
cmd appops set com.transsion.livewallpaper.voyage 63 deny
cmd appops set com.android.hotspot2.osulogin 63 deny
cmd appops set com.android.hotspot2.osulogin 40 deny
cmd appops set com.google.android.gms.location.history 40 deny
cmd appops set com.google.android.gms.location.history 63 deny
cmd appops set com.android.internal.systemui.navbar.gestural 63 deny
cmd appops set com.android.internal.systemui.navbar.gestural 40 deny
cmd appops set com.facebook.appmanager 40 deny
cmd appops set com.facebook.appmanager 63 deny
cmd appops set com.transsion.notebook 40 deny
cmd appops set com.transsion.notebook 63 deny
cmd appops set android.auto_generated_rro_product__ 63 deny
cmd appops set android.auto_generated_rro_product__ 40 deny
cmd appops set com.android.internal.systemui.navbar.gestural_narrow_back 63 deny
cmd appops set com.android.internal.systemui.navbar.gestural_narrow_back 40 deny
cmd appops set com.transsion.dtsaudio 40 deny
cmd appops set com.transsion.dtsaudio 63 deny
cmd appops set com.google.android.cellbroadcastreceiver 63 deny
cmd appops set com.google.android.cellbroadcastreceiver 40 deny
cmd appops set com.android.bluetooth 63 deny
cmd appops set com.android.bluetooth 40 deny
cmd appops set com.android.wallpaperpicker 63 deny
cmd appops set com.android.wallpaperpicker 40 deny
cmd appops set com.transsion.mol 40 deny
cmd appops set com.transsion.mol 63 deny
cmd appops set com.transsion.chromecustomization 40 deny
cmd appops set com.transsion.chromecustomization 63 deny
cmd appops set com.franco.kernel 40 deny
cmd appops set com.franco.kernel 63 deny
pm disable com.franco.kernel/androidx.work.impl.diagnostics.DiagnosticsReceiver
cmd appops set com.aaudio.forwarder 40 deny
cmd appops set com.aaudio.forwarder 63 deny
cmd appops set eu.kanade.tachiyomi.extension.all.comicklive 40 deny
cmd appops set eu.kanade.tachiyomi.extension.all.comicklive 63 deny
cmd appops set eu.kanade.tachiyomi.extension.id.shinigami 40 deny
cmd appops set eu.kanade.tachiyomi.extension.id.shinigami 63 deny
cmd appops set eu.kanade.tachiyomi.extension.id.komikcast 40 deny
cmd appops set eu.kanade.tachiyomi.extension.id.komikcast 63 deny
cmd appops set eu.kanade.tachiyomi.extension.all.mangapark 40 deny
cmd appops set eu.kanade.tachiyomi.extension.all.mangapark 63 deny
cmd appops set eu.kanade.tachiyomi.extension.id.doujindesu 40 deny
cmd appops set eu.kanade.tachiyomi.extension.id.doujindesu 63 deny
cmd appops set com.android.theme.icon_pack.rounded.settings 40 deny
cmd appops set com.android.theme.icon_pack.rounded.settings 63 deny
cmd appops set com.instagram.lite 63 deny
cmd appops set com.instagram.lite 40 deny
pm disable com.instagram.lite/com.facebook.analyticslite.memory.MemoryDumpUploadService
pm disable com.instagram.lite/com.facebook.analytics2.logger.legacy.uploader.Analytics2UploadService
pm disable com.instagram.lite/com.facebook.analytics2.logger.service.LollipopUploadSafeService
pm disable com.instagram.lite/com.facebook.analytics2.logger.legacy.uploader.LollipopUploadService
pm disable com.instagram.lite/com.facebook.analytics2.logger.legacy.uploader.AlarmBasedUploadService
pm disable com.instagram.lite/com.facebook.analytics2.logger.legacy.uploader.HighPriUploadRetryReceiver
cmd appops set com.android.theme.icon_pack.circular.android 40 deny
cmd appops set com.android.theme.icon_pack.circular.android 63 deny
cmd appops set com.google.android.keep 40 deny
cmd appops set com.google.android.keep 63 deny
pm disable com.google.android.keep/androidx.work.impl.diagnostics.DiagnosticsReceiver
cmd appops set ch.protonvpn.android 40 deny
cmd appops set ch.protonvpn.android 63 deny
pm disable ch.protonvpn.android/androidx.work.impl.diagnostics.DiagnosticsReceiver
cmd appops set com.rom1v.sndcpy 40 deny
cmd appops set com.rom1v.sndcpy 63 deny
cmd appops set eu.kanade.tachiyomi.extension.id.komikav 40 deny
cmd appops set eu.kanade.tachiyomi.extension.id.komikav 63 deny
cmd appops set eu.kanade.tachiyomi.extension.id.kiryuu 40 deny
cmd appops set eu.kanade.tachiyomi.extension.id.kiryuu 63 deny
cmd appops set eu.kanade.tachiyomi.extension.all.nhentai 40 deny
cmd appops set eu.kanade.tachiyomi.extension.all.nhentai 63 deny
cmd appops set eu.kanade.tachiyomi.extension.all.hentaifox 40 deny
cmd appops set eu.kanade.tachiyomi.extension.all.hentaifox 63 deny
cmd appops set eu.kanade.tachiyomi.extension.all.hitomi 40 deny
cmd appops set eu.kanade.tachiyomi.extension.all.hitomi 63 deny
cmd appops set com.android.bluetoothmidiservice 40 deny
cmd appops set com.android.bluetoothmidiservice 63 deny
cmd appops set com.transsion.beezedit 40 deny
cmd appops set com.transsion.beezedit 63 deny
cmd appops set com.android.traceur 40 deny
cmd appops set com.android.traceur 63 deny
cmd appops set com.transsion.sk 40 deny
cmd appops set com.transsion.sk 63 deny
cmd appops set com.android.theme.icon.roundedrect 40 deny
cmd appops set com.android.theme.icon.roundedrect 63 deny
cmd appops set com.transsion.kolun.assistant 40 deny
cmd appops set com.transsion.kolun.assistant 63 deny
cmd appops set com.google.android.inputmethod.latin 63 deny
cmd appops set com.google.android.inputmethod.latin 40 deny
pm disable com.google.android.inputmethod.latin/androidx.work.impl.diagnostics.DiagnosticsReceiver
pm disable com.transsion.videocallenhancer/com.google.android.gms.measurement.AppMeasurementReceiver
pm disable com.transsion.videocallenhancer/com.google.android.gms.measurement.AppMeasurementService
pm disable com.transsion.videocallenhancer/com.google.android.gms.measurement.AppMeasurementJobService
pm disable com.transsion.videocallenhancer/com.google.android.gms.measurement.AppMeasurementInstallReferrerReceiver
cmd appops set eu.kanade.tachiyomi.extension.en.kaliscanio 40 deny
cmd appops set eu.kanade.tachiyomi.extension.en.kaliscanio 63 deny
cmd appops set com.google.android.apps.restore 40 deny
cmd appops set com.google.android.apps.restore 63 deny
pm disable com.transsion.smartpanel/com.transsion.gamemode.video.activity.AppManagementActivity
pm disable com.transsion.smartpanel/com.transsion.gamemode.activity.VerifyQuestionActivity
pm disable com.transsion.smartpanel/com.transsion.gamemode.activity.MainSettingsActivity
pm disable com.transsion.smartpanel/com.transsion.gamemode.activity.RestrictedListActivity
pm disable com.transsion.smartpanel/com.transsion.gamemode.activity.GameManageActivity
pm disable com.transsion.smartpanel/com.transsion.gamemode.activity.AvailableTimeActivity
pm disable com.transsion.smartpanel/com.transsion.gamemode.activity.EtEngineActivity
pm disable com.transsion.smartpanel/com.transsion.gamemode.activity.AntiAddictionActivity
pm disable com.transsion.smartpanel/com.google.android.gms.measurement.AppMeasurementReceiver
pm disable com.transsion.smartpanel/com.transsion.gamemode.appscheduling.AppSchedulingActivity
pm disable com.transsion.smartpanel/com.transsion.gamemode.video.activity.VideoMainActivity
pm disable com.transsion.smartpanel/com.google.android.gms.measurement.AppMeasurementInstallReferrerReceiver
pm disable com.transsion.smartpanel/com.transsion.smartpanel.gamemode.magicbutton.teach.MagicButtonTeachActivity
pm disable com.transsion.smartpanel/com.transsion.gamemode.service.GameModeService
pm disable com.transsion.smartpanel/com.transsion.gamemode.activity.AdvancedActivity
pm disable com.transsion.smartpanel/com.transsion.gamemode.activity.ParentalControlActivity
pm disable com.transsion.smartpanel/com.transsion.gamemode.activity.NotificationModeActivity
pm disable com.transsion.smartpanel/com.transsion.gamemode.activity.SetPasswordActivity
pm disable com.transsion.smartpanel/com.transsion.gamemode.activity.GameDataTimeActivity
pm disable com.transsion.smartpanel/com.transsion.gamemode.gamedata.ViewAllDataActivity
pm disable com.transsion.smartpanel/com.google.android.gms.measurement.AppMeasurementService
pm disable com.transsion.smartpanel/com.transsion.gamemode.activity.GameSpaceActivity
pm disable com.transsion.smartpanel/com.transsion.gamemode.activity.ReverseColorActivity
pm disable com.transsion.smartpanel/com.transsion.gamemode.activity.PqeSettingsActivity
pm disable com.transsion.smartpanel/com.transsion.gamemode.activity.FreefromSettingsActivity
pm disable com.transsion.smartpanel/com.google.android.gms.measurement.AppMeasurementJobService
pm disable com.transsion.smartpanel/com.transsion.gamemode.gamedata.DataMainActivity
pm disable com.transsion.smartpanel/com.transsion.gamemode.activity.SafeQuestionActivity
cmd appops set com.android.sound.helper 40 deny
cmd appops set com.android.sound.helper 63 deny
cmd appops set eu.kanade.tachiyomi.extension.id.westmanga 40 deny
cmd appops set eu.kanade.tachiyomi.extension.id.westmanga 63 deny
cmd appops set com.supercell.clashroyale 40 deny
cmd appops set com.supercell.clashroyale 63 deny

pm disable com.facebook.katana/com.facebook.analytics2.logger.GooglePlayUploadService
pm disable com.facebook.katana/com.facebook.audiencenetwork.AudienceNetworkService
pm disable com.facebook.katana/com.facebook.adinterfaces.service.BoostLiveService
pm disable com.facebook.katana/com.facebook.feed.platformads.AppInstallReceiver
pm disable com.facebook.katana/com.facebook.googleplay.GooglePlayInstallReferrerReceiver
pm disable com.facebook.katana/.provider.AttributionIdProvider
pm disable com.facebook.katana/.provider.InstallReferrerProvider
pm disable com.facebook.katana/com.facebook.oxygen.preloads.integration.dogfooding.AppManagerSsoProvider
pm disable com.facebook.katana/com.facebook.oxygen.preloads.integration.sso.PostInstallSsoReceiver
pm disable com.facebook.katana/com.facebook.oxygen.preloads.sdk.firstparty.managedappcache.IsManagedAppReceiver
pm disable com.facebook.katana/com.facebook.bugreporter.core.scheduler.GCMBugReportService
pm disable com.facebook.katana/com.facebook.bugreporter.core.scheduler.AlarmsBroadcastReceiver
pm disable com.facebook.katana/com.facebook.errorreporting.lacrima.detector.broadcast.ProtectedLockScreenBroadcastReceiver
pm disable com.facebook.katana/com.facebook.errorreporting.lacrima.detector.broadcast.PublicLockScreenBroadcastReceiver
pm disable com.facebook.katana/com.facebook.errorreporting.lacrima.detector.broadcast.SecureShutdownBootBroadcastReceiver
pm disable com.facebook.katana/com.facebook.abtest.qe.db.QuickExperimentContentProvider
pm disable com.facebook.katana/com.facebook.rti.orca.UpdateQeBroadcastReceiver
pm disable com.facebook.katana/com.facebook.wearlistener.DataLayerListenerService
pm disable com.facebook.katana/com.facebook.fbpay.w3c.ipc.FBPaymentServiceImpl
pm disable com.facebook.katana/com.facebook.fbpay.w3c.views.PaymentActivity
pm disable com.facebook.katana/com.facebook.adinterfaces.AdInterfacesObjectiveActivity
pm disable com.facebook.katana/com.facebook.conditionalworker.GooglePlayConditionalWorkerService
pm disable com.facebook.katana/com.facebook.conditionalworker.ConditionalWorkerServiceReceiver
pm disable com.facebook.katana/com.facebook.languages.switcher.nonworkactivity.LanguageSwitchPromotionActivity
pm disable com.facebook.katana/com.facebook.deeplinking.aliasactivity.OpcAcceleratorOnboardingAliasActivity
pm disable com.facebook.katana/com.facebook.contacts.data.FbContactsContentProvider
pm disable com.facebook.katana/com.facebook.contacts.provider.ContactsConnectionsProvider
pm disable com.facebook.katana/com.facebook.contacts.service.ContactLocaleChangeReceiver
pm disable com.facebook.katana/com.facebook.battery.monitor.ContinuousBatteryMonitorService\$BroadcastReceiver
pm disable com.facebook.katana/com.facebook.ppml.receiver.ReceiverService
pm disable com.facebook.katana/com.facebook.games.gamingservices.deeplink.GamingServicesDeeplinkActivity
pm disable com.facebook.katana/com.facebook.huddle.notification.speakernotification.impl.HuddleLiveSessionNotificationService
pm disable com.facebook.katana/com.facebook.facecast.broadcast.notifications.LiveAudioRoomV2NotificationService
pm disable com.facebook.katana/com.facebook.notifications.appwidget.MediumNotificationsWidgetProvider
pm disable com.facebook.katana/com.facebook.notifications.appwidget.SmallNotificationsWidgetProvider
pm disable com.facebook.katana/com.facebook.notifications.appwidget.receiver.NotificationsWidgetAppUpgradeReceiver
pm disable com.facebook.katana/com.facebook.video.watchandgo.service.WatchAndGoService
pm disable com.facebook.katana/com.facebook.video.watchandgo.service.UnifiedMiniPlayerService
pm disable com.facebook.katana/com.facebook.smartglasses.intenthandler.OptInActivity
pm disable com.facebook.katana/com.facebook.wearlistener.DataLayerListenerService
pm disable com.facebook.katana/androidx.work.impl.background.systemalarm.ConstraintProxy$BatteryChargingProxy
pm disable com.facebook.katana/androidx.work.impl.background.systemalarm.ConstraintProxy$NetworkStateProxy
pm disable com.facebook.katana/com.facebook.photos.upload.receiver.ConnectivityChangeReceiver
pm disable com.facebook.katana/com.facebook.conditionalworker.GooglePlayConditionalWorkerService
pm disable com.facebook.katana/com.facebook.media.local.UpdateLocalMediaStoreGcmTaskService
cmd appops set com.facebook.katana 40 deny
cmd appops set com.facebook.katana 63 deny

echo "Rules Applied." >> "$LOG_FILE"

exit 0
