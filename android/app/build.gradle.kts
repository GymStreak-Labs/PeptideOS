import java.util.Properties
import org.gradle.api.GradleException

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
}

val releaseSigningProperties = Properties()
val releaseSigningPropertiesFile = rootProject.file("key.properties")
if (releaseSigningPropertiesFile.exists()) {
    releaseSigningPropertiesFile.inputStream().use { releaseSigningProperties.load(it) }
}

fun releaseSigningValue(name: String): String? {
    return System.getenv("PEPMOD_UPLOAD_${name.uppercase()}")
        ?: releaseSigningProperties.getProperty(name)
        ?: releaseSigningValueFromMissionControl(name)
}

fun releaseSigningValueFromMissionControl(name: String): String? {
    if (name == "store_file") {
        val missionControlStoreFile = file(
            "${System.getProperty("user.home")}/.mission-control/credentials/gymstreak-labs/pepmod-upload-keystore.jks"
        )
        return missionControlStoreFile.takeIf { it.exists() }?.absolutePath
    }

    val serviceName = when (name) {
        "store_password" -> "peptideos-android-upload-store-password"
        "key_alias" -> "peptideos-android-upload-key-alias"
        "key_password" -> "peptideos-android-upload-key-password"
        else -> return null
    }
    val securityTool = file("/usr/bin/security")
    if (!securityTool.exists()) return null

    return try {
        val process = ProcessBuilder(
            securityTool.absolutePath,
            "find-generic-password",
            "-s",
            serviceName,
            "-w",
        )
            .redirectError(ProcessBuilder.Redirect.DISCARD)
            .start()
        val output = process.inputStream.bufferedReader().readText().trim()
        if (process.waitFor() == 0 && output.isNotEmpty()) output else null
    } catch (_: Exception) {
        null
    }
}

android {
    namespace = "com.gymstreaklabs.peptide_os"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.gymstreaklabs.peptide_os"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            val storeFilePath = releaseSigningValue("store_file")
            val configuredStorePassword = releaseSigningValue("store_password")
            val configuredKeyAlias = releaseSigningValue("key_alias")
            val configuredKeyPassword = releaseSigningValue("key_password")

            if (
                storeFilePath != null &&
                configuredStorePassword != null &&
                configuredKeyAlias != null &&
                configuredKeyPassword != null
            ) {
                storeFile = file(storeFilePath)
                storePassword = configuredStorePassword
                keyAlias = configuredKeyAlias
                keyPassword = configuredKeyPassword
            } else {
                throw GradleException(
                    "Missing PepMod Android release signing config. Provide android/key.properties, " +
                        "PEPMOD_UPLOAD_* env vars, or unlocked Mission Control mc-vault credentials."
                )
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}
