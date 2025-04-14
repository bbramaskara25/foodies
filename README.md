# 🍱 Foody — iOS Food Recommendation App

**Foody** is a native iOS app that helps users find and order meals from stalls in their area using a chat-based recommender system. Users can explore all stalls, interact with a friendly Q&A chatbot to get personalized suggestions, or quickly reorder from their order history.

![Foody Banner](banner.png) <!-- optional screenshot/banner -->

---

## 📱 Features

- 🧠 **Recommendation Bot**: Chat-based meal recommendation with guided Q&A flow
- 📦 **Quick Reorder**: Smart recall of last 3 orders for fast checkout
- 🔍 **Explore All Stalls**: Browse detailed menus and prices
- 💬 **WhatsApp Ordering**: Place orders via WhatsApp with one tap
- 🧾 **Order History**: Local persistence using SwiftData for seamless reorder

---

## 🛠️ Technologies Used

| Layer                   | Tooling / Framework   | Purpose                              |
|------------------------|-----------------------|--------------------------------------|
| Language               | **Swift**             | Core programming language            |
| UI Framework           | **SwiftUI**           | Declarative UI layout and components |
| Local Persistence      | **SwiftData**         | Save user orders locally             |
| Navigation & State     | `@State`, `@Binding`  | Track and respond to UI state        |
| Interaction & Logic    | `ChatViewModel`       | Drives conversation and filtering    |
| Native Integration     | `UIApplication.open`  | Opens WhatsApp with order message    |

---

## 📸 Screenshots

| Start Page                          | Chat Bot Recommender                | Order Confirmation                   |
|------------------------------------|------------------------------------|-------------------------------------|
| ![start](screenshots/start.png)    | ![chat](screenshots/chatbot.png)   | ![order](screenshots/confirmation.png) |

---

## 🧩 Architecture Overview

