# SecureBank – A Modern iOS Banking App (SwiftUI Demo)
*Built with SwiftUI, Combine, Keychain, and Offline-First Architecture – Inspired by Chase & Wells Fargo*

[![Swift 6](https://img.shields.io/badge/Swift-6-orange.svg)](https://swift.org)
[![iOS 17+](https://img.shields.io/badge/iOS-17%2B-blue.svg)](https://developer.apple.com/ios/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## Overview

**SecureBank** is a **fully functional, production-ready iOS banking app prototype** built from scratch in **SwiftUI** – perfect for learning, interviews, or as a foundation for a real fintech product.

It replicates core features of **Chase**, **Wells Fargo**, and **Zelle**, including:

- **Biometric Login** (Face ID / Touch ID)
- **Real-time Dashboard** with balances & transaction history
- **Zelle-style P2P Transfers** (search by name, email, phone)
- **Standard Bank Transfers** (account-to-account)
- **Offline Mode** – works on low/no signal
- **Secure Token Storage** via Keychain
- **Optimistic UI** – instant feedback, syncs later
- **Smooth Animations & Accessibility**

---

## Key Features

| Feature              | Description                                      |
|----------------------|--------------------------------------------------|
| **Face ID Login**    | Secure biometric auth with fallback              |
| **Dashboard**        | Live account balances, recent transactions       |
| **Zelle P2P Pay**    | Search contacts, send instantly – even offline   |
| **Transfer Funds**   | Send to any account with confirmation            |
| **Offline Resilience** | Queue actions, sync when back online           |
| **Secure Storage**   | Tokens encrypted in Keychain                     |
| **SwiftUI Animations** | Smooth transitions, lazy loading               |
| **Low Data Mode Ready** | Optimized for poor networks                    |

---

## Tech Stack

- **Language**: Swift 6
- **UI Framework**: SwiftUI (declarative, modern)
- **Architecture**: MVVM + Combine (reactive)
- **Storage**: `UserDefaults` (demo), ready for **Core Data**
- **Security**: `LocalAuthentication`, `Keychain`, `CryptoKit`
- **Networking**: Mocked (ready for Alamofire / URLSession)
- **Xcode**: 16+ (iOS 17+)

---

## Project Structure

```text
SecureBank/
├── SecureBankApp.swift                 # App entry
├── Models/
│   └── Account.swift
├── Services/
│   ├── AuthService.swift
│   ├── KeychainHelper.swift
│   └── BankDataService.swift
├── Views/
│   ├── LoginView.swift
│   ├── DashboardView.swift
│   ├── TransferView.swift
│   ├── P2PTransferView.swift       # Zelle-style
│   ├── ProfileView.swift
│   └── MainTabView.swift
├── README.md
└── LICENSE
