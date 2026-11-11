#!/bin/bash
# GameZone project generator v6
set -e
mkdir -p "."
cat > "settings.gradle.kts" <<'GZEOF'
pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}
rootProject.name = "GameZone"
include(":app")
GZEOF
mkdir -p "."
cat > "build.gradle.kts" <<'GZEOF'
plugins {
    id("com.android.application") version "8.5.2" apply false
    id("org.jetbrains.kotlin.android") version "2.0.20" apply false
    id("org.jetbrains.kotlin.plugin.compose") version "2.0.20" apply false
}
GZEOF
mkdir -p "."
cat > "gradle.properties" <<'GZEOF'
org.gradle.jvmargs=-Xmx3g -Dfile.encoding=UTF-8
android.useAndroidX=true
kotlin.code.style=official
GZEOF
mkdir -p "app"
cat > "app/build.gradle.kts" <<'GZEOF'
plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("org.jetbrains.kotlin.plugin.compose")
}

android {
    namespace = "com.example.gamezone"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.gamezone"
        minSdk = 29
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions { jvmTarget = "17" }
    buildFeatures { compose = true }
}

dependencies {
    implementation(platform("androidx.compose:compose-bom:2024.09.00"))
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.foundation:foundation")
    implementation("androidx.compose.material3:material3")
    implementation("androidx.activity:activity-compose:1.9.2")
    implementation("androidx.core:core-ktx:1.13.1")
    implementation("dev.rikka.shizuku:api:13.1.5")
    implementation("dev.rikka.shizuku:provider:13.1.5")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.8.1")
}
GZEOF
mkdir -p "app/src/main"
cat > "app/src/main/AndroidManifest.xml" <<'GZEOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">

    <uses-permission android:name="android.permission.ACCESS_NOTIFICATION_POLICY" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.CHANGE_WIFI_STATE" />
    <uses-permission android:name="android.permission.WAKE_LOCK" />
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE_SPECIAL_USE" />
    <uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
    <uses-permission android:name="android.permission.VIBRATE" />
    <uses-permission android:name="android.permission.KILL_BACKGROUND_PROCESSES" />
    <uses-permission android:name="android.permission.PACKAGE_USAGE_STATS"
        tools:ignore="ProtectedPermissions" />
    <uses-permission android:name="android.permission.WRITE_SETTINGS"
        tools:ignore="ProtectedPermissions" />

    <queries>
        <package android:name="moe.shizuku.privileged.api" />
        <intent>
            <action android:name="android.intent.action.MAIN" />
            <category android:name="android.intent.category.LAUNCHER" />
        </intent>
    </queries>

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:theme="@android:style/Theme.Material.NoActionBar">

        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>

        <provider
            android:name="rikka.shizuku.ShizukuProvider"
            android:authorities="${applicationId}.shizuku"
            android:enabled="true"
            android:exported="true"
            android:multiprocess="false"
            android:permission="android.permission.INTERACT_ACROSS_USERS_FULL" />

        <service
            android:name=".GameModeService"
            android:exported="false"
            android:foregroundServiceType="specialUse">
            <property
                android:name="android.app.PROPERTY_SPECIAL_USE_FGS_SUBTYPE"
                android:value="game_mode_dnd_thermal_monitor" />
        </service>
    </application>
</manifest>
GZEOF
mkdir -p "app/src/main/res/values"
cat > "app/src/main/res/values/strings.xml" <<'GZEOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">करण बूस्टर</string>
</resources>
GZEOF
mkdir -p "app/src/main/res/values"
cat > "app/src/main/res/values/colors.xml" <<'GZEOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="ic_launcher_background">#000000</color>
</resources>
GZEOF
mkdir -p "app/src/main/res/drawable"
cat > "app/src/main/res/drawable/ic_launcher_foreground.xml" <<'GZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="108dp"
    android:height="108dp"
    android:viewportWidth="108"
    android:viewportHeight="108">
    <!-- सफेद गोल रिंग -->
    <path
        android:pathData="M54,26 a28,28 0 1,1 0,56 a28,28 0 1,1 0,-56"
        android:strokeColor="#FFFFFF"
        android:strokeWidth="4"
        android:fillColor="#00000000" />
    <!-- सफेद बिजली (बूस्ट) -->
    <path
        android:pathData="M60,32 L43,57 L53,57 L48,78 L67,50 L56,50 Z"
        android:fillColor="#FFFFFF" />
</vector>
GZEOF
mkdir -p "app/src/main/res/drawable"
cat > "app/src/main/res/drawable/ic_stat_bolt.xml" <<'GZEOF'
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="24dp"
    android:height="24dp"
    android:viewportWidth="24"
    android:viewportHeight="24">
    <path
        android:pathData="M13,2 L5,13 L11,13 L9,22 L19,10 L13,10 Z"
        android:fillColor="#FFFFFF" />
</vector>
GZEOF
mkdir -p "app/src/main/res/mipmap-anydpi-v26"
cat > "app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml" <<'GZEOF'
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@color/ic_launcher_background" />
    <foreground android:drawable="@drawable/ic_launcher_foreground" />
    <monochrome android:drawable="@drawable/ic_launcher_foreground" />
</adaptive-icon>
GZEOF
mkdir -p "app/src/main/java/com/example/gamezone"
cat > "app/src/main/java/com/example/gamezone/MainActivity.kt" <<'GZEOF'
package com.example.gamezone

import android.Manifest
import android.app.NotificationManager
import android.content.Context
import android.content.Intent
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.widget.Toast
import androidx.activity.ComponentActivity
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.compose.setContent
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.Image
import androidx.compose.foundation.clickable
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.grid.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.ImageBitmap
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.core.content.ContextCompat
import androidx.core.graphics.drawable.toBitmap
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import rikka.shizuku.Shizuku

class MainActivity : ComponentActivity() {
    private val tick = mutableIntStateOf(0)
    private val permListener = Shizuku.OnRequestPermissionResultListener { _, _ ->
        tick.intValue = tick.intValue + 1
    }
    private val binderListener = Shizuku.OnBinderReceivedListener {
        tick.intValue = tick.intValue + 1
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            Shizuku.addRequestPermissionResultListener(permListener)
            Shizuku.addBinderReceivedListenerSticky(binderListener)
        } catch (e: Throwable) {
        }
        setContent {
            MaterialTheme(colorScheme = darkColorScheme()) {
                Surface(Modifier.fillMaxSize()) { GameScreen(tick.intValue) }
            }
        }
    }

    override fun onResume() {
        super.onResume()
        tick.intValue++   // सेटिंग्स से लौटने पर परमिशन दोबारा जाँचने के लिए
    }

    override fun onDestroy() {
        try {
            Shizuku.removeRequestPermissionResultListener(permListener)
            Shizuku.removeBinderReceivedListener(binderListener)
        } catch (e: Throwable) {
        }
        super.onDestroy()
    }
}

data class GameApp(val label: String, val pkg: String, val icon: ImageBitmap)

@Composable
fun GameScreen(tick: Int) {
    val ctx = LocalContext.current
    val scope = rememberCoroutineScope()
    val on by GameModeService.running.collectAsState()
    val thermal by GameModeService.thermalStatus.collectAsState()
    val cleanMsg by GameModeService.cleanMsg.collectAsState()
    var games by remember { mutableStateOf<List<GameApp>>(emptyList()) }
    var today by remember { mutableStateOf<Map<String, Long>>(emptyMap()) }
    var week by remember { mutableStateOf<Map<String, Long>>(emptyMap()) }

    val dndOk = ctx.getSystemService(NotificationManager::class.java).isNotificationPolicyAccessGranted
    val overlayOk = Settings.canDrawOverlays(ctx)
    val usageOk = Booster.hasUsageAccess(ctx)
    val writeOk = Settings.System.canWrite(ctx)
    val pkgUri = Uri.parse("package:${ctx.packageName}")
    val prefs = ctx.getSharedPreferences("gz", Context.MODE_PRIVATE)
    var strict by remember { mutableStateOf(prefs.getBoolean("strict", false)) }
    var showTips by remember { mutableStateOf(false) }
    val shizukuInstalled = ctx.packageManager.getLaunchIntentForPackage(SHIZUKU_PKG) != null
    val shizukuRunning = Shell.running()
    val shizukuOk = Shell.available()

    LaunchedEffect(Unit) { games = withContext(Dispatchers.IO) { loadGames(ctx) } }

    LaunchedEffect(tick) {
        if (Booster.hasUsageAccess(ctx)) {
            val (t, w) = withContext(Dispatchers.IO) {
                Booster.usageMinutes(ctx, Booster.startOfToday()) to
                    Booster.usageMinutes(ctx, System.currentTimeMillis() - 7L * 24 * 3600 * 1000)
            }
            today = t
            week = w
        }
    }

    val notifPermission = rememberLauncherForActivityResult(
        ActivityResultContracts.RequestPermission()
    ) { startGameMode(ctx, null) }

    if (showTips) TipsDialog { showTips = false }

    LazyVerticalGrid(
        columns = GridCells.Fixed(3),
        modifier = Modifier.fillMaxSize().statusBarsPadding().padding(16.dp),
        horizontalArrangement = Arrangement.spacedBy(8.dp),
        verticalArrangement = Arrangement.spacedBy(12.dp)
    ) {
        item(span = { GridItemSpan(maxLineSpan) }) {
            Text("करण बूस्टर", style = MaterialTheme.typography.headlineMedium)
        }

        // गेमिंग मोड स्विच
        item(span = { GridItemSpan(maxLineSpan) }) {
            Card(Modifier.fillMaxWidth()) {
                Row(Modifier.padding(16.dp), verticalAlignment = Alignment.CenterVertically) {
                    Column(Modifier.weight(1f)) {
                        Text("गेमिंग मोड", style = MaterialTheme.typography.titleMedium)
                        Text(
                            if (on) "ON: DND, ओवरले, स्मार्ट गार्ड (गर्मी + लैग) चालू" else "OFF",
                            style = MaterialTheme.typography.bodySmall
                        )
                        if (on) Text("फोन: ${thermalLabel(thermal)}", style = MaterialTheme.typography.bodySmall)
                        if (on && overlayOk) Text("💡 गेम में दाएँ किनारे (बीच) की हल्की पट्टी पर बाएँ स्वाइप करो", style = MaterialTheme.typography.labelSmall)
                    }
                    Switch(checked = on, onCheckedChange = { checked ->
                        if (checked) {
                            val needsNotif = Build.VERSION.SDK_INT >= 33 &&
                                ctx.checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) !=
                                PackageManager.PERMISSION_GRANTED
                            if (needsNotif) notifPermission.launch(Manifest.permission.POST_NOTIFICATIONS)
                            else startGameMode(ctx, null)
                        } else {
                            ctx.startService(
                                Intent(ctx, GameModeService::class.java).setAction(GameModeService.ACTION_STOP)
                            )
                        }
                    })
                }
            }
        }

        // परमिशन्स
        item(span = { GridItemSpan(maxLineSpan) }) {
            Card(Modifier.fillMaxWidth()) {
                Column(Modifier.padding(12.dp)) {
                    Text("परमिशन्स (एक बार देनी हैं)", style = MaterialTheme.typography.titleSmall)
                    PermRow("DND (नोटिफिकेशन म्यूट)", dndOk) {
                        ctx.startActivity(Intent(Settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS))
                    }
                    PermRow("ओवरले (गेम के ऊपर तापमान/बैटरी)", overlayOk) {
                        ctx.startActivity(Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION, pkgUri))
                    }
                    PermRow("यूसेज एक्सेस (गेम का समय)", usageOk) {
                        ctx.startActivity(Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS))
                    }
                    PermRow("चमक कंट्रोल (गर्म होने पर घटाना)", writeOk) {
                        ctx.startActivity(Intent(Settings.ACTION_MANAGE_WRITE_SETTINGS, pkgUri))
                    }
                }
            }
        }

        // Shizuku: असली force-stop और Game Mode
        item(span = { GridItemSpan(maxLineSpan) }) {
            Card(Modifier.fillMaxWidth()) {
                Column(Modifier.padding(12.dp)) {
                    Text("असली बूस्ट (Shizuku)", style = MaterialTheme.typography.titleSmall)
                    when {
                        shizukuOk -> {
                            Text("✅ तैयार: असली force-stop और Game Mode Performance चालू",
                                style = MaterialTheme.typography.bodySmall)
                            Row(verticalAlignment = Alignment.CenterVertically) {
                                Text("सख्त सफाई (force-stop)", Modifier.weight(1f),
                                    style = MaterialTheme.typography.bodySmall)
                                Switch(checked = strict, onCheckedChange = { v ->
                                    strict = v
                                    prefs.edit().putBoolean("strict", v).apply()
                                })
                            }
                            Text("ध्यान: बंद किए ऐप्स (जैसे WhatsApp) नया मैसेज तभी दिखाएँगे जब उन्हें दोबारा खोलो",
                                style = MaterialTheme.typography.labelSmall)
                        }
                        shizukuRunning -> {
                            Text("Shizuku चालू है, बस परमिशन चाहिए", style = MaterialTheme.typography.bodySmall)
                            Button(onClick = { Shell.requestPermission() }) { Text("परमिशन दो") }
                        }
                        shizukuInstalled -> {
                            Text("Shizuku इंस्टॉल है पर चालू नहीं। खोलकर 'Start via Wireless debugging' दबाओ",
                                style = MaterialTheme.typography.bodySmall)
                            Button(onClick = {
                                ctx.packageManager.getLaunchIntentForPackage(SHIZUKU_PKG)?.let { ctx.startActivity(it) }
                            }) { Text("Shizuku खोलो") }
                        }
                        else -> {
                            Text("Shizuku इंस्टॉल नहीं है (मुफ्त ऐप)", style = MaterialTheme.typography.bodySmall)
                            Button(onClick = {
                                ctx.startActivity(Intent(Intent.ACTION_VIEW,
                                    Uri.parse("https://play.google.com/store/apps/details?id=$SHIZUKU_PKG")))
                            }) { Text("Shizuku इंस्टॉल करो") }
                        }
                    }
                }
            }
        }

        // साइड पट्टी की सेटिंग (जगह, लंबाई, पारदर्शिता)
        item(span = { GridItemSpan(maxLineSpan) }) {
            var side by remember(tick) { mutableStateOf(prefs.getString("h_side", "R") ?: "R") }
            var yPct by remember(tick) { mutableFloatStateOf(prefs.getInt("h_y", 50).toFloat()) }
            var len by remember(tick) { mutableFloatStateOf(prefs.getInt("h_len", 200).toFloat()) }
            var vis by remember(tick) { mutableFloatStateOf(prefs.getInt("h_alpha", 20).toFloat()) }
            fun save() {
                prefs.edit().putString("h_side", side).putInt("h_y", yPct.toInt())
                    .putInt("h_len", len.toInt()).putInt("h_alpha", vis.toInt()).apply()
                if (on) ctx.startService(
                    Intent(ctx, GameModeService::class.java).setAction(GameModeService.ACTION_REFRESH)
                )
            }
            Card(Modifier.fillMaxWidth()) {
                Column(Modifier.padding(12.dp)) {
                    Text("साइड पट्टी (स्वाइप से बूस्टर खोलो)", style = MaterialTheme.typography.titleSmall)
                    Text("गेम में पट्टी को देर तक दबाकर इधर-उधर खींच भी सकते हो",
                        style = MaterialTheme.typography.labelSmall)
                    Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                        if (side == "L") Button(onClick = {}) { Text("बाएँ ✓") }
                        else OutlinedButton(onClick = { side = "L"; save() }) { Text("बाएँ") }
                        if (side == "R") Button(onClick = {}) { Text("दाएँ ✓") }
                        else OutlinedButton(onClick = { side = "R"; save() }) { Text("दाएँ") }
                    }
                    Text("ऊपर-नीचे जगह: ${yPct.toInt()}%", style = MaterialTheme.typography.bodySmall)
                    Slider(value = yPct, onValueChange = { yPct = it },
                        onValueChangeFinished = { save() }, valueRange = 5f..95f)
                    Text("लंबाई: ${len.toInt()}", style = MaterialTheme.typography.bodySmall)
                    Slider(value = len, onValueChange = { len = it },
                        onValueChangeFinished = { save() }, valueRange = 100f..400f)
                    Text("पट्टी कितनी दिखे: ${vis.toInt()}%", style = MaterialTheme.typography.bodySmall)
                    Slider(value = vis, onValueChange = { vis = it },
                        onValueChangeFinished = { save() }, valueRange = 5f..80f)
                }
            }
        }

        // रैम सफाई
        item(span = { GridItemSpan(maxLineSpan) }) {
            Column {
                Button(onClick = {
                    scope.launch {
                        GameModeService.cleanMsg.value = "रैम साफ हो रही है..."
                        GameModeService.cleanMsg.value = Booster.cleanBackground(ctx, null)
                    }
                }) { Text("🧹 बैकग्राउंड ऐप्स साफ करो") }
                OutlinedButton(onClick = { showTips = true }) { Text("🚀 FPS बढ़ाने के असली टिप्स") }
                if (cleanMsg.isNotEmpty()) Text(cleanMsg, style = MaterialTheme.typography.bodySmall)
            }
        }

        item(span = { GridItemSpan(maxLineSpan) }) {
            val total = games.sumOf { today[it.pkg] ?: 0L }
            Text(
                if (usageOk) "मेरे गेम्स (आज कुल: ${fmt(total)})" else "मेरे गेम्स",
                style = MaterialTheme.typography.titleMedium
            )
        }

        items(games, key = { it.pkg }) { game ->
            Column(
                Modifier.clickable {
                    // टैप करते ही गेमिंग मोड ON; Shizuku हो तो Game Mode Performance; फिर गेम खुलेगा
                    if (startGameMode(ctx, game.pkg)) {
                        scope.launch {
                            withContext(Dispatchers.IO) { Shell.setGameMode(game.pkg, "performance") }
                            ctx.packageManager.getLaunchIntentForPackage(game.pkg)?.let { ctx.startActivity(it) }
                        }
                    }
                },
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                Image(game.icon, game.label, Modifier.size(56.dp))
                Text(game.label, maxLines = 1, overflow = TextOverflow.Ellipsis,
                    style = MaterialTheme.typography.labelSmall)
                if (usageOk) Text(
                    "आज ${fmt(today[game.pkg] ?: 0L)}\nहफ्ता ${fmt(week[game.pkg] ?: 0L)}",
                    style = MaterialTheme.typography.labelSmall,
                    textAlign = TextAlign.Center
                )
            }
        }
    }
}

const val SHIZUKU_PKG = "moe.shizuku.privileged.api"

@Composable
fun TipsDialog(onClose: () -> Unit) {
    val tips = listOf(
        "गेम की सेटिंग में ग्राफिक्स 'Smooth' रखो, रेज़ॉल्यूशन और शैडो कम करो। FPS बढ़ाने का यह सबसे असरदार तरीका है।",
        "फोन की सेटिंग्स > डिस्प्ले में रिफ्रेश रेट हाई (90/120Hz) रखो। 60Hz पर लॉक हो तो गेम उससे ऊपर नहीं जाएगा।",
        "Battery saver / Power saving मोड बंद रखो। यह CPU की स्पीड घटा देता है।",
        "फोन को ठंडा रखो: कवर हटाओ, चार्जिंग के साथ मत खेलो, धूप से बचो। गर्म होने पर फोन खुद FPS घटा देता है, यही सबसे बड़ी वजह है।",
        "स्टोरेज में कम से कम 10% जगह खाली रखो और गेम/सिस्टम अपडेट रखो।",
        "ऑनलाइन गेम में Wi-Fi (5GHz) बेहतर है और राउटर के पास बैठो। इससे पिंग/लैग घटता है।",
        "Android 12+ फोन में Game Mode / Game Dashboard होता है (Samsung में Game Launcher)। वहाँ गेम के लिए Performance चुनो। Shizuku चालू हो तो GameZone यह खुद कर देता है।"
    )
    AlertDialog(
        onDismissRequest = onClose,
        confirmButton = { TextButton(onClick = onClose) { Text("ठीक है") } },
        title = { Text("FPS बढ़ाने के असली तरीके") },
        text = {
            Column(Modifier.verticalScroll(rememberScrollState())) {
                tips.forEach {
                    Text("• $it", style = MaterialTheme.typography.bodySmall)
                    Spacer(Modifier.height(8.dp))
                }
            }
        }
    )
}

@Composable
fun PermRow(text: String, ok: Boolean, onClick: () -> Unit) {
    Row(Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
        Text(text, Modifier.weight(1f), style = MaterialTheme.typography.bodySmall)
        if (ok) Text("✅") else TextButton(onClick = onClick) { Text("दो") }
    }
}

fun fmt(min: Long) = if (min >= 60) "${min / 60}घं ${min % 60}मि" else "${min}मि"

/** गेमिंग मोड चालू करता है। DND परमिशन न हो तो सेटिंग्स खोलकर false लौटाता है */
fun startGameMode(ctx: Context, gamePkg: String?): Boolean {
    val nm = ctx.getSystemService(NotificationManager::class.java)
    if (!nm.isNotificationPolicyAccessGranted) {
        Toast.makeText(ctx, "करण बूस्टर को DND की परमिशन दो, फिर वापस आओ", Toast.LENGTH_LONG).show()
        ctx.startActivity(Intent(Settings.ACTION_NOTIFICATION_POLICY_ACCESS_SETTINGS))
        return false
    }
    val i = Intent(ctx, GameModeService::class.java)
    gamePkg?.let { i.putExtra(GameModeService.EXTRA_GAME, it) }
    ContextCompat.startForegroundService(ctx, i)
    return true
}

fun thermalLabel(status: Int) = when (status) {
    0 -> "ठंडा ✅"
    1 -> "हल्का गर्म"
    2 -> "गर्म ⚠️"
    else -> "बहुत गर्म 🔥"
}

fun loadGames(ctx: Context): List<GameApp> {
    val pm = ctx.packageManager
    val intent = Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_LAUNCHER)
    val infos = pm.queryIntentActivities(intent, 0)
        .map { it.activityInfo.applicationInfo }
        .distinctBy { it.packageName }
        .filter { it.packageName != ctx.packageName }

    // कई गेम्स में category सेट नहीं होती, तब सारे ऐप्स दिखाते हैं
    val games = infos.filter { it.category == ApplicationInfo.CATEGORY_GAME }
    val list = if (games.isEmpty()) infos else games

    return list.map {
        GameApp(
            pm.getApplicationLabel(it).toString(),
            it.packageName,
            pm.getApplicationIcon(it).toBitmap(96, 96).asImageBitmap()
        )
    }.sortedBy { it.label.lowercase() }
}
GZEOF
mkdir -p "app/src/main/java/com/example/gamezone"
cat > "app/src/main/java/com/example/gamezone/GameModeService.kt" <<'GZEOF'
package com.example.gamezone

import android.app.ActivityManager
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.ServiceInfo
import android.content.res.Configuration
import android.graphics.Color
import android.graphics.PixelFormat
import android.net.wifi.WifiManager
import android.os.BatteryManager
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.os.PowerManager
import android.os.VibrationEffect
import android.os.Vibrator
import android.provider.Settings
import android.view.Gravity
import android.view.MotionEvent
import android.view.View
import android.view.WindowManager
import android.widget.Button
import android.widget.LinearLayout
import android.widget.TextView
import androidx.core.app.NotificationCompat
import androidx.core.app.ServiceCompat
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch

class GameModeService : Service() {

    companion object {
        const val ACTION_STOP = "com.example.gamezone.STOP"
        const val ACTION_REFRESH = "com.example.gamezone.REFRESH"
        const val EXTRA_GAME = "game_pkg"
        private const val CHANNEL_ID = "game_mode"
        private const val NOTIF_ID = 1

        private val _running = MutableStateFlow(false)
        val running: StateFlow<Boolean> = _running

        private val _thermal = MutableStateFlow(0)
        val thermalStatus: StateFlow<Int> = _thermal

        val cleanMsg = MutableStateFlow("")
    }

    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.Main)
    private val handler = Handler(Looper.getMainLooper())
    private var overlay: TextView? = null
    private var handle: View? = null
    private var handleLp: WindowManager.LayoutParams? = null
    private var panel: LinearLayout? = null
    private var currentGame: String? = null
    private var wifiLock: WifiManager.WifiLock? = null
    private var previousFilter = NotificationManager.INTERRUPTION_FILTER_ALL
    private var dndChanged = false
    private var thermalListener: PowerManager.OnThermalStatusChangedListener? = null
    private var perfGame: String? = null
    private var savedBrightness = -1
    private var savedMode = Settings.System.SCREEN_BRIGHTNESS_MODE_MANUAL

    private var heatLevel = 0
    private var lastPlugged = false
    private var lastClean = 0L

    private val guard = object : Runnable {
        override fun run() {
            guardTick()
            handler.postDelayed(this, 3000)
        }
    }

    private val ticker = object : Runnable {
        override fun run() {
            overlay?.text = overlayText()
            overlay?.setTextColor(
                when (heatLevel) {
                    0 -> Color.WHITE
                    1 -> Color.YELLOW
                    else -> 0xFFFF6B6B.toInt()
                }
            )
            handler.postDelayed(this, 2000)
        }
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (intent?.action == ACTION_STOP) {
            stopSelf()
            return START_NOT_STICKY
        }
        if (intent?.action == ACTION_REFRESH) {
            // पट्टी की सेटिंग बदली: पट्टी दोबारा बनाओ
            if (_running.value) {
                removeHandle()
                showHandle()
            } else {
                stopSelf()
            }
            return START_NOT_STICKY
        }
        val game = intent?.getStringExtra(EXTRA_GAME)
        if (game != null) currentGame = game

        if (!_running.value) {
            createChannel()
            val type = if (Build.VERSION.SDK_INT >= 34)
                ServiceInfo.FOREGROUND_SERVICE_TYPE_SPECIAL_USE else 0
            ServiceCompat.startForeground(this, NOTIF_ID, buildNotification("गेमिंग मोड ON"), type)
            enableDnd()
            lockWifi()
            watchThermal()
            showOverlay()
            showHandle()
            handler.post(guard)
            _running.value = true
        }

        if (game != null && Build.VERSION.SDK_INT >= 31 && Shell.available()) perfGame = game
        scope.launch {
            cleanMsg.value = "रैम साफ हो रही है..."
            var msg = Booster.cleanBackground(this@GameModeService, game)
            if (perfGame != null) msg += "\nGame Mode: Performance ✅ (असर के लिए गेम एक बार दोबारा खोलना पड़ सकता है)"
            cleanMsg.value = msg
        }
        return START_NOT_STICKY
    }

    private fun enableDnd() {
        val nm = getSystemService(NotificationManager::class.java)
        if (nm.isNotificationPolicyAccessGranted) {
            previousFilter = nm.currentInterruptionFilter
            nm.setInterruptionFilter(NotificationManager.INTERRUPTION_FILTER_ALARMS)
            dndChanged = true
        }
    }

    private fun lockWifi() {
        val wm = applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager
        wifiLock = wm.createWifiLock(WifiManager.WIFI_MODE_FULL_LOW_LATENCY, "gamezone:wifi")
            .apply {
                setReferenceCounted(false)
                acquire()
            }
    }

    private fun watchThermal() {
        val pm = getSystemService(PowerManager::class.java)
        val listener = PowerManager.OnThermalStatusChangedListener { status ->
            _thermal.value = status
            guardTick()
        }
        thermalListener = listener
        pm.addThermalStatusListener(listener)
        _thermal.value = pm.currentThermalStatus
    }

    /**
     * स्मार्ट गार्ड: हर 3 सेकंड में तापमान, थर्मल स्टेटस, रैम और चार्जिंग जाँचता है।
     * गर्मी के 3 स्तर: 1 हल्की, 2 गर्म, 3 बहुत गर्म। हर स्तर पर चमक घटती है (स्क्रीन गर्मी का बड़ा कारण है)।
     * रैम कम हो तो अपने आप सफाई (लैग कम करने के लिए)।
     */
    private fun guardTick() {
        val b = registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
        val temp = (b?.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, 0) ?: 0) / 10f
        val plugged = (b?.getIntExtra(BatteryManager.EXTRA_PLUGGED, 0) ?: 0) != 0
        val th = _thermal.value
        val level = when {
            temp >= 44f || th >= PowerManager.THERMAL_STATUS_SEVERE -> 3
            temp >= 41f || th >= PowerManager.THERMAL_STATUS_MODERATE -> 2
            temp >= 38f || th >= PowerManager.THERMAL_STATUS_LIGHT -> 1
            else -> 0
        }
        if (level != heatLevel || plugged != lastPlugged) {
            if (level > heatLevel) vibrateOnce()
            heatLevel = level
            lastPlugged = plugged
            applyBrightness(level)
            val base = listOf(
                "गेमिंग मोड ON",
                "🌡 हल्की गर्मी: चमक थोड़ी घटाई",
                "⚠️ फोन गर्म: चमक घटाई, गेम की ग्राफिक्स कम करो",
                "🔥 बहुत गर्म! गेम रोककर फोन को ठंडा होने दो"
            )[level]
            val text = if (plugged && level >= 1) "$base · चार्जर निकालो" else base
            getSystemService(NotificationManager::class.java)
                .notify(NOTIF_ID, buildNotification(text))
        }

        // रैम 12% से कम हो तो अपने आप सफाई (2 मिनट में एक बार से ज़्यादा नहीं)
        val mi = ActivityManager.MemoryInfo()
        getSystemService(ActivityManager::class.java).getMemoryInfo(mi)
        val freePct = mi.availMem * 100 / mi.totalMem
        val now = System.currentTimeMillis()
        if (freePct < 12 && now - lastClean > 120_000) {
            lastClean = now
            scope.launch {
                cleanMsg.value = "रैम कम थी, अपने आप साफ की: " +
                    Booster.cleanBackground(this@GameModeService, currentGame)
            }
        }
    }

    private fun vibrateOnce() {
        try {
            getSystemService(Vibrator::class.java)
                .vibrate(VibrationEffect.createOneShot(300, VibrationEffect.DEFAULT_AMPLITUDE))
        } catch (e: Exception) {
        }
    }

    /** स्तर 0 = चमक वापस, 1/2/3 = चमक 80% / 60% / 35% (कम से कम 20) */
    private fun applyBrightness(level: Int) {
        if (!Settings.System.canWrite(this)) return
        if (level == 0) {
            restoreBrightness()
            return
        }
        val cr = contentResolver
        if (savedBrightness < 0) {
            savedBrightness = Settings.System.getInt(cr, Settings.System.SCREEN_BRIGHTNESS, 128)
            savedMode = Settings.System.getInt(
                cr, Settings.System.SCREEN_BRIGHTNESS_MODE,
                Settings.System.SCREEN_BRIGHTNESS_MODE_MANUAL
            )
            Settings.System.putInt(
                cr, Settings.System.SCREEN_BRIGHTNESS_MODE,
                Settings.System.SCREEN_BRIGHTNESS_MODE_MANUAL
            )
        }
        val factor = floatArrayOf(1f, 0.8f, 0.6f, 0.35f)[level]
        Settings.System.putInt(
            cr, Settings.System.SCREEN_BRIGHTNESS,
            (savedBrightness * factor).toInt().coerceAtLeast(20)
        )
    }

    private fun restoreBrightness() {
        if (savedBrightness < 0 || !Settings.System.canWrite(this)) return
        val cr = contentResolver
        Settings.System.putInt(cr, Settings.System.SCREEN_BRIGHTNESS, savedBrightness)
        Settings.System.putInt(cr, Settings.System.SCREEN_BRIGHTNESS_MODE, savedMode)
        savedBrightness = -1
    }

    private fun showOverlay() {
        if (!Settings.canDrawOverlays(this)) return
        val tv = TextView(this).apply {
            setTextColor(Color.WHITE)
            textSize = 11f
            setPadding(16, 8, 16, 8)
            setBackgroundColor(0x99000000.toInt())
            text = overlayText()
        }
        val lp = WindowManager.LayoutParams(
            WindowManager.LayoutParams.WRAP_CONTENT,
            WindowManager.LayoutParams.WRAP_CONTENT,
            WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY,
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or
                WindowManager.LayoutParams.FLAG_NOT_TOUCHABLE or
                WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS,
            PixelFormat.TRANSLUCENT
        ).apply {
            gravity = Gravity.TOP or Gravity.START
            x = 10
            y = 80
        }
        getSystemService(WindowManager::class.java).addView(tv, lp)
        overlay = tv
        handler.postDelayed(ticker, 2000)
    }

    private fun dp(v: Int) = (v * resources.displayMetrics.density).toInt()

    override fun onConfigurationChanged(newConfig: Configuration) {
        super.onConfigurationChanged(newConfig)
        if (_running.value) {
            closePanel()
            removeHandle()
            showHandle()
        }
    }

    /**
     * किनारे की पतली पट्टी: अंदर की तरफ स्वाइप करो या टैप करो तो बूस्टर पैनल खुलता है।
     * पट्टी को देर तक दबाकर इधर-उधर (ऊपर-नीचे, बाएँ-दाएँ किनारे) खींचकर रख सकते हो।
     * जगह, लंबाई और पारदर्शिता ऐप की सेटिंग में भी बदल सकते हो।
     */
    private fun showHandle() {
        if (!Settings.canDrawOverlays(this)) return
        val prefs = getSharedPreferences("gz", Context.MODE_PRIVATE)
        val onRight = prefs.getString("h_side", "R") != "L"
        val yPct = prefs.getInt("h_y", 50)
        val lenDp = prefs.getInt("h_len", 200)
        val opacity = prefs.getInt("h_alpha", 20)
        val screenH = resources.displayMetrics.heightPixels
        val normalColor = ((opacity * 255 / 100) shl 24) or 0x00FFFFFF
        val v = View(this).apply { setBackgroundColor(normalColor) }

        var startX = 0f
        var fired = false
        var dragging = false
        val longPress = Runnable {
            dragging = true
            v.setBackgroundColor(0xAAFFFFFF.toInt())
            vibrateOnce()
        }
        v.setOnTouchListener { _, e ->
            when (e.actionMasked) {
                MotionEvent.ACTION_DOWN -> {
                    startX = e.rawX
                    fired = false
                    dragging = false
                    handler.postDelayed(longPress, 450)
                }
                MotionEvent.ACTION_MOVE -> {
                    if (dragging) {
                        moveHandle(e.rawX, e.rawY)
                    } else if (Math.abs(e.rawX - startX) > dp(10)) {
                        handler.removeCallbacks(longPress)
                        if (!fired && Math.abs(e.rawX - startX) > dp(24)) {
                            fired = true
                            togglePanel()
                        }
                    }
                }
                MotionEvent.ACTION_UP, MotionEvent.ACTION_CANCEL -> {
                    handler.removeCallbacks(longPress)
                    if (dragging) {
                        dragging = false
                        v.setBackgroundColor(normalColor)
                        saveHandlePos(e.rawX, e.rawY)
                    } else if (!fired && e.actionMasked == MotionEvent.ACTION_UP &&
                        Math.abs(e.rawX - startX) < dp(8)
                    ) {
                        togglePanel()
                    }
                }
            }
            true
        }

        val lp = WindowManager.LayoutParams(
            dp(28), dp(lenDp),
            WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY,
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or
                WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS,
            PixelFormat.TRANSLUCENT
        ).apply {
            gravity = (if (onRight) Gravity.END else Gravity.START) or Gravity.CENTER_VERTICAL
            y = (yPct - 50) * screenH / 100
        }
        getSystemService(WindowManager::class.java).addView(v, lp)
        handle = v
        handleLp = lp
    }

    private fun moveHandle(rawX: Float, rawY: Float) {
        val lp = handleLp ?: return
        val dm = resources.displayMetrics
        val onRight = rawX >= dm.widthPixels / 2f
        lp.gravity = (if (onRight) Gravity.END else Gravity.START) or Gravity.CENTER_VERTICAL
        lp.y = (rawY - dm.heightPixels / 2f).toInt()
        handle?.let {
            try { getSystemService(WindowManager::class.java).updateViewLayout(it, lp) } catch (e: Exception) {}
        }
    }

    private fun saveHandlePos(rawX: Float, rawY: Float) {
        val dm = resources.displayMetrics
        val side = if (rawX >= dm.widthPixels / 2f) "R" else "L"
        val y = (rawY * 100f / dm.heightPixels).toInt().coerceIn(5, 95)
        getSharedPreferences("gz", Context.MODE_PRIVATE).edit()
            .putString("h_side", side).putInt("h_y", y).apply()
    }

    private fun removeHandle() {
        handle?.let {
            try { getSystemService(WindowManager::class.java).removeView(it) } catch (e: Exception) {}
        }
        handle = null
        handleLp = null
    }

    private fun togglePanel() {
        if (panel != null) {
            closePanel()
            return
        }
        val box = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(dp(16), dp(12), dp(16), dp(12))
            setBackgroundColor(0xEE1B1B1F.toInt())
        }
        val info = TextView(this).apply {
            setTextColor(Color.WHITE)
            textSize = 13f
            text = overlayText()
        }
        box.addView(info)

        fun addButton(label: String, action: () -> Unit) {
            box.addView(Button(this).apply {
                text = label
                setOnClickListener { action() }
            })
        }
        addButton("🧹 रैम साफ करो") {
            scope.launch {
                info.text = "रैम साफ हो रही है..."
                val m = Booster.cleanBackground(this@GameModeService, currentGame)
                cleanMsg.value = m
                info.text = overlayText() + "\n" + m
            }
        }
        addButton("🔴 गेमिंग मोड बंद करो") {
            closePanel()
            stopSelf()
        }
        addButton("✕ पैनल बंद करो") { closePanel() }

        val lp = WindowManager.LayoutParams(
            dp(270), WindowManager.LayoutParams.WRAP_CONTENT,
            WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY,
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or
                WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL,
            PixelFormat.TRANSLUCENT
        ).apply {
            val panelRight = getSharedPreferences("gz", Context.MODE_PRIVATE).getString("h_side", "R") != "L"
            gravity = (if (panelRight) Gravity.END else Gravity.START) or Gravity.CENTER_VERTICAL
            x = dp(36)
        }
        getSystemService(WindowManager::class.java).addView(box, lp)
        panel = box
    }

    private fun closePanel() {
        panel?.let {
            try { getSystemService(WindowManager::class.java).removeView(it) } catch (e: Exception) {}
        }
        panel = null
    }

    private fun overlayText(): String {
        val b = registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
        val temp = (b?.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, 0) ?: 0) / 10f
        val level = b?.getIntExtra(BatteryManager.EXTRA_LEVEL, 0) ?: 0
        val mi = ActivityManager.MemoryInfo()
        getSystemService(ActivityManager::class.java).getMemoryInfo(mi)
        val plugged = (b?.getIntExtra(BatteryManager.EXTRA_PLUGGED, 0) ?: 0) != 0
        val warn = if (plugged && heatLevel >= 1) "\n🔌 चार्जर निकालो (चार्जिंग से गर्मी बढ़ती है)" else ""
        return "🔋 $level%   🌡 ${temp}°C\nरैम खाली: ${mi.availMem / 1048576} MB\nफोन: ${thermalLabel(_thermal.value)}$warn"
    }

    private fun createChannel() {
        val channel = NotificationChannel(
            CHANNEL_ID, "Game Mode", NotificationManager.IMPORTANCE_LOW
        )
        getSystemService(NotificationManager::class.java).createNotificationChannel(channel)
    }

    private fun buildNotification(text: String): Notification {
        val stopIntent = PendingIntent.getService(
            this, 0,
            Intent(this, GameModeService::class.java).setAction(ACTION_STOP),
            PendingIntent.FLAG_IMMUTABLE
        )
        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setSmallIcon(R.drawable.ic_stat_bolt)
            .setContentTitle("करण बूस्टर")
            .setContentText(text)
            .setOngoing(true)
            .addAction(0, "बंद करो", stopIntent)
            .build()
    }

    override fun onDestroy() {
        scope.cancel()
        handler.removeCallbacks(ticker)
        handler.removeCallbacks(guard)
        overlay?.let {
            try { getSystemService(WindowManager::class.java).removeView(it) } catch (e: Exception) {}
        }
        overlay = null
        closePanel()
        removeHandle()
        restoreBrightness()
        if (dndChanged) {
            val nm = getSystemService(NotificationManager::class.java)
            if (nm.isNotificationPolicyAccessGranted) nm.setInterruptionFilter(previousFilter)
        }
        wifiLock?.let { if (it.isHeld) it.release() }
        thermalListener?.let { getSystemService(PowerManager::class.java).removeThermalStatusListener(it) }
        perfGame?.let { p -> Thread { Shell.setGameMode(p, "standard") }.start() }
        perfGame = null
        _running.value = false
        _thermal.value = 0
        super.onDestroy()
    }
}
GZEOF
mkdir -p "app/src/main/java/com/example/gamezone"
cat > "app/src/main/java/com/example/gamezone/Booster.kt" <<'GZEOF'
package com.example.gamezone

import android.app.ActivityManager
import android.app.AppOpsManager
import android.content.Context
import android.content.Intent
import android.os.Process
import android.app.usage.UsageEvents
import android.app.usage.UsageStatsManager
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.withContext
import java.util.Calendar

object Booster {

    // इन नामों वाले ऐप्स कभी force-stop नहीं होते (अलार्म, कॉल, SMS, कीबोर्ड, सिस्टम)
    private val NEVER_STOP = listOf(
        "clock", "alarm", "dialer", "phone", "telecom", "contacts", "messag", "mms",
        "systemui", "inputmethod", "keyboard", "launcher", "settings", "bluetooth", "nfc"
    )

    /** बैकग्राउंड में पड़े ऐप्स के प्रोसेस बंद करता है (गेम और होम स्क्रीन को छोड़कर) */
    suspend fun cleanBackground(ctx: Context, exclude: String?): String = withContext(Dispatchers.IO) {
        val am = ctx.getSystemService(ActivityManager::class.java)
        val pm = ctx.packageManager
        fun avail(): Long {
            val mi = ActivityManager.MemoryInfo()
            am.getMemoryInfo(mi)
            return mi.availMem
        }
        val before = avail()
        val home = pm.resolveActivity(
            Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_HOME), 0
        )?.activityInfo?.packageName
        val launcher = Intent(Intent.ACTION_MAIN).addCategory(Intent.CATEGORY_LAUNCHER)
        val fg = foregroundPackage(ctx)
        val pkgs = pm.queryIntentActivities(launcher, 0)
            .map { it.activityInfo.packageName }
            .distinct()
            .filter { it != ctx.packageName && it != exclude && it != home && it != fg }
        val strict = ctx.getSharedPreferences("gz", Context.MODE_PRIVATE)
            .getBoolean("strict", false) && Shell.available() && (exclude != null || fg != null)
        val count: Int
        if (strict) {
            // असली force-stop (Shizuku से), ज़रूरी सिस्टम/अलार्म/डायलर ऐप्स छोड़कर
            val targets = pkgs.filter { p -> Shell.safe(p) && NEVER_STOP.none { p.contains(it) } }
            if (targets.isNotEmpty()) Shell.run(targets.joinToString("; ") { "am force-stop $it" })
            count = targets.size
        } else {
            pkgs.forEach { am.killBackgroundProcesses(it) }
            count = pkgs.size
        }
        delay(800)
        val freedMb = (avail() - before) / 1048576
        val how = if (strict) "असली बंद (force-stop)" else "साफ"
        if (freedMb > 0) "$count ऐप्स $how, करीब $freedMb MB रैम खाली हुई"
        else "$count ऐप्स $how (रैम पहले से ठीक थी, ज़्यादा फर्क नहीं पड़ा)"
    }

    /** अभी स्क्रीन पर सबसे ऊपर कौन सा ऐप है (यूसेज एक्सेस चाहिए); चल रहा गेम बंद न हो, इसलिए */
    fun foregroundPackage(ctx: Context): String? {
        if (!hasUsageAccess(ctx)) return null
        val usm = ctx.getSystemService(UsageStatsManager::class.java)
        val now = System.currentTimeMillis()
        val events = usm.queryEvents(now - 60 * 60 * 1000, now)
        val e = UsageEvents.Event()
        var last: String? = null
        while (events.hasNextEvent()) {
            events.getNextEvent(e)
            if (e.eventType == UsageEvents.Event.ACTIVITY_RESUMED) last = e.packageName
        }
        return last
    }

    fun hasUsageAccess(ctx: Context): Boolean {
        val ops = ctx.getSystemService(AppOpsManager::class.java)
        return ops.unsafeCheckOpNoThrow(
            AppOpsManager.OPSTR_GET_USAGE_STATS, Process.myUid(), ctx.packageName
        ) == AppOpsManager.MODE_ALLOWED
    }

    /** पैकेज -> मिनट (from से अब तक स्क्रीन पर खुला रहा) */
    fun usageMinutes(ctx: Context, from: Long): Map<String, Long> {
        val usm = ctx.getSystemService(UsageStatsManager::class.java)
        return usm.queryAndAggregateUsageStats(from, System.currentTimeMillis())
            .mapValues { it.value.totalTimeInForeground / 60000 }
    }

    fun startOfToday(): Long = Calendar.getInstance().apply {
        set(Calendar.HOUR_OF_DAY, 0); set(Calendar.MINUTE, 0)
        set(Calendar.SECOND, 0); set(Calendar.MILLISECOND, 0)
    }.timeInMillis
}
GZEOF
mkdir -p "app/src/main/java/com/example/gamezone"
cat > "app/src/main/java/com/example/gamezone/Shell.kt" <<'GZEOF'
package com.example.gamezone

import android.content.pm.PackageManager
import android.os.Build
import rikka.shizuku.Shizuku

/** Shizuku के ज़रिए shell कमांड चलाने वाला हेल्पर */
object Shell {
    private val SAFE = Regex("[A-Za-z0-9._]+")
    fun safe(pkg: String) = SAFE.matches(pkg)

    fun running(): Boolean = try {
        Shizuku.pingBinder()
    } catch (e: Throwable) {
        false
    }

    fun available(): Boolean = try {
        Shizuku.pingBinder() && Shizuku.checkSelfPermission() == PackageManager.PERMISSION_GRANTED
    } catch (e: Throwable) {
        false
    }

    fun requestPermission() {
        try {
            Shizuku.requestPermission(1001)
        } catch (e: Throwable) {
        }
    }

    /** कमांड चलाकर आउटपुट (stdout+stderr) लौटाता है। मुख्य थ्रेड पर मत बुलाना */
    fun run(cmd: String): String {
        return try {
            val m = Shizuku::class.java.getDeclaredMethod(
                "newProcess",
                Array<String>::class.java, Array<String>::class.java, String::class.java
            )
            m.isAccessible = true
            val p = m.invoke(null, arrayOf("sh", "-c", "($cmd) 2>&1"), null, null) as Process
            val out = p.inputStream.bufferedReader().readText()
            p.waitFor()
            out
        } catch (e: Throwable) {
            "error: ${e.message}"
        }
    }

    /** Android 12+ का Game Mode (performance / standard / battery) किसी गेम के लिए सेट करता है */
    fun setGameMode(pkg: String, mode: String): Boolean {
        if (Build.VERSION.SDK_INT < 31 || !available() || !safe(pkg)) return false
        val out = run("cmd game mode $mode $pkg")
        return !out.contains("rror", ignoreCase = true) && !out.contains("Unknown", ignoreCase = true)
    }
}
GZEOF
