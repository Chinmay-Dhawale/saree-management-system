# Saree Management System — Android

Admin-only Flutter + Firebase app for managing workers, saree types, production and weekly salaries.

## Requirements
- Flutter stable
- Android Studio / Android SDK
- A Firebase project

## Run
```bash
flutter pub get
flutterfire configure
flutter run
```

`flutterfire configure` generates `lib/firebase_options.dart`. Firebase services are initialized in `lib/main.dart`.

## Firebase
Enable:
- Authentication → Email/Password
- Cloud Firestore
- Storage (optional)

Create an admin user in Firebase Authentication.

## Firestore collections
- users
- workers
- saree_types
- rate_history
- production
- salary_payments
- audit_logs
- settings

## Business rules
- A worker can have multiple production entries on the same date.
- Production stores the rate used at the time of entry.
- Historical rates never change old production amounts.
- Weekly salary is calculated from production records.
- Paid salary records are treated as locked by the UI/business layer.

## Current delivery
This is an APK-ready foundation with working local/in-memory repository implementations and Firebase-ready dependencies/interfaces. Connect Firebase with `flutterfire configure`, then replace the demo repository providers with the Firebase repositories as described in the code comments.
