# AI Feature Roadmap & Transformation Guide for Sangapu

> **Transforming Sangapu from a Manual Bookkeeping Utility into an Intelligent Hotel & Lodge Business Co-Pilot.**

---

## 1. Executive Vision: Why AI for Sangapu?

Currently, **Sangapu** is a reliable, structured mobile ledger for recording daily hotel and lodge earnings (Rooms, Beverages, Others), logging operating expenses, and exporting statements in PDF/Excel.

However, traditional bookkeeping apps suffer from:
1. **Form Fatigue:** Busy receptionists and owners must manually select categories, enter numbers, and type remarks several times every day.
2. **Passive Data:** Numbers sit in tables and lists waiting for the user to analyze them.
3. **Delayed Insights:** Owners only realize profits, losses, or margin drops at the end of the month when exporting PDF statements.

By introducing **Artificial Intelligence (AI)**, Sangapu can transition from a **passive ledger** into an **active, intelligent business co-pilot**. AI will make the app interactive, delightful, effortless, and indispensable for hotel and lodge owners.

---

## 2. Core AI Feature Pillars

```
                     ┌─────────────────────────────────────────┐
                     │          SANGAPU AI CO-PILOT            │
                     └────────────────────┬────────────────────┘
                                          │
         ┌──────────────────┬─────────────┴────────────┬──────────────────┐
         ▼                  ▼                          ▼                  ▼
┌─────────────────┐ ┌───────────────┐        ┌──────────────────┐ ┌───────────────┐
│ Frictionless    │ │ Interactive   │        │ Predictive       │ │ Gamification  │
│ Smart Logging   │ │ Business Chat │        │ Analytics &      │ │ & "Hotel      │
│ (Vision + Voice)│ │ & Briefings   │        │ Anomaly Watchdog │ │ Health Index" │
└─────────────────┘ └───────────────┘        └──────────────────┘ └───────────────┘
```

---

### Pillar 1: Frictionless "Zero-Touch" Data Entry (Vision & Voice AI)

Hotel staff are often multitasking—checking in guests, answering phone calls, handling luggage, or managing kitchen orders. Opening multiple dropdowns and forms is friction-heavy.

#### 1.1 AI Smart Receipt & Bill Scanner (Multimodal Vision OCR)
* **What it does:** The user taps a camera icon and snaps a photo of a vendor receipt (vegetable market bill, meat shop bill, liquor invoice, electricity bill, or handwritten maintenance slip).
* **AI Capability:**
  * Uses on-device OCR (Google ML Kit) combined with Gemini Multimodal Flash to parse handwritten or printed Nepali and English bills.
  * Automatically detects:
    * **Category:** e.g., `Beverage`, `Electricity Bill`, `Maintenance`, `Others`
    * **Amount:** e.g., `Rs. 4,850`
    * **Vendor / Remarks:** e.g., *"10 crates soda + beer bottles - ABC Suppliers"*
    * **Date:** Parsed and matched to Nepali Bikram Sambat (`nepaliDate`).
* **Why it makes the app interesting:** Turning physical paper clutter into an instant, verified ledger entry in under 2 seconds feels magical and saves 90% of manual typing time.

#### 1.2 Bilingual Voice-to-Ledger (Nepali + English Speech AI)
* **What it does:** A floating microphone button allows the manager to simply speak what just happened.
* **Natural Spoken Examples:**
  * *"कोठा नम्बर २०२ बाट रु ३,००० आयो"* → Auto-fills **Income**: Type = `Room`, Custom Price = `3000`, Notes = `Room 202`.
  * *"फाउन्टेन ड्रिंक्स र स्न्याक्सको ८५० आम्दानी"* → Auto-fills **Income**: Type = `Beverage`, Custom Price = `850`, Notes = `Drinks and snacks`.
  * *"धारा मर्मत गर्न प्लम्बरलाई ७०० रुपैयाँ तिरे"* → Auto-fills **Expense**: Category = `Maintenance`, Amount = `700`, Remarks = `Plumber tap repair`.
* **Interactive UI:** The app displays a friendly confirmation bottom sheet showing the recognized text, the proposed breakdown, and a single tap "Confirm & Save" button.

#### 1.3 Natural Language "Omni-Bar"
* A single smart search/log bar on top of the dashboard.
* Instead of deciding whether to go to `Income Entry` or `Add Expense`, staff can type:
  > *"Staff lunch 1200"* or *"Room 101 extended 1800"*
* The AI automatically routes and populates the appropriate model (`IncomeEntryModel` vs `ExpensesRecordModel`).

---

### Pillar 2: "Ask My Hotel" — Interactive Financial Chatbot & Insights

Instead of forcing users to export Excel sheets and calculate metrics on calculators, give them an conversational AI analyst directly inside the app.

#### 2.1 Natural Language Querying
Hotel owners can ask plain-language questions in Nepali or English:
* *"यो महिना पेय पदार्थ (beverage) बाट कति नाफा भयो?"*  
  *(How much profit did we make from beverages this month?)*
* *"How does our room income this week compare to the same week last month?"*
* *"What are our top 3 biggest expenses over the last 90 days?"*
* *"Did we spend more on electricity or maintenance in Baishakh?"*

#### 2.2 Autonomous Daily Executive Audio / Visual Briefing
* **Morning Briefing (7:30 AM):**
  > *"सुप्रभात! Yesterday Sangapu generated Rs. 24,500 in total revenue (82% from Rooms, 18% from Beverage). Your net balance was +Rs. 18,200. Reminder: Electricity bill payment is typically recorded around this time of the month."*
* **Evening Wrap-up (10:00 PM):**
  > A quick interactive summary card with thumbs-up/down performance, comparing today's earnings against the 30-day moving average.
* **Interactive Audio Feature:** A mini play button allows busy owners to listen to the 15-second daily audio summary while walking around the property.

---

### Pillar 3: Predictive Analytics & Anomaly Detection (From Ledger to Strategy)

Turn Sangapu from a historical record book into a forward-looking decision engine.

#### 3.1 Seasonal & Festival Occupancy / Revenue Forecasting
* **The Problem:** Nepal's hospitality industry experiences massive swings depending on seasons (Trekking season, Dashain/Tihar festival holidays, wedding seasons, monsoon slumps).
* **AI Solution:**
  * Correlate historical Bikram Sambat date patterns, local holiday calendars, and day-of-week trends.
  * Project expected room demand and beverage requirements for upcoming weeks.
  * Suggest optimal staffing and inventory purchases before festive surges.

#### 3.2 Dynamic Room Rate Recommendations
* Based on velocity of room bookings, historical occupancy peaks (e.g., Friday/Saturday nights or peak festival days), the AI suggests:
  > *"💡 High demand predicted for upcoming weekend. Consider adjusting standard room pricing from Rs. 2,500 to Rs. 3,200."*

#### 3.3 Expense Leakage & Anomaly Watchdog
* **Fraud & Mistake Prevention:**
  * If a staff member accidentally types `Rs. 50,000` instead of `Rs. 5,000` for a water bill, the AI flags it immediately before submission:
    > *"⚠️ Anomaly Detected: Your average water bill is Rs. 4,500. Are you sure this entry is Rs. 50,000?"*
  * If beverage expenses increase by 35% without a corresponding increase in beverage revenue, the AI alerts the owner:
    > *"⚠️ Margin Compression: Beverage expenses jumped 35% this week, but beverage income stayed flat. Check for stock leakage or supplier price hikes."*

---

### Pillar 4: Smart Beverage & Inventory Assistant

Sangapu already has a dedicated `RoomBeverage` model separating room earnings and beverage earnings. We can enrich this into an inventory co-pilot.

#### 4.1 Automated Restock Prediction
* The AI tracks beverage transaction frequency and recognizes patterns (e.g., Beer, Cold Drinks, Tea/Coffee supplies).
* Calculates estimated depletion rates based on past sales velocity.
* Notifies: *"Based on recent sales, beverage stock might run low before Saturday night."*

#### 4.2 One-Tap Vendor Purchase Orders (WhatsApp / SMS)
* The AI drafts an automated purchase list in Nepali or English:
  > *"नमस्ते साहुजी, Sangapu Lodge को लागि: २ पेटी बियर, १ पेटी कोक, र ५ केजी चिनी पठाइदिनुहोला।"*
* With one tap, it opens WhatsApp (`url_launcher`) pre-filled with the vendor order.

---

### Pillar 5: Gamification & "Hotel Health Index"

Bookkeeping can feel dry and mundane. Gamification transforms bookkeeping into an engaging daily habit.

#### 5.1 Sangapu Hotel Health Score (0 – 100)
A dynamic, beautifully animated score on the dashboard reflecting operational excellence:
* **Liquidity & Cash Flow Stability:** (Is net balance consistently healthy?)
* **Expense-to-Income Ratio:** (Are expenses kept under healthy thresholds?)
* **Data Freshness / Consistency Streak:** (Has data been logged continuously for 14 days?)
* **Level Progression:** From *"Lodge Starter"* ➔ *"Operational Master"* ➔ *"Hospitality Pro"*.

#### 5.2 "What-If" Scenario Simulator
An interactive slider interface powered by AI simulation:
* *"What if we increase Room prices by 10%?"* ➔ AI projects: *"+Rs. 42,000 projected monthly profit, assuming 3% occupancy variation."*
* *"What if we cut electricity waste by 15%?"* ➔ AI calculates exact annual savings.

---

### Pillar 6: Customer Hospitality & Digital Folio AI

Help hotel staff delight guests at checkout.

#### 6.1 Smart Guest Invoice & Thank You Note Generator
* When recording income from a room check-out, the AI can generate a clean, branded digital receipt with a polite, personalized message:
  > *"Thank you Mr. Nissan for staying with us at Sangapu Lodge! We hope you enjoyed your time in the hills. Safe travels!"*
* Shareable instantly via WhatsApp or printable via Bluetooth thermal printer.

#### 6.2 Review & Feedback Sentiment Analyzer
* Paste guest reviews or verbal feedback into the app.
* AI summarizes positive highlights and urgent operational action items (e.g., *"3 guests in Room 204 mentioned weak Wi-Fi signal; Room 102 hot water tap needs inspection"*).

---

## 3. Comparison Matrix: Sangapu Before vs. After AI

| Feature Area | Current Sangapu (Manual Utility) | Sangapu with AI (Intelligent Co-Pilot) | User Impact |
| :--- | :--- | :--- | :--- |
| **Expense Entry** | Manual dropdown selection, typing amount, typing remarks | Snap photo of bill or receipt; AI extracts and classifies all fields | ⚡ 80% faster logging |
| **Data Logging** | Navigating to separate Income/Expense forms | Single voice command or omni-bar in Nepali or English | 🎙️ Hands-free operation |
| **Reports & Analysis** | Export static PDF / Excel and manually compute trends | Natural language chat: *"What was my highest expense this month?"* | 🧠 Instant business insights |
| **Decision Making** | Retrospective analysis (looking backward after month-end) | Predictive forecasting (occupancy, seasonal surges, rate suggestions) | 📈 Increased revenue & occupancy |
| **Mistake Prevention** | None; typos are saved directly to database | AI anomaly detection flags irregular expenses or accidental zeros | 🛡️ Eliminates accounting errors |
| **User Engagement** | Transactional check-in tool (open for 1 min, close) | Daily interactive briefing, Hotel Health Score, What-If simulator | 🌟 High daily delight & retention |

---

## 4. Technical Architecture for Flutter Implementation

To maintain Sangapu's speed, low APK size, privacy, and offline capabilities, a **Hybrid On-Device & Edge AI Architecture** is recommended:

```
┌─────────────────────────────────────────────────────────────────┐
│                      SANGAPU FLUTTER APP                        │
│                                                                 │
│  ┌───────────────────────────┐    ┌──────────────────────────┐  │
│  │   On-Device Fast ML       │    │  Edge / Cloud AI         │  │
│  │   • Google ML Kit OCR     │    │  • Gemini 2.5 Flash API  │  │
│  │   • Speech-to-Text (STT)  │    │  • Structured JSON Output│  │
│  │   • Rule Anomaly Filter   │    │  • Natural Language Chat │  │
│  └─────────────┬─────────────┘    └────────────┬─────────────┘  │
│                │                               │                │
│                ▼                               ▼                │
│  ┌───────────────────────────────────────────────────────────┐  │
│  │     Sangapu Repository Layer (Dio + Hive Offline Cache)   │  │
│  └───────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

### 4.1 Recommended Flutter Packages & Services
1. **Multimodal OCR & Vision:**
   * `google_mlkit_text_recognition`: Instant, offline text extraction from camera/gallery.
   * `google_generative_ai` (Gemini API SDK for Dart): Structured parsing of receipt text into `ExpensesRecordModel` JSON.
2. **Voice Recognition:**
   * `speech_to_text`: Real-time on-device voice transcription in English & Nepali.
3. **Structured Tool Calling:**
   * Gemini Function Calling to execute app actions:
     ```dart
     // Example function tool definition
     final logExpenseTool = FunctionDeclaration(
       'logExpense',
       'Logs an expense into Sangapu database',
       parameters: { ... }
     );
     ```
4. **Data Privacy & Play Store Compliance:**
   * User privacy is preserved: receipts processed on user consent.
   * Minimal permissions: Camera permission requested only when user taps "Scan Receipt".

---

## 5. Phased Implementation Roadmap

### Phase 1: High-Impact Quick Wins (Weeks 1–3)
- [ ] **Smart Receipt Scanner:** Add camera icon in `AddExpenses` page. Extract bill amount, category, and remarks using Google ML Kit + Gemini Flash.
- [ ] **Omni-Bar Natural Language Quick Log:** Top-level input bar on the Dashboard to log single entries without opening sub-forms.

### Phase 2: Conversational & Financial Insights (Weeks 4–6)
- [ ] **"Ask Sangapu" Assistant Drawer / Floating Action Button:** Conversational chat interface querying transaction history, category breakdowns, and net balance.
- [ ] **Daily Morning Briefing Card:** Dynamic card on dashboard summarizing yesterday's performance and upcoming expense alerts.

### Phase 3: Voice AI & Anomaly Watchdog (Weeks 7–9)
- [ ] **Bilingual Voice Input (Nepali/English):** Voice mic button in Income and Expense entry forms.
- [ ] **Real-time Anomaly Detection:** Warning dialogs when expenses deviate significantly from historical moving averages.

### Phase 4: Strategy & Predictive Intelligence (Weeks 10+)
- [ ] **Hotel Health Score:** Gamified business metric on the Dashboard.
- [ ] **Seasonal & Occupancy Forecasting:** Predictive trend line in reports and statements.
- [ ] **What-If Scenario Simulator:** Interactive profit modeling for room pricing and cost cuts.

---

## 6. Summary

Integrating AI into **Sangapu** transforms it from a **daily ledger chore** into an **indispensable digital business partner**. By combining effortless multimodal inputs (snap a photo of a bill, speak in Nepali) with proactive, intelligent insights (anomaly detection, occupancy forecasting, and conversational Q&A), Sangapu will offer an unmatched, modern experience for hotel and lodge operators in Nepal.
