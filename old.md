# Google Play Store Compliance & Policy Audit Report: "Sangapu"

**Application Name:** Sangapu (Shangapu Hotel & Lodge)  
**Package Identifier:** `com.goat_tech.sangapu`  
**Framework:** Flutter (Dart 3.10) / Android Gradle (KTS)  
**Target Category:** Business / Hotel & Financial Ledger Management  
**Monetization:** Free / Ad-free  
**Date of Audit:** September 19, 2026  
**Auditor:** Google Play Console Compliance Specialist & Principal Android Auditor  

---

## 1. Master Compliance & Risk Evaluation Matrix

The following table comprehensively breaks down every policy area, examining what is **Safe**, what is **Moderate Risk**, and what is **Critical (Rejection Risk)** in Sangapu's codebase, architecture, and console declarations.

| # | Topic / Area | Current Status | Risk Level | Problem in Current Sangapu Codebase | Solution & Action Required | Remarks |
|---|---|---|---|---|---|---|
| **1** | **In-App Account Deletion** | ❌ Missing | 🚨 **Critical Risk** | `lib/` only contains Logout (`DashboardPage`). No option exists to delete account or associated data. | Add an in-app "Delete Account" button in an Account/Settings dialog with an API call (`DELETE /auth/account/`) and local cache wipe. | **Mandatory** under Google Play User Data policy. Instant rejection if missing. |
| **2** | **Web Account Deletion URL** | ❌ Missing | 🚨 **Critical Risk** | No public web link exists for users to submit account/data deletion without installing the app. | Deploy a public web page (e.g., `https://sangapu.com/delete-account`) detailing how users can request account & data deletion. Enter this in Play Console. | Required in Data Safety form. Google bot validates that the URL is live and functional. |
| **3** | **Advertising ID (`AD_ID`) Permission** | ❌ Hidden Injection | 🚨 **Critical Risk** | `firebase-analytics` in `build.gradle.kts` automatically merged `com.google.android.gms.permission.AD_ID` into release manifest. | Add `<uses-permission android:name="com.google.android.gms.permission.AD_ID" tools:node="remove"/>` to `android/app/src/main/AndroidManifest.xml`. | If not removed, declaring "No Ads" in Console causes immediate upload failure or policy contradiction. |
| **4** | **AdServices Permissions** | ❌ Hidden Injection | 🚨 **Critical Risk** | Firebase automatically injected `ACCESS_ADSERVICES_AD_ID` and `ACCESS_ADSERVICES_ATTRIBUTION` into the release manifest. | Strip them in `AndroidManifest.xml` with `tools:node="remove"` for both AdServices permissions. | Eliminates unnecessary ad-tracking scrutiny for an ad-free business tool. |
| **5** | **Data Safety: Device & Other Identifiers** | ⚠️ Needs Declaration | ⚠️ **Moderate Risk** | Firebase Analytics is included and runs natively via `FirebaseInitProvider`, generating App Instance IDs and diagnostic logs. | In Play Console Data Safety form, declare **"Device or other IDs"** as **Collected** for **Analytics** (Ephemeral: No, Encrypted in transit: Yes). | Mismatch between declared SDKs and Data Safety questionnaire leads to policy warnings. |
| **6** | **Data Safety: Personal Info (Auth)** | ⚠️ Needs Declaration | ⚠️ **Moderate Risk** | User email and password are submitted to `auth/login/`. | Declare **Personal Info > Email address & Name** as **Collected** for **App Functionality / Account Management**. | Must state data is encrypted in transit over HTTPS. |
| **7** | **Data Safety: Financial Info** | ⚠️ Needs Declaration | ⚠️ **Moderate Risk** | Sangapu records hotel room rates, daily sales, and operational expenses. | Declare **Financial Info > Other financial info** as **Collected** for **App Functionality** (not shared with third parties). | Hotel income/expense tracking qualifies as financial recordkeeping. |
| **8** | **App Access for Reviewers (Credentials)** | ⚠️ Potential Blocker | ⚠️ **Moderate Risk** | Entire app is locked behind login. If reviewer faces 2FA, OTP, or expired credentials, they cannot review. | In Play Console > App Access, provide permanent test credentials (`playreview@sangapu.com`), explicit instructions, and disable OTP for that user. | Reviewers will not contact you; they immediately reject with "Unable to review app". |
| **9** | **Reviewer Geo-blocking / IP Whitelisting** | ⚠️ Potential Blocker | ⚠️ **Moderate Risk** | Reviewers test from Google servers in the US (Mountain View, CA), Ireland, or Singapore. | Ensure backend API server (`apiBaseUrl`) does not block US or foreign IP addresses or apply aggressive Cloudflare challenges to API endpoints. | If the backend drops non-Nepal requests, reviewer sees "Failed to load" and rejects app. |
| **10** | **In-App Privacy Policy Link** | ❌ Missing | ⚠️ **Moderate Risk** | `lib/` has zero references or navigation links to a Privacy Policy inside the app. | Add a clickable "Privacy Policy" link on `LoginPage` and in the dashboard/settings using `url_launcher`. | Required by Google Play for all apps handling personal, auth, or financial data. |
| **11** | **Public Privacy Policy URL** | ⚠️ External Dependency | ⚠️ **Moderate Risk** | Must be hosted on a live URL and entered in Play Console Store Listing. | Create and host a clear privacy policy stating collected data (email, device metrics, ledger records) and retention periods. | Google crawler checks if the URL is active, mobile-responsive, and contains privacy text. |
| **12** | **File Storage & Scoped Storage** | ⚠️ Architecture Flaw | ⚠️ **Moderate Risk** | `DownloadHelper` hardcodes `/storage/emulated/0/Download`, which throws permission denied on Android 10/11+ if POSIX write fails. | Use `FileSaver.instance.saveFile` directly (which uses Android MediaStore/SAF) instead of raw directory path creation. | Prevents silent failures or permission crashes during PDF/Excel statement exports. |
| **13** | **Minimum Functionality & Empty States** | ⚠️ UI Flaw | ⚠️ **Moderate Risk** | When `income.data` or `expenses.data` is empty, the UI renders only a bare text string, hiding all cards and headers. | Render regular dashboard summary cards with `Rs 0.00` and friendly placeholders rather than completely blanking out the view. Pre-seed demo account! | Google rejects apps that look blank or broken on first launch under "Minimum Functionality". |
| **14** | **Error Display & Crash Reporting** | ⚠️ UI Flaw | ⚠️ **Moderate Risk** | Raw Dio exception messages (`Failed to load income: ...`) are printed directly in UI on network errors. | Show user-friendly error banners with a "Retry" button instead of technical failure dumps. | Raw network errors seen by human reviewers trigger "Broken Functionality" rejections. |
| **15** | **Branding & Impersonation ("Sangapu")** | ⚠️ Metadata Check | ⚠️ **Moderate Risk** | Developer account (`Goat Tech`) differs from app title (`Sangapu Hotel & Lodge`). | Keep title clear (`Sangapu: Hotel Ledger & Tracker`) and avoid keyword stuffing in description. Keep authorization letter ready if asked. | Prevents automated flag for unverified commercial brand representation. |
| **16** | **Sensitive Runtime Permissions** | ✅ Verified Clean | 🟢 **Safe** | Manifest uses only `INTERNET`. No runtime requests for Camera, Microphone, Contacts, Location, SMS, or Phone State. | Keep permissions minimal. No changes needed. | Avoids intrusive permission declaration forms in Play Console. |
| **17** | **Google Play In-App Billing (IAP)** | ✅ 100% Free | 🟢 **Safe** | The app is free, with no digital goods, paywalls, or subscriptions. | Declare "No in-app purchases" in Play Console. | Completely exempt from Google Play Billing 15-30% service fee requirements. |
| **18** | **Ad Policies & Monetization** | ✅ No Ads | 🟢 **Safe** | No AdMob, Unity Ads, or promotional banners exist in code. | Declare "No ads" in Play Console (after stripping `AD_ID` in finding #3). | Avoids families ad policy, SDK compliance checks, and advertising disclosures. |
| **19** | **Data Encryption in Transit** | ✅ HTTPS Standard | 🟢 **Safe** | Dio API client and Firebase communication exclusively use TLS/HTTPS. | Declare "Data is encrypted in transit" as **Yes** in Data Safety. | Satisfies Play Store encryption requirement. |
| **20** | **Target SDK Compliance** | ✅ Up to Date | 🟢 **Safe** | Gradle uses `flutter.targetSdkVersion` (API 34+ / Android 14+). | Verify build target is at least API 34 before uploading the release AAB bundle. | Meets Google Play annual target SDK mandate. |

---

## 2. Actionable Fixes & Code Implementations

### Fix 1: Strip Unwanted Injected Permissions in AndroidManifest.xml
In [`android/app/src/main/AndroidManifest.xml`](file:///d:/sangapu/android/app/src/main/AndroidManifest.xml), declare the `tools` namespace and explicitly remove `AD_ID` and AdServices permissions injected by Firebase:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">

    <uses-permission android:name="android.permission.INTERNET"/>

    <!-- Remove permissions injected by Firebase Analytics to remain 100% ad-free -->
    <uses-permission android:name="com.google.android.gms.permission.AD_ID" tools:node="remove"/>
    <uses-permission android:name="android.permission.ACCESS_ADSERVICES_AD_ID" tools:node="remove"/>
    <uses-permission android:name="android.permission.ACCESS_ADSERVICES_ATTRIBUTION" tools:node="remove"/>

    <application
        android:label="Sangapu"
        android:name="${applicationName}"
        android:icon="@mipmap/launcher_icon">
        ...
    </application>
</manifest>
```

---

### Fix 2: In-App Account Deletion Dialog
Add an account deletion option in your settings or user action menu:

```dart
// Suggested placement: lib/features/auth/widgets/delete_account_dialog.dart
import 'package:flutter/material.dart';

void showDeleteAccountDialog(BuildContext context, {required VoidCallback onConfirmDelete}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Delete Account & Data', style: TextStyle(fontWeight: FontWeight.bold)),
      content: const Text(
        'Are you sure you want to permanently delete your account? '
        'This will erase your login credentials, room logs, income, and expense records. '
        'This action cannot be undone.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            Navigator.pop(ctx);
            onConfirmDelete();
          },
          child: const Text('Delete Account', style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}
```

---

### Fix 3: In-App Privacy Policy Link on Login Page
On [`lib/features/auth/screens/login_page.dart`](file:///d:/sangapu/lib/features/auth/screens/login_page.dart), add a clickable link to your privacy policy:

```dart
import 'package:url_launcher/url_launcher.dart';

Widget _buildPrivacyPolicyLink() {
  return Center(
    child: InkWell(
      onTap: () async {
        final uri = Uri.parse('https://sangapu.com/privacy-policy');
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          'Privacy Policy & Terms of Service',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ),
  );
}
```

---

### Fix 4: Safe Scoped Storage File Saving
Update [`lib/core/utils/download_helper.dart`](file:///d:/sangapu/lib/core/utils/download_helper.dart) to avoid hardcoding `/storage/emulated/0/Download`:

```dart
import 'dart:typed_data';
import 'package:file_saver/file_saver.dart';

class DownloadHelper {
  static Future<String> saveDocument({
    required String fileName,
    required Uint8List bytes,
    required String extension,
  }) async {
    // Directly leverage FileSaver which uses MediaStore / Storage Access Framework
    final savedPath = await FileSaver.instance.saveFile(
      name: fileName,
      bytes: bytes,
      fileExtension: extension,
      mimeType: extension == 'pdf' ? MimeType.pdf : MimeType.microsoftExcel,
    );
    return savedPath;
  }
}
```

---

## 3. Play Console Submission Checklist

- [ ] **App Access:** Configure demo credentials (`username` and `password`) in Play Console with detailed notes that no 2FA is needed.
- [ ] **Data Safety:** Declare:
  - Personal Info: Email address, Name (App functionality).
  - Financial Info: Other financial info (App functionality).
  - Device/Other IDs: Device or other IDs (Firebase Analytics).
  - Data encrypted in transit: **Yes**.
  - Account deletion mechanism: **Yes** (provide both in-app method and web deletion URL).
- [ ] **Advertising ID Declaration:** Select **"No"** (only valid after applying Fix #1 above).
- [ ] **Target Audience:** Strictly 18+ (Adults / Business owners). Declare "No" to families program.
- [ ] **Government Apps / Financial Licensing:** Declare that Sangapu is a private business management utility, not an official government or licensed banking/credit lending application.
