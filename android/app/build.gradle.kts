plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.swapit.swap_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlin {
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
        }
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.swapit.swap_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    packaging {
        jniLibs.useLegacyPackaging = true
    }

    buildTypes {
        release {
            // Keep auxiliary JNI libraries on exactly the same ABI set as Flutter.
            // Flutter 3.41 defaults otherwise retain incomplete plugin-only ABIs.
            if ((project.findProperty("split-per-abi")?.toString()?.toBoolean() ?: false).not()) {
                val flutterAbiMap = mapOf(
                    "android-arm" to "armeabi-v7a",
                    "android-arm64" to "arm64-v8a",
                    "android-x64" to "x86_64"
                )
                val targets = (project.findProperty("target-platform")?.toString()
                    ?: "android-arm,android-arm64,android-x64").split(",")
                ndk {
                    abiFilters.clear()
                    abiFilters.addAll(targets.map { target ->
                        flutterAbiMap[target] ?: error("Unsupported Flutter target: $target")
                    })
                }
            }
            isMinifyEnabled = false
            isShrinkResources = false
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
