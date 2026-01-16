# 👟 Sneaker App

Sneaker App is a Flutter-based mobile application designed for browsing and exploring sneakers with a clean, modern, and user-friendly interface. This project showcases Flutter app development, Firebase integration, GitHub workflow, and secure handling of sensitive configuration files.

The application is built as a learning and portfolio project, following industry-standard practices for mobile development and repository security.

---

## 📱 Features

- Browse sneaker products
- View detailed sneaker information
- Clean and modern user interface
- Smooth navigation and fast performance
- Firebase integration
- Secure configuration with no exposed API keys

---

## 🧑‍💻 Tech Stack

- Flutter (Dart)
- Firebase
- Android
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


---

## 🚀 Getting Started

Follow the steps below to run this project locally.

### Step 1: Clone the repository



git clone https://github.com/NileshKumar906/Sneaker-app.git

cd Sneaker-app


### Step 2: Install dependencies



flutter pub get


### Step 3: Firebase setup

1. Create a project in the Firebase Console
2. Add an Android app to the project
3. Download the `google-services.json` file
4. Place the file inside the following directory:



android/app/


Note: The `google-services.json` file is intentionally not included in the repository for security reasons.

### Step 4: Run the application



flutter run


---

## 🔐 Security Practices

- API keys are restricted using SHA-1
- `google-services.json` is excluded using `.gitignore`
- GitHub Secret Scanning is enabled
- No sensitive credentials are committed to the repository

This project follows proper security practices recommended for public repositories.

---

## 🎯 Purpose of the Project

This project was created for learning and practice, with a focus on:
- Flutter mobile app development
- Firebase configuration and usage
- Git and GitHub workflow
- Secure handling of API keys
- Writing clean and professional documentation

---

## 📌 Future Improvements

- User authentication
- Wishlist and cart functionality
- Payment gateway integration
- Improved UI/UX
- Backend enhancements

---

## 👨‍💻 Author

Nilesh Kumar  
GitHub: https://github.com/NileshKumar906

---

## ⭐ Support

If you like this project or find it useful, please consider giving it a star ⭐ on GitHub.
