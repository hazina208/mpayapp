plugins {
    id("com.android.application")
    id("kotlin-android")
    // Add the Flutter Gradle plugin
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    compileSdk = 34 // Use the appropriate compileSdk version (34 is common as of 2025)

    defaultConfig {
        applicationId = "com.example.another" // Unique package name for your app
        minSdk = 21 // Minimum supported Android version (API 21 is common for Flutter)
        targetSdk = 34 // Target Android version
        versionCode = 1 // Version code for your app
        versionName = "1.0" // Version name for your app
        multiDexEnabled = true // Enable multidex for apps with large method counts
    }

    // Signing configuration for release builds
    signingConfigs {
        create("release") {
            keyAlias = "keyAlias" // Replace with your key alias
            keyPassword = "keyPassword" // Replace with your key password
            storeFile = file("path/to/your/keystore.jks") // Replace with path to your keystore file
            storePassword = "storePassword" // Replace with your store password
        }
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = false // Disable minification for simpler debugging (enable for production)
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
            signingConfig = signingConfigs.getByName("release") // Use signing config for release
        }
        getByName("debug") {
            applicationIdSuffix = ".debug" // Optional: Suffix for debug builds
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    // Enable support for View Binding or other features if needed
    buildFeatures {
        viewBinding = true
    }

    // Specify source sets if needed
    sourceSets {
        getByName("main") {
            manifest.srcFile("src/main/AndroidManifest.xml")
        }
    }
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib:1.9.0") // Use the latest stable Kotlin version
    implementation("androidx.core:core-ktx:1.13.1") // Core Android KTX
    implementation("androidx.appcompat:appcompat:1.7.0") // AppCompat for backward compatibility
    implementation("androidx.multidex:multidex:2.0.1") // Multidex support
}