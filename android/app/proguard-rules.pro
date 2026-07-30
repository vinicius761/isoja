# Manter classes do Flutter
-keep class io.flutter.** { *; }
-dontwarn io.flutter.**

# Manter classes da câmera
-keep class io.flutter.plugins.camera.** { *; }
-dontwarn io.flutter.plugins.camera.**

# Mantém tudo do SDK Zebra
-keep class com.zebra.rfid.api3.** { *; }
-keep class com.zebra.rfid.sdk.** { *; }
-keep class com.zebra.scannercontrol.** { *; }
-keep class com.zebra.* { *; }

# Evita warnings
-dontwarn com.zebra.**
-dontwarn org.bouncycastle.**

# Manter classes do shared_preferences
-keep class io.flutter.plugins.sharedpreferences.** { *; }
-dontwarn io.flutter.plugins.sharedpreferences.**

# Kotlin (caso use)
-keep class kotlin.** { *; }
-dontwarn kotlin.**

# Anotações (caso use json_serializable ou reflection)
-keepattributes *Annotation*
