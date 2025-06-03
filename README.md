# 🧠 Universal Switch Setup – Secure Smart Switch Configuration System

**Universal Switch Setup** is a secure configuration software designed for smart switches. It allows encrypted communication between devices and provides a local admin dashboard for managing encryption settings, ensuring both flexibility and security.

---

## 🔍 Overview

Universal Switch Setup enables users to:

- **Add and encrypt switch configuration data**
- **Send encrypted data securely**
- **Receive and process data via a local server**
- **Access an admin dashboard to manage encryption algorithms and settings**

This system is ideal for embedding into **smart switches**, making them more secure and manageable from a central, protected interface.

---

## ⚙️ How It Works

1. **Data Input & Encryption**  
   The user inputs configuration data which is encrypted using a chosen algorithm.

2. **Data Transmission**  
   The encrypted data is securely sent to the receiving system.

3. **Local Server**  
   A **local server** runs on the receiving device to handle incoming data and decrypt it.

4. **Admin Dashboard**  
   The admin logs into a protected dashboard to:
   - View logs and activity
   - Select and configure encryption algorithms
   - Manage device connections

---

## 🔐 Features

- 🔒 **Customizable Encryption**  
  Admin can select from various encryption algorithms (e.g., AES, RSA).

- 🖥️ **Admin Dashboard**  
  Secure login with full control over encryption and configuration.

- 📡 **Secure Data Transmission**  
  Data is always encrypted before being sent and decrypted only at the destination.

- 📶 **Local Server Communication**  
  Communication between devices happens over a local server for low latency and privacy.

- 🔌 **Smart Switch Integration**  
  Designed to be embedded into smart switch firmware or control modules.

---

## 🚀 Installation & Setup

### 🛠 Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK
- (Optional) Node.js or Python for backend if needed

### 📦 Clone the Repository

```bash
git clone https://github.com/parth7039/universal-switch-setup.git
cd universal-switch-setup
flutter pub get
flutter run
