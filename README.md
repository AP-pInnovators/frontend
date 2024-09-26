# Getting Started
Here is the default stuff that comes in the readme for a new Flutter project:

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# Downloading Flutter SDK and Setting Up Android Dev Env (Windows)
On Windows you can only develop Android apps; we will develop for Android, and when needed we will use a Mac to convert to iOS (Flutter makes conversion easy)

## For setting up the environment for developing Android Flutter apps on Windows, [follow this guide](https://docs.flutter.dev/get-started/install/windows/mobile)

### Comments on the guide:
- While getting the Flutter SDK set up, ```flutter doctor``` is your best friend (and ```flutter doctor -v``` if your error are more severe)
- Once finished downloading the SDK, open the command pallate again (Ctrl + Shift + P) and select "Flutter: Add Flutter SDK to PATH" (unless you already did it from the prompt)
- If you already set up Android Studio and didn't install the components through the wizard, go to the "Welcome to Android Studio" screen and select "More Actions" > "SDK Manager"; look through all the tabs for the required components, select all of them, and hit "Apply" to install them
- If you're looking for "Android SDK Platform, API 35.0.1" but don't see it, just make sure that "Android 15.0 ("VanillaIceCream")" API Level 35 is installed
- When turning on VM acceleration to get the emulator running, if you run ```-accel-check``` on the specified file and see a message saying to run ```bcdedit /set hypervisorlaunchtype off```, run that command and <strong>make sure to restart your computer afterwards to apply the changes</strong>
- When adding a device to the device manager, select "Tablet" > "Medium Tablet", <strong>select the "x86 Images" tab</strong>, and select the download for the image that says Release Name "VanillaIceCream", API 35, and <strong>Target "Android 15.0 (Google APIs)"</strong>; once it downloads (should come downloaded most likely), select the image; make sure the startup orientation is landscape, and hit Finish without changing anything else
    - <strong>We will be developing specifically on tablet and for this Google API image</strong>
- To make sure everything works, launch the emulator briefly (then close it and finish following the guide)
- When accepting the Android licenses, I had an issue with cmdline-tools not being found. To fix this, go to the Android SDK manager (guide above), check "Show Package Details" on the bottom right, find the "Command-line Tools", and uncheck the latest version, and instead check the latest version that doesn't say "(latest)" at the end (for me, 16.0 worked)
- Run ```flutter doctor``` one last time after everything is done

## Running Flutter app in Android Emulator
To run your Flutter app in your installed Android Emulator:

1. Run ```flutter emulators``` (in your VSCode dev environment terminal of course)
2. Look for the Medium Tablet emulator device created earlier
3. Copy the ID (not name) of the Medium Tablet emulator (it was "Medium_Tablet_API_35" for me)
4. Run the emulator with ```flutter emulators --launch <emulator id>```, replacing ```<emulator id>``` with the ID you copied<br>
The command I use was
```
flutter emulators --launch Medium_Tablet_API_35
```
5. While the emulator is running (it has to have been run through the terminal, not Android Studio), run ```flutter run```, and it should automatically install everything needed and launch the app on your emulator!

Notice while the app is running, you have some options listed in your terminal:
- r Hot reload.
- R Hot restart.
- h List all available interactive commands.
- d Detach (terminate "flutter run" but leave application running).
- c Clear the screen
- q Quit (terminate the application on the device).

Use these options as needed while debugging your app

Also note you have a debugger at the link they provide