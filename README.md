
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

https://github.com/user-attachments/assets/fc3fd9b0-2411-4583-9ade-ae9c3fddf0d5
