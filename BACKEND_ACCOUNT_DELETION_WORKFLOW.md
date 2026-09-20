# Backend Implementation Workflow: Account & Data Deletion
**Project:** Sangapu Backend API  
**Target:** Google Play User Data & Account Deletion Policy Compliance  
**Base URL:** `https://sangapu.nishanpradhan.com.np/api/`  
**Authentication:** JWT Bearer (`access` / `refresh`)

---

## 1. Executive Summary & Google Play Requirements

Under Google Play's **User Data Policy (Account Deletion Requirement)**, every app that allows account creation or requires login must provide:
1. **An in-app option** for logged-in users to initiate permanent account deletion.
2. **A public web link** where users can request account and associated data deletion from any browser without having the app installed.

Both flows can be powered by the **same backend architecture and deletion logic**.

---

## 2. Architecture & Request Flow

```text
 ┌─────────────────────────────────────────────────────────┐
 │                   Sangapu Mobile App                    │
 │               (User logged in with JWT)                 │
 └────────────────────────────┬────────────────────────────┘
                              │
                              │ 1. DELETE /api/auth/account/
                              │    Header: Authorization: Bearer <access_token>
                              ▼
 ┌─────────────────────────────────────────────────────────┐
 │                   Public Web Landing                    │
 │         https://.../account-deletion (Form)             │
 └────────────────────────────┬────────────────────────────┘
                              │
                              │ 2. Web Form Login / Direct Action:
                              │    POST /api/auth/login/ -> DELETE /api/auth/account/
                              ▼
 ┌────────────────────────────────────────────────────────────────────────┐
 │                       Shared Backend Deletion Logic                    │
 │                                                                        │
 │  Step A: Authenticate & identify request user                          │
 │  Step B: Invalidate all active JWT tokens (Blacklist refresh tokens)   │
 │  Step C: Cascade or anonymize user-linked records (ledger/expenses)   │
 │  Step D: Erase or deactivate the user auth profile                     │
 │  Step E: Return 200 OK / 204 No Content                                │
 └────────────────────────────────────────────────────────────────────────┘
```

---

## 3. API Specification

### Endpoint: Delete Authenticated Account
* **URL:** `/api/auth/account/`
* **HTTP Method:** `DELETE`
* **Authentication:** Required (`Bearer <access_token>`)

#### Request Headers:
```http
Authorization: Bearer <JWT_ACCESS_TOKEN>
Content-Type: application/json
```

#### Optional Request Body (Password Confirmation for Security):
```json
{
  "password": "user_current_password"
}
```
*(Note: If password confirmation is required, the Flutter app and web portal will supply it prior to triggering the deletion).*

#### Successful Response (`200 OK` or `204 No Content`):
```json
{
  "status": "success",
  "message": "Your account and all associated personal data have been permanently deleted."
}
```

#### Error Responses:
* `401 Unauthorized`:
  ```json
  {
    "detail": "Authentication credentials were not provided or have expired."
  }
  ```
* `400 Bad Request` (If password verification fails):
  ```json
  {
    "detail": "Incorrect password. Account deletion aborted."
  }
  ```

---

## 4. Data Retention & Deletion Policy Rules

Google Play requires developers to clearly specify what data is deleted vs. what is retained:

| Data Category | Handling on Account Deletion | Google Play Policy Compliance |
| :--- | :--- | :--- |
| **Authentication & Profile** (Email, Password Hash, Name, Phone) | **Hard Delete / Erase** | Mandatory to wipe personal identifiable info (PII). |
| **Active Sessions & Tokens** (JWT Refresh tokens, FCM push tokens) | **Revoke & Blacklist** | Prevents any subsequent access after deletion. |
| **Financial & Ledger Records** (Daily Income, Daily Expenses, Statements) | **Option A (Default):** Delete all records owned by user.<br>**Option B (Enterprise/Shared):** Anonymize (`user_id = NULL`), retain only aggregated balance logs for statutory financial/tax reporting for 90 days. | Disclosed on the web deletion page as a legal/tax retention exemption. |
| **Cached / Temporary Media** (Uploaded receipt photos, avatar images) | **Delete from S3 / Local Media storage** | Must be removed from storage buckets. |

---

## 5. Django REST Framework Implementation Guide

If the backend is built with **Django REST Framework** (`djangorestframework-simplejwt`):

### 5.1. View Implementation (`views.py`)
```python
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.tokens import OutstandingToken, BlacklistedToken
from django.contrib.auth import get_user_model
from django.db import transaction

User = get_user_model()

class DeleteAccountView(APIView):
    permission_classes = [IsAuthenticated]

    def delete(self, request, *args, **kwargs):
        user = request.user
        password = request.data.get("password")

        # Optional: Verify password before deletion if sent
        if password and not user.check_password(password):
            return Response(
                {"detail": "Invalid password confirmation."},
                status=status.HTTP_400_BAD_REQUEST
            )

        with transaction.atomic():
            # 1. Invalidate all SimpleJWT tokens for this user
            try:
                tokens = OutstandingToken.objects.filter(user=user)
                for token in tokens:
                    BlacklistedToken.objects.get_or_create(token=token)
            except Exception:
                pass  # Ignore if token blacklisting app is not enabled

            # 2. Cleanup or cascade user-specific data (Customize for your models)
            # e.g., Income.objects.filter(user=user).delete()
            # e.g., Expense.objects.filter(user=user).delete()

            # 3. Delete the user
            user.delete()

        return Response(
            {
                "status": "success",
                "message": "Account and associated data have been permanently deleted."
            },
            status=status.HTTP_200_OK
        )
```

### 5.2. URL Routing (`urls.py`)
```python
from django.urls import path
from .views import DeleteAccountView

urlpatterns = [
    # Existing auth routes...
    # path('auth/login/', ...),
    path('auth/account/', DeleteAccountView.as_view(), name='delete_account'),
]
```

---

## 6. Public Web Deletion URL (Google Play Mandatory Requirement)

Google Play Store checks for a live web URL where users can request account and data deletion without the app installed (e.g., `https://sangapu.nishanpradhan.com.np/delete-account`).

### 6.1. Web Page Structure (Static HTML or Template)
Deploy a simple web page on your domain with the following content:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Sangapu - Account & Data Deletion Request</title>
  <style>
    body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; line-height: 1.6; color: #2D3748; max-width: 700px; margin: 40px auto; padding: 0 20px; }
    h1 { color: #1A202C; }
    .card { background: #F7FAFC; border: 1px solid #E2E8F0; border-radius: 8px; padding: 24px; margin: 20px 0; }
    .btn { background: #E53E3E; color: white; border: none; padding: 12px 20px; border-radius: 6px; cursor: pointer; font-size: 15px; font-weight: bold; }
    input[type="email"], input[type="password"] { width: 100%; padding: 10px; margin: 8px 0 16px; border: 1px solid #CBD5E0; border-radius: 6px; box-sizing: border-box; }
    .notice { font-size: 14px; color: #718096; margin-top: 16px; }
  </style>
</head>
<body>
  <h1>Sangapu - Account & Data Deletion</h1>
  <p>If you have an account in the Sangapu application and wish to permanently delete your account along with your personal data, you can do so directly using this page or within the mobile application.</p>

  <div class="card">
    <h3>Self-Service Account Deletion</h3>
    <form id="deleteForm">
      <label for="email">Registered Email Address:</label>
      <input type="email" id="email" required placeholder="Enter your registered email">

      <label for="password">Password:</label>
      <input type="password" id="password" required placeholder="Enter your password">

      <button type="submit" class="btn" id="submitBtn">Permanently Delete My Account</button>
    </form>
    <div id="statusMessage" style="margin-top: 16px; font-weight: bold;"></div>
  </div>

  <div class="card">
    <h3>Data Deletion Policy & Retention Summary</h3>
    <ul>
      <li><strong>Data Deleted:</strong> Your login credentials, user profile (name, email), device tokens, and personal ledger settings are immediately and permanently erased.</li>
      <li><strong>Associated Data:</strong> Income, expense, and statement records associated with this account are deleted from our servers.</li>
      <li><strong>Retention Period:</strong> Account credentials are deleted immediately. Aggregated accounting logs or receipts required by applicable tax or financial regulations are purged within 90 days of request.</li>
    </ul>
  </div>

  <script>
    const form = document.getElementById('deleteForm');
    const msg = document.getElementById('statusMessage');
    const btn = document.getElementById('submitBtn');

    form.addEventListener('submit', async (e) => {
      e.preventDefault();
      if (!confirm("Are you sure you want to permanently delete your account and all data? This action cannot be undone.")) return;

      btn.disabled = true;
      btn.innerText = "Processing...";
      msg.innerText = "";

      const email = document.getElementById('email').value;
      const password = document.getElementById('password').value;

      try {
        // 1. Authenticate to obtain token
        const loginRes = await fetch('https://sangapu.nishanpradhan.com.np/api/auth/login/', {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ email, password })
        });
        const loginData = await loginRes.json();

        if (!loginRes.ok || !loginData.access) {
          throw new Error(loginData.detail || "Authentication failed. Please check your credentials.");
        }

        // 2. Call delete account endpoint with JWT
        const deleteRes = await fetch('https://sangapu.nishanpradhan.com.np/api/auth/account/', {
          method: 'DELETE',
          headers: {
            'Authorization': 'Bearer ' + loginData.access,
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({ password })
        });

        if (deleteRes.ok) {
          form.style.display = 'none';
          msg.style.color = '#38A169';
          msg.innerText = "Success: Your account and associated data have been permanently deleted.";
        } else {
          const errData = await deleteRes.json();
          throw new Error(errData.detail || "Failed to delete account. Please contact support.");
        }
      } catch (err) {
        msg.style.color = '#E53E3E';
        msg.innerText = err.message;
        btn.disabled = false;
        btn.innerText = "Permanently Delete My Account";
      }
    });
  </script>
</body>
</html>
```

---

## 7. Testing & Verification Steps

1. **Verify via `cURL`**:
   ```bash
   # 1. Login to obtain access token
   curl -X POST "https://sangapu.nishanpradhan.com.np/api/auth/login/" \
        -H "Content-Type: application/json" \
        -d '{"email":"test_delete@sangapu.com", "password":"TestPassword123!"}'

   # 2. Call DELETE endpoint
   curl -X DELETE "https://sangapu.nishanpradhan.com.np/api/auth/account/" \
        -H "Authorization: Bearer <ACCESS_TOKEN>" \
        -H "Content-Type: application/json"

   # 3. Verify user cannot log in anymore
   curl -X POST "https://sangapu.nishanpradhan.com.np/api/auth/login/" \
        -H "Content-Type: application/json" \
        -d '{"email":"test_delete@sangapu.com", "password":"TestPassword123!"}'
   # Expected: 401 Unauthorized / "No active account found with the given credentials"
   ```

2. **Verify Public URL**:
   Open the public URL in an incognito window without being logged in anywhere. Verify:
   * The page renders cleanly on mobile and desktop.
   * Disclosures clearly state what data is deleted and the retention timeline.
   * Form successfully triggers deletion against the backend API.

---

## 8. Play Console Data Safety Form Updates

Once this endpoint and web URL are live:
1. In Google Play Console $\rightarrow$ **App content** $\rightarrow$ **Data safety**:
   * *Does your app provide a way for users to request that their data is deleted?* $\rightarrow$ **Yes**.
   * Enter the live deletion URL (e.g. `https://sangapu.nishanpradhan.com.np/delete-account`).
2. Mark whether users can delete their entire account or only specific data $\rightarrow$ Select **"Users can delete their entire account and all associated data"**.
