# NFT 3D Product Viewer – Flutter + AR
A sleek 3D product page built with Flutter. Spin and zoom a GLB model, switch between two sample models, and launch AR on mobile. Dark theme, custom header, subtle ground glow, and a small gallery to swap models.

## Highlights
- Smooth 3D viewer (GLB/GLTF) via `model_viewer_plus`
- AR on Android (Scene Viewer). iOS Quick Look supported when USDZ is provided
- Two sample models to switch between: Astronaut (default) and Stylized Helmet
- Static ring/ellipse under the model + soft blue glow for depth
- Short NFT callout text + minimal two-item gallery (ASTRO | HELMET)
- Custom app bar (335×44) with 44×44 icon buttons, dark theme
  
## Quick start

1) pubspec.yaml
```yaml
dependencies:
  flutter:
    sdk: flutter
  model_viewer_plus: ^1.9.3

flutter:
  uses-material-design: true
  assets:
    - assets/icons/
    - assets/images/
    - assets/models/
```
Android (required for AR and local loading in WebView)
File: android/app/src/main/AndroidManifest.xml
Inside <application …> enable cleartext (model_viewer_plus uses a local HTTP server):
```
<application
  android:label="learnnn"
  android:name="${applicationName}"
  android:icon="@mipmap/ic_launcher"
  android:usesCleartextTraffic="true">
```

Web (only if you run on web)
File: web/index.html → add @google/model-viewer scripts in <head>:
```
<script type="module" src="https://unpkg.com/@google/model-viewer@3.3.0/dist/model-viewer.min.js"></script>
<script nomodule src="https://unpkg.com/@google/model-viewer@3.3.0/dist/model-viewer-legacy.js"></script>
```
# Run
```
flutter run -d android
flutter run -d chrome
```
# Build (small APK)
Smallest single APK for modern devices (ARM64):
```
flutter clean
flutter pub get
flutter build apk --release --split-per-abi --tree-shake-icons
```
# Notes & tips
AR works only on real devices (Android needs Google Play Services for AR)
If you see net::ERR_CLEARTEXT_NOT_PERMITTED on Android: ensure android:usesCleartextTraffic="true" is set in <application>
On web, make sure the model-viewer scripts are included. Asset paths must be correct (case-sensitive)
For iOS AR, export USDZ versions of your models and set iosSrc in the ModelViewer widget.


