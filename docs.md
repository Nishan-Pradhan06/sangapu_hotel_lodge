# Google Play Store Pre-Submission Compliance & Policy Audit: Sangapu

**Application Name:** Sangapu  
**Package Identifier:** `com.goat_tech.sangapu`  
**Version:** `2.1.10` (Version Code: `28`)  
**Target Category:** Productivity / Business Utility (Do NOT select "Finance")  
**Target Audience:** Adults (18+)  
**Monetization Model:** Free / Ad-Free / No In-App Purchases (IAP)  
**Auditor Role:** Senior Android Release Manager & Google Play Policy Compliance Specialist  
**Audit Date:** September 20, 2026  

---

## 1. Executive Summary

| Overall Verdict | Primary Risk Factor | Critical Pre-Condition for Submission |
| :---: | :---: | :---: |
| **⚠️ NEEDS CHANGES (Ready After Console Declarations)** | **Reviewer App Access & Release Keystore Signing** | Configure Test Credentials in Play Console & Sign `.aab` with Production Keystore |

### Verdict Breakdown:
* **Codebase & Architecture:** **PASS (100% Compliant)**. In-app account deletion is implemented with token cleanup, `AD_ID` and AdServices permissions are explicitly stripped, Scoped Storage is adhered to, and network traffic is HTTPS/TLS encrypted.
* **Store Listing & Metadata:** **PASS (Sanitized)**. All prohibited ranking claims (`#1`, `Best`), pricing buzzwords (`Free`, `100% Free`), and hotel-specific terms have been eliminated.
* **Pre-Launch Blockers Requiring Manual Action in Play Console:**
  1. **App Access Credentials:** Because the app has no public registration button (accounts are provisioned by administrators), Google reviewers **will reject the app** unless permanent credentials (`testuser@gmail.com` / `123345678`) are entered under *App Content > App Access*.
  2. **Production Release Signing:** `build.gradle.kts` currently falls back to `signingConfigs.getByName("debug")`. The release bundle must be signed with a production keystore or enrolled in Play App Signing.
  3. **Data Safety Form Declarations:** Must declare Firebase Analytics App Instance ID under *Device or other IDs* and Name/Email under *Personal Info*.

---

## 2. App Submission Profile (Verified & Pre-Filled)

* **App Name:** `Sangapu` (7 characters — limit 30)
* **Short Description:** `Record daily income and expenses with report exports in PDF and Excel.` (70 characters — limit 80)
* **Full Description:** *(See Section 4 for the ready-to-paste description)*
* **Category:** `Productivity` (Subcategory: `Tools` or `Business`) — **Do NOT select "Finance"**
* **Target Audience / Age Group:** `18 and over`
* **Core Permissions Declared:** `android.permission.INTERNET` only
* **Auth / Sign-In Model:** Internal email/password authentication (Administrator-provisioned; no public sign-up)
* **Account Deletion:**
  * **In-App:** *Drawer → Account Deletion* (`AppRoutesName.deleteAccount`)
  * **Web Portal:** `https://sangapu.nishanpradhan.com.np/delete-account/`
* **Target SDK / Build Format:** Target SDK 34+ / Android App Bundle (`.aab`)
* **Monetization & Ads:** 100% Free, zero ads, zero digital sales (no Google Play Billing SDK)
* **Data Collected:**
  * Personal Info (Email address, User Name) for Account Management
  * Operational Data (User-entered income & expense records) for App Functionality
  * Device or other IDs (Firebase App Instance ID) for Crash & Usage Analytics

---

## 3. Master Policy Checklist Table

| Area / Policy Domain | Specific Requirement | App Submission Details | Status | Fix / Policy Action Required |
| :--- | :--- | :--- | :---: | :--- |
| **Store Listing & Metadata** | Title character limit (≤ 30 chars), no emojis, no ranking claims (`#1`, `Best`), no promotional buzzwords (`Free`, `Sale`). | Title is **"Sangapu"** (7 chars). No emojis, no superlatives. | ✅ **Pass** | Retain title strictly as **Sangapu** in Google Play Console. |
| **Store Listing & Metadata** | Short description limit (≤ 80 chars), accurate description of functionality, no keyword stuffing. | Short description is 70 characters: *"Record daily income and expenses with report exports in PDF and Excel."* | ✅ **Pass** | Copy and paste verbatim into the Play Console Short Description field. |
| **Store Listing & Metadata** | Full description (≤ 4000 chars), no repetitive keyword lists, no misleading claims or unverified claims. | Clean, functional description detailing daily entry logging, PDF/Excel export, and offline sync. | ✅ **Pass** | Use the verified description provided in Section 4 of this document. |
| **Store Listing & Metadata** | Graphic Assets (App icon 512x512 PNG, Feature Graphic 1024x500 PNG) must not include download counts, rankings, or prices. | App uses clean branding icon (`@mipmap/launcher_icon`). | 📋 **Pending Manual Verification** | Verify the uploaded 1024x500 feature graphic does not contain badges like "100% Free", "#1 App", or 5-star rating icons. |
| **App Content & Reviewer Access** | If any part of the app is restricted behind login, credentials and instructions **must** be provided to Google reviewers. | App displays a login screen with **no public registration button**. Accounts are created by admins. | ❌ **Blocker if empty** | In Play Console → **App Content → App Access**, select *"All or some functionality is restricted"*, add test credentials (`testuser@gmail.com` / `123345678`), and provide instructions (Action 1). |
| **Privacy & Permissions** | Minimal permissions principle. Manifest must not request invasive runtime permissions without core use-case justification. | Manifest requests only `INTERNET`. Explicitly removes `AD_ID` and AdServices permissions via `tools:node="remove"`. | ✅ **Pass** | No special runtime permission declarations (Camera, Location, Contacts, SMS) are needed in Play Console. |
| **Privacy & Data Safety** | Data Safety declaration must accurately match all integrated SDKs (Firebase) and backend APIs. | Firebase Analytics collects diagnostic App Instance IDs; Dio sends user credentials to backend. | ⚠️ **Warning** | In Play Console → **Data Safety**, declare **Device or other IDs** (Analytics), **Personal Info (Email/Name)**, and **Financial Info (Other financial info)** (Action 2). |
| **Privacy Policy Accessibility** | Active HTTPS URL clearly stating collected data, retention, and third-party SDKs; mobile-friendly and non-blocking. | Hosted at `https://sangapu.nishanpradhan.com.np/privacy-policy/`. Accessible in-app from Login & Drawer. | ✅ **Pass** | Enter `https://sangapu.nishanpradhan.com.np/privacy-policy/` into Play Console Store Listing and App Content forms. |
| **Account Deletion & Data Retention** | Mandatory in-app deletion path AND public web deletion URL for accounts created/authenticated in the app. | Implemented in-app via `DeleteAccountPage` (`DELETE auth/account/`) and live web portal: `https://sangapu.nishanpradhan.com.np/delete-account/`. | ✅ **Pass** | In Play Console → **Data Safety → Account Deletion URL**, enter `https://sangapu.nishanpradhan.com.np/delete-account/`. |
| **Technical & Bundle Requirements** | Android App Bundle (`.aab`) format, Target SDK 34+ (Android 14+), 64-bit native library compliance, 16KB page size readiness. | Built with Flutter 3.10+ Gradle KTS (`com.goat_tech.sangapu`), 64-bit ABI supported by Flutter engine. | ✅ **Pass** | Run `flutter build appbundle --release` to compile the release artifact. |
| **Technical & Release Signing** | Release `.aab` must be signed with a production keystore and enrolled in Google Play App Signing. | `build.gradle.kts` currently assigns `signingConfig = signingConfigs.getByName("debug")` in release build. | ❌ **Blocker if unsigned** | Generate a production keystore (`upload-keystore.jks`), configure `signingConfigs` in `build.gradle.kts` or `key.properties`, and sign release AAB (Action 3). |
| **Target Audience & Families** | Target age group selection determines whether app must comply with strict Families Policy & COPPA requirements. | App is a daily utility for staff and adult operations. Target age declared as **18 and over**. | ✅ **Pass** | Select **18+ only** in Target Audience questionnaire. This exempts the app from Neutral Age Screen and Teacher Approved requirements. |
| **Financial & Monetization** | If digital goods/services are sold in-app, Google Play Billing must be used. No unlicensed banking claims. | Sangapu is 100% free with no digital transactions, loans, subscriptions, or credit services. | ✅ **Pass** | In Play Console, declare: Category = **Productivity**, Contains Ads = **No**, In-App Purchases = **No**. |

---

## 4. Ready-to-Paste Store Listing Metadata

### App Title (≤ 30 characters)
```text
Sangapu
```

### Short Description (≤ 80 characters)
```text
Record daily income and expenses with report exports in PDF and Excel.
```
*(Exact length: 70 characters — zero prohibited buzzwords, 100% compliant)*

### Full Description (≤ 4000 characters)
```text
Sangapu is a simple, focused daily income and expense recording utility designed for personal and internal operational tracking.

Key Features:
• Daily Income & Expense Logging: Record daily receipts, operational expenses, and notes in seconds with clean, straightforward forms.
• PDF & Excel Report Exports: Download structured PDF and Excel (.xlsx) statement summaries whenever you need to print, review, or archive records.
• Dual Calendar Support: Seamlessly switch between Bikram Sambat (B.S. नेपाली पात्रो) and Gregorian (A.D.) dates to match your daily schedule.
• Complete Offline Functionality: Continue adding entries even without an active internet connection. All records are securely saved on your device and automatically sync once reconnected.
• Private & Ad-Free: Zero pop-ups, zero third-party advertisements, and zero commercial tracking. Your records remain private.
• Account & Data Governance: Maintain full control over your information with seamless in-app account deletion and an open web deletion request portal.

Important Access Notice:
Sangapu is built exclusively for authorized internal operations and personal management. User registration is managed by organization administrators; there is no open public self-registration inside the application.
```

---

## 5. Detailed Pre-Upload Action Items

Execute the following checklist prior to publishing the release track on Google Play Console:

### Action 1: Configure Reviewer App Access (Critical Blocker)
Because reviewers test from automated Google environments and foreign IPs with no public sign-up screen, failing to supply credentials will trigger an immediate rejection (*"Unable to review app: credentials required"*):
1. Navigate to **Google Play Console → Policy and programs → App content → App access**.
2. Select **"All or some functionality is restricted"**.
3. Click **Add instructions**:
   * **Title:** `Internal Reviewer Test Account`
   * **Username / Email:** `testuser@gmail.com`
   * **Password:** `123345678`
   * **Explanation / Notes for Google Reviewer:**
     > *"Sangapu is an internal operational utility for authorized staff. Public self-registration is closed by design. Use the provided test credentials (testuser@gmail.com / 123345678) to sign in. The app has full functionality with pre-populated sample entries. No 2FA or SMS verification is required for this account."*
4. Click **Save**.

---

### Action 2: Complete the Data Safety Form Correctly
Avoid policy discrepancy flags between your code dependencies (`firebase-analytics`, `dio`) and your declarations:
1. Go to **App content → Data safety**.
2. **Data Collection and Security:**
   * Is data encrypted in transit? **Yes** (all API calls use HTTPS/TLS).
   * Do you provide a way for users to request data deletion? **Yes**.
   * Add web deletion URL: `https://sangapu.nishanpradhan.com.np/delete-account/`.
3. **Data Types Declared:**
   * **Personal info → Email address & Name:**
     * Collected? **Yes**
     * Shared? **No**
     * Ephemeral? **No**
     * Required or Optional? **Required**
     * Purpose: **App functionality, Account management**
   * **Financial info → Other financial info:**
     * Collected? **Yes** (User-logged income and expense entries)
     * Shared? **No**
     * Purpose: **App functionality**
   * **Device or other IDs → Device or other IDs:**
     * Collected? **Yes** (Firebase Analytics App Instance ID)
     * Shared? **No**
     * Purpose: **Analytics, Diagnostics**

---

### Action 3: Production Release Signing Setup
In `android/app/build.gradle.kts`, replace debug release signing with production keys:
1. Create `android/key.properties` (ensure it is added to `.gitignore`):
   ```properties
   storePassword=<YOUR_KEYSTORE_PASSWORD>
   keyPassword=<YOUR_KEY_PASSWORD>
   keyAlias=<YOUR_KEY_ALIAS>
   storeFile=<PATH_TO_UPLOAD_KEYSTORE>
   ```
2. Configure `build.gradle.kts` to load `key.properties` in `signingConfigs.create("release")` and set `buildTypes.release.signingConfig = signingConfigs.getByName("release")`.
3. Build the production App Bundle:
   ```powershell
   flutter build appbundle --release
   ```
4. Verify the generated bundle at `build/app/outputs/bundle/release/app-release.aab`.

---

### Action 4: Closed Testing Track Verification (For Personal Developer Accounts)
* If your Google Play Console account is a **Personal account created after November 13, 2023**, Google requires a mandatory **14-day Closed Test with at least 12 testers opted-in continuously** before applying for production access.
* Ensure you create a Closed Testing track, invite 12+ opt-in email addresses, have them install and open the app, and wait for the 14-day continuous testing period to conclude before clicking **Apply for production access**.

---

## 6. Final Compliance Pre-Flight Checklist
- [x] App Name strictly 7 characters (`Sangapu`), zero buzzwords
- [x] Short description strictly 70 characters, zero promotional claims
- [x] All hotel/room-specific keywords eliminated; real daily income/expense scope reflected
- [x] In-app account deletion functional via `DeleteAccountPage`
- [x] Public web account deletion URL active: `https://sangapu.nishanpradhan.com.np/delete-account/`
- [x] Public privacy policy active: `https://sangapu.nishanpradhan.com.np/privacy-policy/`
- [x] `AD_ID` and AdServices permissions stripped in manifest
- [x] Target category designated as **Productivity** (not Finance)
- [x] Target audience set to **18+**
- [ ] Reviewer test credentials entered in Play Console App Access
- [ ] Release AAB built and signed with production upload keystore
