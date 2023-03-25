# Grouu Mobile Project
This is a Flutter project that uses version 3.3.10 and is based on the boilerplate found at https://github.com/zubairehman/flutter-boilerplate-project/tree/master. It uses the fvm package manager.

## Getting Started

1. Make sure you have the Flutter SDK installed on your machine. If you don't, you can download it from the [Flutter website](https://flutter.dev/docs/get-started/install).

2. Clone this repository and navigate to the project directory.

3. Run the following command to install the dependencies:

    `
    flutter pub get
    `

4. Run the project by using this command :

    `
    flutter run
    `


## Building Dev Env Android APK and iOS IPA with GitHub Actions using Git Tags

We use [ncipollo/release-action@v1](https://github.com/ncipollo/release-action) for our CI/CD pipeline. This script automatically builds, tests, and deploys the app to the app store when a new tag is pushed to the repository.

1. Make sure you have the latest version of the repository.

2. Make sure the app version is correct in [pubspec.yaml](pubspec.yaml). For example :

    `
    version: 0.8.1+26
    `

3. To create a new tag for the version you want to release, use the command:

    `
    git tag v0.8.1
    `

4. To push the tag to the remote repository:

    `
    git push origin --tags
    `

5. The pipeline will automatically trigger and perform the following steps:
- Verify the tag follows semver
- Build the app
- Deploy the app to Github Release and Firebase App Distribution

6. Once the pipeline is completed, you can check the Android version on the [Releases](https://github.com/GrouuTech/grouu-mobile/releases) tab of the repository or Firebase App Distribution using below invitation link. 

## Invitation link for Firebase App Tester
- Android Dev : https://appdistribution.firebase.dev/i/e3e9652f3ad40f8a
- Android Prod : https://appdistribution.firebase.dev/i/7f74b3e18e64f1eb
- iOS Dev : https://appdistribution.firebase.dev/i/535423643f17c29f
- iOS Prod : https://appdistribution.firebase.dev/i/cb8ad39d171b5a87

### If you're a new iOS Tester, Below is the tutorial about testing on iOS:

1. Use the link above to join as a tester.

2. Sign in using the Google account you want to use.

3. Install the Firebase profile by clicking on "Register device" and then install the profile in the "Settings" of your device.

4. Once complete, you should receive a message saying "Device registered, you’re all set! You’ll get an email when the app is ready to test." Wait for the next build to be released by the developer so that your device is registered.

5. You will receive an email notification when the latest build has been released. Download the app to start testing.

6. If you got "Developer Mode Required" error messages, please follow these steps: 
    1. On your iPhone, open the Settings app and then tap Privacy & Security.
    2. Scroll down to Security and tap Developer Mode.
    3. Tap the Developer Mode slider.
    4. Tap Restart.
    5. After the device restarts, unlock the device. The Turn on Developer Mode? dialog appears.
    6. Tap Turn On. You can now launch your app and start testing.

### If you're an iOS Developer, Read this : 

To register a new iOS tester for your Firebase app, follow these steps:

1. Obtain the list of UDIDs for the new tester by going to Firebase Console > App Distribution > Testers & Groups > Export Apple UDIDs.

2. Import the tester list to [Apple's Developer website](https://developer.apple.com/account/resources/devices/list).

3. Access [Apple's Developer website](https://developer.apple.com/account/resources/profiles/list) and select "Group Dev Distribution". Edit the profile and add any unregistered devices, then save the changes.

4. Download the "Group Dev Distribution" profile.

5. In the terminal, execute the following command:

    ```bash
    base64 -i path/to/Grouu_Dev_Distribution.mobileprovision | pbcopy
    ```
    By doing this, you will have obtained the base64 representation of the provisioning profile.
    This will register the new tester's device and allow them to test your Firebase app.

6. Access the [Repository Secret](https://github.com/GrouuTech/grouu-mobile/settings/secrets/actions), then edit the secret of MOBILEPROVISION_BASE64. Paste the base64 into its value and save the changes.

7. This will register the new tester's device and allow them to test your Firebase app starting from the next build.







# Credits
The following libraries and resources have been used in this project:
- [Flutter Boilerplate Project](https://github.com/zubairehman/flutter-boilerplate-project/tree/master) for the boilerplate
- [flutter_localizations](https://pub.dev/packages/flutter_localizations) for localization support in Flutter
- [flutter_cupertino_localizations](https://pub.dev/packages/flutter_cupertino_localizations) for localization support in Cupertino widgets
- [cupertino_icons](https://pub.dev/packages/cupertino_icons) for a set of Cupertino-styled icons
- [shared_preferences](https://pub.dev/packages/shared_preferences) for storing and retrieving data in local storage
- [http](https://pub.dev/packages/http) for making HTTP requests
- [mobx](https://pub.dev/packages/mobx) for state management
- [flutter_mobx](https://pub.dev/packages/flutter_mobx) for integrating MobX with Flutter
- [validators](https://pub.dev/packages/validators) for input validation
- [dio](https://pub.dev/packages/dio) for making HTTP requests with more features
- [another_flushbar](https://pub.dev/packages/another_flushbar) for creating and showing flushbars
- [material_dialog](https://pub.dev/packages/material_dialog) for creating material-style dialogs
- [intl](https://pub.dev/packages/intl) for internationalization and localization
- [xxtea](https://pub.dev/packages/xxtea) for encryption and decryption using the XXTEA algorithm
- [sembast](https://pub.dev/packages/sembast) for storing and querying data in a SQLite database
- [path_provider](https://pub.dev/packages/path_provider) for accessing the device's filesystem
- [get_it](https://pub.dev/packages/get_it) for service locator
- [google_fonts](https://pub.dev/packages/google_fonts) for loading and using Google fonts in the app
- [iconly](https://pub.dev/packages/iconly) for creating and using custom icons in the app
- [modal_bottom_sheet](https://pub.dev/packages/modal_bottom_sheet) for creating modal bottom sheets
- [pinput](https://pub.dev/packages/pinput)
- [unicons](https://pub.dev/packages/unicons) for a set of customizable icons
- [device_info_plus](https://pub.dev/packages/device_info_plus) for getting device information
- [drift](https://pub.dev/packages/drift) for in-app messaging
- [sqlite3_flutter_libs](https://pub.dev/packages/sqlite3_flutter_libs) for using SQLite in Flutter
- [path](https://pub.dev/packages/path) for working with paths and directories
- [showcaseview](https://pub.dev/packages/showcaseview) for creating showcase-style walkthroughs in the app
- [image_picker](https://pub.dev/packages/image_picker) for picking images from the device's image gallery or camera
- [age_calculator](https://pub.dev/packages/age_calculator) for calculating age from a given birthdate
- [flutter_portal](https://pub.dev/packages/flutter_portal) for creating portals in the app
- [fl_chart](https://pub.dev/packages/fl_chart) for creating charts and graphs in the app
- [json_serializable](https://pub.dev/packages/json_serializable) for generating JSON serialization code
- [json_annotation](https://pub.dev/packages/json_annotation) for providing annotations for JSON serialization
- [shimmer](https://pub.dev/packages/shimmer) for creating shimmer effect
- [syncfusion_flutter_sliders](https://pub.dev/packages/syncfusion_flutter_sliders) for creating sliders
- [flutter_html](https://pub.dev/packages/flutter_html) for rendering html and css in flutter
- [url_launcher](https://pub.dev/packages/url_launcher) for launching a URL in the default browser

