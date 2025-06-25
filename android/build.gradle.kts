buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // Add any buildscript dependencies here if needed
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

subprojects {
    afterEvaluate {
        if (project.hasProperty("android")) {
            project.extensions.findByName("android")?.let { ext ->
                ext as com.android.build.gradle.BaseExtension
                ext.ndkVersion = "27.0.12077973"
            }
        }
    }
}
