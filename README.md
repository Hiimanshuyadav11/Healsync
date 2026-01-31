
---

````md
# HealSync 🩺🌿

HealSync is an AI-powered, chat-based application for **mental and physical wellness**.  
It combines conversational AI, document-aware insights, and safety-first health guidance
to help users understand symptoms, reflect on mental health, and interact with their own
medical data in a structured and responsible way.

> ⚠️ HealSync does **not** provide medical diagnoses or prescriptions.  
> It is designed to support awareness, triage, and informed next steps — not replace
professional healthcare.

---

## ✨ Key Features

### 💬 AI-Powered Chat
- Conversational interface for discussing mental and physical wellness
- Backend-driven responses (no mock or hardcoded replies)
- Designed with medical safety guardrails

### 📄 Document-Aware Health Insights (RAG)
- Upload **PDF medical reports**
- Documents are indexed into a vector database (Qdrant)
- Ask questions grounded **only in your uploaded reports**
- Reduces hallucinations and improves reliability

### 🚦 Health Triage & Safety
- Structured flow to assess urgency (low / medium / high)
- Avoids diagnoses, prescriptions, or unsafe medical advice
- Encourages professional consultation when appropriate

### 🧠 Mental Wellness Support
- Supports reflective conversations for emotional well-being
- Designed to integrate CBT-style journaling and reframing in future iterations

### 🧱 Extensible Architecture
Built to support future features such as:
- Wearable integrations
- Doctor summaries
- Health analytics dashboards
- Long-term user context

---

## 🛠️ Tech Stack

### Frontend
- **Flutter** (Mobile, Web, Desktop)
- Clean chat UI with attachment support

### Backend
- **Node.js + Express**
- REST-based API architecture

### AI & Data
- **LLM APIs** for reasoning and responses
- **Qdrant** for vector search (RAG)
- **MongoDB** (planned / optional) for persistence

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK
- Node.js (v18+ recommended)
- Docker (for Qdrant)
- API key for your chosen LLM provider

---

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/Hiimanshuyadav11/Healsync.git
cd Healsync
````

---

### 2️⃣ Run Qdrant (Vector Database)

```bash
docker run -p 6333:6333 qdrant/qdrant
```

Qdrant dashboard:

```
http://localhost:6333/dashboard
```

---

### 3️⃣ Backend Setup

```bash
cd backend
npm install
```

Create a `.env` file (not committed):

```env
OPENAI_API_KEY=your_api_key_here
QDRANT_URL=http://localhost:6333
QDRANT_COLLECTION=medical_docs
```

Start the backend:

```bash
npm run dev
```

---

### 4️⃣ Run the Flutter App

```bash
flutter pub get
flutter run
```

---

## 🧪 Usage

* Start a chat and ask wellness-related questions
* Upload a **PDF medical report**
* Ask follow-up questions based on that document
* Observe AI responses grounded in uploaded data

---

## 🔐 Safety & Disclaimer

HealSync is a **wellness support tool**, not a medical device.

* It does not diagnose diseases
* It does not prescribe medication
* It should not be used for emergencies

Always consult a qualified healthcare professional for medical concerns.

---

## 📌 Project Status

This project is under **active development**.
The current focus is on building a reliable AI foundation, safety mechanisms,
and document-grounded responses.

---

## 📚 Resources

* [Flutter Documentation](https://docs.flutter.dev/)
* [Qdrant Documentation](https://qdrant.tech/documentation/)
* [Responsible AI Guidelines](https://platform.openai.com/docs/usage-policies)

---

## 🤝 Contributing

Contributions are welcome!
Please use feature branches and open a pull request with a clear description
of your changes.

---

## 📄 License

This project is licensed under the MIT License.

```




