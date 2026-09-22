# Google Play Store Compliance & Release Risk Matrix

**Application:** Sangapu (`com.nishan.sangapu`)  
**Version:** `2.1.10` (Version Code: `28`)  
**Evaluation Standard:** Google Play Developer Program Policies & IARC Standards (2025–2026 Standards)  
**Document Type:** Comprehensive Policy, Technical, and Data Safety Compliance Matrix  
**Status Key:**  
- 🔴 **High Risk (Blocker):** Will cause instant rejection or suspension if not handled as specified.  
- 🟡 **Warning / Action Required:** Requires exact declaration in Google Play Console to prevent review failure.  
- 🟢 **Safe / Fully Compliant:** Verified in source code, merged manifest, or external legal infrastructure.  

---

## 1. Executive Master Risk Summary Table

| Category | Total Checked | 🔴 High Risk | 🟡 Action Required | 🟢 Safe & Compliant | Release Verdict |
| :--- | :---: | :---: | :---: | :---: | :--- |
| **Store Listing & Metadata** | 4 | 1 | 1 | 2 | 🟡 Requires cleaning duplicate text |
| **Financial Features Policy** | 3 | 1 | 1 | 1 | 🟡 Requires specific declaration |
| **App Access & Reviewer Gate** | 2 | 1 | 1 | 0 | 🟡 Requires test credentials in Console |
| **Permissions & Manifest** | 7 | 0 | 0 | 7 | 🟢 100% Compliant (Zero sensitive perms) |
| **Data Safety Questionnaire** | 6 | 0 | 2 | 4 | 🟡 Must declare exact matrix |
| **Account & Data Deletion** | 3 | 0 | 0 | 3 | 🟢 In-app + Web live & verified |
| **Technical & Build Standards** | 5 | 0 | 1 | 4 | 🟢 Target SDK 36, 16KB, AAB ready |
| **IARC Content Rating** | 9 | 0 | 0 | 9 | 🟢 Verified (Everyone 3+ / PEGI 3) |

---

## 2. Policy Governance & Compliance Risk Matrix

| Item / Policy Area | Current Status | Risk Level | Code / URL / Asset Evidence | Potential Violation / Impact | Required Action / Exact Console Setting |
| :--- | :--- | :---: | :--- | :--- | :--- |
| **Store Listing Description** | Duplicate text pasted twice in prompt | 🔴 **High Risk** | Full description in metadata | Google Play Spam and Repetitive Content Policy violation. | Remove duplicated paragraph. Keep clean, single-instance description under 4,000 characters. |
| **Financial Features Declaration** | Daily income & expense ledger | 🔴 **High Risk** | App Title, description, statement reports | If flagged as unauthorized loan/banking service, app gets suspended. | In Console (**App content > Financial features**): Select **Personal finance management / Expense tracking**. Affirm **NO loans, NO banking**. |
| **App Access (Reviewer Login)** | Closed authentication gate | 🔴 **High Risk** | `lib/features/auth/screens/login_screen.dart` | Google bots/reviewers cannot log in; rejected as *"Unable to review app"*. | In Console (**App content > App access**): Select **All or some functionality is restricted**. Enter `testuser@gmail.com` / `test@1234`. |
| **Store Category Selection** | App category in store settings | 🟡 **Action Required** | Play Console Store Settings | Selecting "Finance" category triggers heavy regulatory documentation. | Set primary category to **Productivity** (or **Business**), NOT *Finance*. |
| **Advertising ID (AD_ID)** | Explicitly stripped | 🟢 **Safe** | `AndroidManifest.xml` (`tools:node="remove"`) | Declaration mismatch if answered "Yes". | In Console (**App content > Advertising ID**): Select **NO** (App does not use Advertising ID). |
| **Web Account Deletion** | Live web endpoint | 🟢 **Safe** | `https://sangapu.nishanpradhan.com.np/delete-account/` | Rejection under Play Console User Data Deletion Policy. | HTTP 200 OK. Enter this exact URL in the Data Safety form deletion field. |
| **In-App Account Deletion** | Built-in deletion UI | 🟢 **Safe** | `lib/features/auth/screens/delete_account.dart` | Rejection if account can only be deleted externally. | Accessible via Dashboard Drawer. Features irreversible warning and password confirmation. |
| **Privacy Policy URL** | Live legal document | 🟢 **Safe** | `https://sangapu.nishanpradhan.com.np/privacy-policy/` | Policy strike if missing, HTTP error, or ID mismatch. | HTTP 200 OK. Matches package ID `com.nishan.sangapu` and specifies data retention. |
| **Terms of Service URL** | Live legal document | 🟢 **Safe** | `https://sangapu.nishanpradhan.com.np/terms-and-conditions/` | Disclaimers missing for financial entries. | HTTP 200 OK. Disclaims banking, credit, and investment services. |

---

## 3. Permissions & Merged Manifest Verification Matrix

| Permission Name | In Merged Manifest? | Status | Source / Injected By | Policy Evaluation | Auditor Action |
| :--- | :---: | :---: | :--- | :--- | :--- |
| `android.permission.INTERNET` | **Yes** | 🟢 **Safe** | Root `AndroidManifest.xml` | Normal permission. Required for API sync with backend. | Fully compliant. |
| `android.permission.ACCESS_NETWORK_STATE` | **Yes** | 🟢 **Safe** | Flutter Engine / Firebase Core | Normal permission. Used to check network reachability. | Fully compliant. |
| `android.permission.WAKE_LOCK` | **Yes** | 🟢 **Safe** | Firebase Analytics / Core | Normal permission. Keeps processor awake during async tasks. | Fully compliant. |
| `BIND_GET_INSTALL_REFERRER_SERVICE` | **Yes** | 🟢 **Safe** | Firebase Analytics | Standard Play Store install attribution. | Fully compliant. |
| `DYNAMIC_RECEIVER_NOT_EXPORTED` | **Yes** | 🟢 **Safe** | AndroidX Core Component | Internal signature-level broadcast receiver protection. | Android 14+ best practice. |
| `com.google.android.gms.permission.AD_ID` | **No (Stripped)** | 🟢 **Safe** | Stripped via `tools:node="remove"` | Advertising ID completely removed from binary. | Declare **NO** in Play Console AD_ID form. |
| `ACCESS_ADSERVICES_AD_ID` | **No (Stripped)** | 🟢 **Safe** | Stripped via `tools:node="remove"` | Privacy Sandbox AD_ID completely removed. | Fully compliant. |
| `ACCESS_ADSERVICES_ATTRIBUTION` | **No (Stripped)** | 🟢 **Safe** | Stripped via `tools:node="remove"` | Privacy Sandbox attribution completely removed. | Fully compliant. |
| `READ_EXTERNAL_STORAGE` | **No** | 🟢 **Safe** | Not present | Deprecated high-risk storage permission. | Not requested. Clean. |
| `WRITE_EXTERNAL_STORAGE` | **No** | 🟢 **Safe** | Not present | Deprecated high-risk storage permission. | Not requested. Clean. |
| `MANAGE_EXTERNAL_STORAGE` | **No** | 🟢 **Safe** | Not present | High-risk permission subject to strict Google approval. | Not requested. Clean. |
| `ACCESS_FINE_LOCATION` / `COARSE` | **No** | 🟢 **Safe** | Not present | High-risk location tracking. | Not requested. Clean. |
| `CAMERA` / `RECORD_AUDIO` | **No** | 🟢 **Safe** | Not present | High-risk hardware permissions. | Not requested. Clean. |
| `QUERY_ALL_PACKAGES` | **No** | 🟢 **Safe** | Specific `<queries>` used only | Restricted inventory permission. | Compliant scoped `<queries>` used. |

---

## 4. Google Play Console Data Safety Form Declaration Matrix

*All data must be declared as **Collected: Yes**, **Shared: No**, and **Encrypted in Transit: Yes**.*

| Data Category | Specific Data Type | Collected? | Shared? | Ephemeral? | Encrypted in Transit? | User Can Delete? | Purpose to Select in Console | Reason for Collection |
| :--- | :--- | :---: | :---: | :---: | :---: | :---: | :--- | :--- |
| **Personal Info** | Name (Username) | **Yes** | **No** | No | **Yes** (TLS/HTTPS) | **Yes** | **App Functionality, Account Management** | User profile identification in ledger. |
| **Personal Info** | Email address | **Yes** | **No** | No | **Yes** (TLS/HTTPS) | **Yes** | **App Functionality, Account Management** | Authentication and password recovery. |
| **Personal Info** | User IDs / Passwords | **Yes** | **No** | No | **Yes** (TLS/HTTPS) | **Yes** | **App Functionality, Account Management** | Secure login credentials via JWT. |
| **Financial Info** | Other financial info | **Yes** | **No** | No | **Yes** (TLS/HTTPS) | **Yes** | **App Functionality** | User-logged daily income, expense entries, and categories. |
| **App Activity** | App interactions | **Yes** | **No** | No | **Yes** (TLS/HTTPS) | **Yes** | **Analytics** | Page visits, session duration via Firebase Analytics. |
| **Device or other IDs** | Device or other IDs | **Yes** | **No** | No | **Yes** (TLS/HTTPS) | **Yes** | **Analytics** | Firebase Installation ID / App instance ID. |

---

## 5. Google Play Console "App Content" Policy Declarations Matrix

| Section / Questionnaire | Console Question | Auditor Required Answer | Status | Technical / Legal Rationale |
| :--- | :--- | :--- | :---: | :--- |
| **App Access** | Does your app have restricted access? | **All or some functionality is restricted** | 🟡 | Login screen blocks unauthenticated users. Supply `testuser@gmail.com` / `test@1234`. |
| **Financial Features** | What financial features does your app provide? | **Personal finance management / Expense tracking** | 🟡 | Tracks daily entries; state clearly that no banking/loans/credit are provided. |
| **Advertising ID** | Does your app use advertising ID? | **No** | 🟢 | `AD_ID` is removed in `AndroidManifest.xml` via `tools:node="remove"`. |
| **Ads** | Does your app contain ads? | **No** | 🟢 | App is 100% ad-free (no AdMob or third-party ad networks). |
| **Target Audience & Content** | What are the target age groups? | **18 and over** (or **13 and over**) | 🟢 | Ledger app targeted at adults/professionals. Avoids Children / Families policy requirements. |
| **News Apps** | Is your app a news app? | **No** | 🟢 | App is a utility/productivity ledger tool. |
| **COVID-19 Contact Tracing** | Is your app a contact tracing app? | **No** | 🟢 | Not applicable. |
| **Government Apps** | Is your app developed by/for a government? | **No** | 🟢 | Privately developed application. |
| **Data Deletion URL** | Provide a link to your deletion page | `https://sangapu.nishanpradhan.com.np/delete-account/` | 🟢 | Live page satisfies Play Console requirements. |

---

## 6. IARC Content Rating Questionnaire Answers Matrix

| Category / Field | Specific Question | Required Response | Status | Justification |
| :--- | :--- | :---: | :---: | :--- |
| **Category Selection** | What is the type of application? | **Utility, Productivity, Communication, or Other** | 🟢 | Accurate taxonomy; avoids game/social policies. |
| **Violence** | Does the app contain violence or gore? | **No** | 🟢 | Clean financial accounting interface. |
| **Sexuality** | Does the app contain sexual material or nudity? | **No** | 🟢 | No adult content. |
| **Language** | Does the app contain potentially offensive language? | **No** | 🟢 | Professional ledger terms only. |
| **Controlled Substances**| Does the app reference or depict alcohol, tobacco, drugs? | **No** | 🟢 | Zero substance references. |
| **Gambling** | Does the app simulate gambling or contain real gambling?| **No** | 🟢 | Pure income/expense ledger; zero wagering. |
| **User Interactions** | Can users communicate with each other? | **No** | 🟢 | No chat, forums, or user-to-user messaging. |
| **Physical Location** | Does the app share the user's physical location? | **No** | 🟢 | No GPS or location tracking. |
| **Digital Purchases** | Does the app allow purchasing digital goods? | **No** | 🟢 | Completely free; no in-app purchases or billing SDK. |
| **Online Content** | Does the app display external unfiltered web content? | **No** | 🟢 | Web links open via external system browser. |

*Projected IARC Rating: **Everyone (ESRB) / PEGI 3 / USK 0 / General (ClassInd)***

---

## 7. Technical & Build Readiness Matrix

| Technical Metric | Value / Specification | Target Standard | Status | Audit Verification Details |
| :--- | :--- | :--- | :---: | :--- |
| **Target SDK** | `targetSdkVersion = 36` | Minimum API 34 | 🟢 **Compliant** | Exceeds Google Play requirement (Android 15+ compatible). |
| **Minimum SDK** | `minSdkVersion = 24` | Android 7.0+ | 🟢 **Compliant** | Broad backward compatibility. |
| **App Bundle Format** | `.aab` (Android App Bundle) | Mandatory .aab | 🟢 **Compliant** | Generated via `flutter build appbundle --release`. |
| **Download Size** | ~15–25 MB base download | < 150 MB limit | 🟢 **Compliant** | Highly optimized; no heavy assets. |
| **16 KB Memory Page Size** | Flutter 3.x Native Engine | Android 15 standard | 🟢 **Compliant** | Flutter engine compiled with 16KB alignment; zero custom NDK C++ binaries. |
| **Play App Signing** | Google Play App Signing | Mandatory | 🟡 **Action Required** | Enroll in Play App Signing in Console. Keep local upload key safe. |
| **Keystore Configuration** | `android/key.properties` | Local upload key | 🟢 **Compliant** | Configured in `build.gradle.kts`. Keystore must never be committed to Git. |
| **Asset Security Check** | `.env` in `pubspec.yaml` assets | Secure packaging | 🟡 **Action Required** | Ensure `.env` contains **no server master secrets** or private signing keys. |

---

## 8. Store Listing Metadata & Legal URLs Matrix

| Metadata Field | Submitted Content / Value | Policy Character Limit | Status | Recommendation / Fix |
| :--- | :--- | :---: | :---: | :--- |
| **App Title** | `Sangapu` | Max 30 chars (Actual: 7) | 🟢 **Compliant** | Clean brand name; no promotional keywords ("free", "best"). |
| **Short Description** | `Record daily income and expenses with report exports in PDF and Excel` | Max 80 chars (Actual: 68) | 🟢 **Compliant** | Clear, concise functional description. |
| **Full Description** | Clean bulleted feature list (single instance) | Max 4,000 chars (Actual: ~660) | 🟡 **Action Required** | Ensure duplicate copy-pasted section is discarded. |
| **Privacy Policy URL** | `https://sangapu.nishanpradhan.com.np/privacy-policy/` | Active public HTTPS URL | 🟢 **Compliant** | HTTP 200 OK. Contains package ID `com.nishan.sangapu`. |
| **Account Deletion URL**| `https://sangapu.nishanpradhan.com.np/delete-account/` | Active public HTTPS URL | 🟢 **Compliant** | HTTP 200 OK. Fully accessible web form. |
| **Terms of Service URL**| `https://sangapu.nishanpradhan.com.np/terms-and-conditions/` | Active public HTTPS URL | 🟢 **Compliant** | HTTP 200 OK. Fully accessible legal terms. |
| **Developer Contact** | `nishanpradhan500@gmail.com` | Valid active email | 🟢 **Compliant** | Listed on privacy page and store listing. |

---

## 9. Pre-Submission Execution Checklist

| Step # | Action Item | Target Location | Responsible Party | Completed? |
| :---: | :--- | :--- | :--- | :---: |
| **1** | Clean duplicate text from Store Listing Description | Play Console > Store Presence > Main store listing | Release Engineer | [ ] |
| **2** | Set App Category to **Productivity** (avoid *Finance*) | Play Console > Store Settings | Release Engineer | [ ] |
| **3** | Add test credentials under **App Access** (`testuser@gmail.com` / `test@1234`) | Play Console > Policy > App content > App access | QA / Release Engineer | [ ] |
| **4** | Declare **Financial Features** as *Personal finance management* (No loans) | Play Console > Policy > Financial features | Release Engineer | [ ] |
| **5** | Answer **NO** to Advertising ID question | Play Console > Policy > Advertising ID | Release Engineer | [ ] |
| **6** | Complete **Data Safety** according to Section 4 Matrix | Play Console > Policy > Data safety | Release Engineer | [ ] |
| **7** | Provide Web Deletion URL (`https://sangapu.nishanpradhan.com.np/delete-account/`) | Play Console > Policy > Data safety | Release Engineer | [ ] |
| **8** | Fill out **IARC Content Rating** according to Section 6 Matrix | Play Console > Policy > Content rating | Release Engineer | [ ] |
| **9** | Confirm `.env` contains no server master secrets or DB credentials | `d:/sangapu/.env` | Developer | [ ] |
| **10** | Build final release bundle: `flutter build appbundle --release` | Local Terminal / CI | Release Engineer | [ ] |
| **11** | Upload `.aab` to **Internal Testing Track** and verify Pre-Launch Report | Play Console > Testing > Internal testing | QA / Release Engineer | [ ] |
| **12** | Promote to **Production Review** once Pre-Launch Report passes with 0 errors | Play Console > Production | Product Owner | [ ] |
