# 👟 Sneaker App

Sneaker App is a Flutter-based mobile application for browsing and exploring sneakers with a clean, modern, and user-friendly interface. The app integrates Firebase services for authentication and data storage and follows industry-standard security and GitHub practices.

This project is built as a learning and portfolio application to demonstrate real-world Flutter development skills.

---

## 📱 Features

- Browse sneaker products
- View detailed sneaker information
- User authentication using Firebase
- Cloud Firestore database integration
- Image upload using Firebase Storage
- Clean and modern UI
- Smooth navigation and fast performance
- Secure configuration with no exposed API keys

---

## 🧑‍💻 Tech Stack

### Frontend
- Flutter (Dart)

### State Management
- Riverpod

### Backend / Services
- Firebase Authentication
- Cloud Firestore
- Firebase Storage

### Other Libraries
- Image Picker
- UUID
- Intl
- Iconsax

### Platform
- Android

### Version Control
- Git & GitHub

---

## 📂 Project Structure

lib/
├── screens/ # UI screens
├── widgets/ # Reusable widgets
├── models/ # Data models
└── main.dart # Application entry point

android/
ios/
pubspec.yaml

yaml
Copy code

---

## 🚀 Getting Started

Follow the steps below to run this project locally.

### Step 1: Clone the repository

```bash
git clone https://github.com/NileshKumar906/Sneaker-app.git
cd Sneaker-app
Step 2: Install dependencies
bash
Copy code
flutter pub get
Step 3: Firebase Setup
Create a project in the Firebase Console

Add an Android app to the project

Download the google-services.json file

Place the file inside:

bash
Copy code
android/app/
Note:
google-services.json is intentionally not included in the repository for security reasons.

Step 4: Run the application
bash
Copy code
flutter run
🔐 Security Practices
API keys restricted using SHA-1

google-services.json excluded using .gitignore

GitHub Secret Scanning enabled

No sensitive credentials committed to the repository

This project follows proper security practices recommended for public repositories.

🎯 Purpose of the Project
This project was created for learning and practice, focusing on:

Flutter mobile app development

Firebase integration (Auth, Firestore, Storage)

State management using Riverpod

Git and GitHub workflow

Secure handling of API keys

Writing clean and professional documentation

📌 Future Improvements
Wishlist and cart functionality

Payment gateway integration

Advanced search and filters

UI/UX improvements

Performance optimization

👨‍💻 Author
Nilesh Kumar
GitHub: https://github.com/NileshKumar906

⭐ Support
If you like this project or find it useful, please consider giving it a star ⭐ on GitHub.

yaml
Copy code

---
