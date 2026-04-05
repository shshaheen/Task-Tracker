# 🚀 Task Tracker: Real-Time Kanban Ecosystem

A sophisticated, production-ready collaborative task management platform designed for modern teams. This ecosystem provides a seamless, high-performance Kanban workflow with sub-millisecond synchronization across all connected devices.

---

## 🎨 Project Overview

Task Tracker is more than just a to-do list; it's a **collaborative synchronization engine**. Built to solve the friction of stale data in team environments, it ensures that every task move, edit, or deletion is reflected instantly across the entire organization.

Whether you are managing a Marketing pipeline or a Software Development sprint, Task Tracker provides a unified source of truth with:
- **Instant Synchronization**: Powered by WebSockets for an "always-live" experience.
- **Team-Centric Boards**: Dedicated workspaces for different organizational units.
- **Cross-Device Persistence**: Reliable cloud-hosted data that stays in sync from mobile to desktop.

---

## ✨ Key Features

### 👥 Team Management
Create and organize workspaces for different departments. Each team has its own dedicated Kanban board, ensuring clarity and focus without cross-departmental noise.

### 📝 Dynamic Task Lifecycle
Create, edit, and manage tasks with rich metadata, including descriptions, priority levels (Low, Medium, High), and status tracking.

### ⚡ Real-Time Sync (Socket.IO)
Experience zero-refresh updates. When a colleague moves a task on their device, you see it slide into the new column on yours instantly, without ever pulling-to-refresh.

### ✋ Drag-and-Drop Organization
Intuitively transition tasks between "To Do", "In Progress", and "Done" states using a physics-based drag-and-drop interface.

### 🌓 Theme Intelligence
Full support for both **Dark** and **Light** modes, dynamically matching your system preferences with a premium, brand-tailored color palette.

### 🛡️ Error Handling & Validation
Robust input validation and network error handling ensure that your data is safe, even during intermittent connectivity.

---

## 🏗️ Project Architecture

The system follows a modern decoupled architecture, separating the real-time backend from the cross-platform frontend.

### Folder Structure
```bash
task-tracker/
├── frontend/           # Flutter Mobile & Web application
│   ├── lib/            # BLoC logic, UI widgets, and API services
│   ├── assets/         # High-resolution branding and images
│   └── test/           # Unit and widget test suites
├── backend/            # Node.js + Express server
│   ├── controllers/    # Business logic and Socket event emitters
│   ├── models/         # MongoDB/Mongoose data schemas
│   └── routes/         # RESTful API endpoint definitions
├── docs/               # Architecture diagrams and technical specs
├── .env.example        # Environment template for quick setup
└── README.md           # Master documentation
```

### Layer Responsibilities
- **Frontend (UI/State)**: Uses the **BLoC pattern** to ensure business logic is entirely separated from the presentation layer. It manages optimistic UI updates for a snappy feel.
- **Backend (API/Socket)**: Acts as the orchestrator. It manages the persistent state in MongoDB and broadcasts delta updates to the appropriate team rooms via Socket.IO.
- **Database (Persistence)**: MongoDB Atlas provides a flexible, scalable document store for tasks and teams.

---

## 🛠️ Tech Stack

| Layer | Technology | Purpose |
|-------|------------|---------|
| **Frontend** | [Flutter](https://flutter.dev) | Cross-platform UI development (iOS & Android) |
| **Backend** | [Node.js](https://nodejs.org) + [Express](https://expressjs.com) | Scalable REST API and event orchestration |
| **Database** | [MongoDB](https://www.mongodb.com) | Flexible NoSQL data persistence |
| **Real-time** | [Socket.io](https://socket.io) | Bi-directional, low-latency event synchronization |
| **State Management**| [flutter_bloc](https://pub.dev/packages/flutter_bloc) | Predictable state transitions and logic separation |
| **Networking** | [Dio](https://pub.dev/packages/dio) | Robust HTTP client for REST communication |

---

## 🔄 How the Application Works (User Flow)

1.  **Initialize Team**: Start by creating a team workspace (e.g., "Engineering") from the home dashboard.
2.  **Populate Tasks**: Add tasks to the team. Each task is immediately saved to the cloud and broadcast to anyone else viewing that team.
3.  **Manage Flow**: Drag a task from "To Do" to "In Progress". This movement is instantly synced to all team members.
4.  **Edit & Refine**: Tap a task to edit its priority or description. Updates reflect immediately across all screens.
5.  **Multi-Device Sync**: Open the app on another phone or browser; your dashboard stays in perfect harmony as you work.

---

## 🚀 Getting Started

### 1. 📥 Clone the Repository
```bash
git clone https://github.com/shaheenkolimi/task-tracker.git
cd task-tracker
```

### 2. 📡 Backend Service
1.  Navigate to directory: `cd backend`
2.  Install dependencies: `npm install`
3.  **Configure Environment**: Copy `.env.example` to `.env` and provide your `MONGO_URI`.
4.  Start server: `npm run dev`

### 📱 3. Flutter Frontend
1.  Navigate to directory: `cd frontend`
2.  Install dependencies: `flutter pub get`
3.  **Model Generation**: Run `flutter pub run build_runner build` (if using Freezed/JSON serializable).
4.  Launch application: `flutter run`

---

## 📄 Environment Configuration (`.env`)

The backend requires the following variables defined in the `/backend` directory:
```bash
PORT=8000
MONGO_URI=mongodb+srv://<user>:<password>@cluster.mongodb.net/tasktracker
```

---

## 💡 Architecture Decisions

-   **Flutter**: Chosen for its ability to deliver premium, high-performance UI across both mobile and web from a single codebase.
-   **Node.js**: Provides an event-driven architecture that is perfect for scaling real-time socket connections.
-   **MongoDB**: Its schema-less nature allows for rapid iteration of task attributes without expensive migrations.
-   **Socket.IO**: Offers a more resilient WebSocket implementation with automated room management and fallback support.

---

## 🔍 Assumptions Made

1.  **Contextual Ownership**: It is assumed that every task must belong to specific team to ensure workspace organization.
2.  **Team Scalability**: The system assumes teams can scale to dozens of tasks and multiple simultaneous active users.
3.  **Instant Truth**: The design prioritizes the server's state as the primary source of truth, with optimistic local updates for responsiveness.

---

## 🔮 Future Improvements

- [ ] **Role-Based Access (RBAC)**: Fine-grained permissions for Team Admins vs. Members.
- [ ] **Smart Notifications**: Push notifications for task assignments or deadlines.
- [ ] **File Ecosystem**: Support for attaching screenshots and documents directly to tasks.
- [ ] **Team Analytics**: Velocity charts and workload balancing insights.
- [ ] **Activity History**: A detailed audit log for every change made to a task.

---

## 👤 Author

**Shaheen Kolimi**
- **GitHub**: [@shaheenkolimi](https://github.com/shaheenkolimi)
- **LinkedIn**: [Your Profile](https://linkedin.com/in/shaheenkolimi)

---
*Created with focus and precision for the project submission.*
