# 🚨 CITIZEN-107
**Emergency Response & Volunteer Coordination Platform**

CITIZEN-107 is a Flutter application built to provide immediate assistance during emergencies. It connects users in distress with "Approved" volunteers in their specific city using real-time geolocation and Firebase Cloud Messaging (FCM).

---

## 📸 Overview
The app allows a user to select a type of injury/emergency, automatically determines their current city, and broadcasts a high-priority alert to all available volunteers registered in that city.

## 🚀 Features
* **Automatic Geolocation:** Uses `geolocator` and `geocoding` to find the user's city.
* **Smart Filtering:** Only notifies volunteers in the `_USERS` collection where `status == 'approved'` and `serviceCity` matches the incident location.
* **Direct FCM Messaging:** Implements the Google Auth library to securely send notifications via the FCM V1 API.
* **Environmental Security:** Uses `.env` to manage sensitive Google Cloud Project credentials.

## 🛠 Tech Stack
* **Frontend:** Flutter & Dart
* **Backend:** Firebase Firestore
* **Notifications:** Firebase Cloud Messaging (FCM)
* **Auth:** Google APIs Auth (`googleapis_auth`)

---

## ⚙️ Setup & Installation

### 1. Environment Configuration
Create a `.env` file in the root directory. This project requires the following keys from your Google Cloud Service Account:
```env
GCP_PROJECT_ID=citizen-107-a2440
GCP_PRIVATE_KEY_ID=your_private_key_id
GCP_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\nYour_Key_Content\n-----END PRIVATE KEY-----\n"
GCP_CLIENT_EMAIL=your-service-account@citizen-107.iam.gserviceaccount.com
```
