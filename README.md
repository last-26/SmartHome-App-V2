# Smart Home App UI

A modern and animated smart home control application UI built with Flutter. This project showcases a sleek, intuitive interface for managing smart devices, monitoring home conditions, and visualizing data with beautiful animations and charts.

## 📸 Screenshots

*(It is highly recommended to add your own screenshots here to showcase the app's beautiful UI. You can add images or GIFs.)*

| Dashboard | Device Details |
| :---: | :---: |
| `ADD_SCREENSHOT_HERE` | `ADD_SCREENSHOT_HERE` |
| **Usage Graph** | **Temperature Control** |
| `ADD_SCREENSHOT_HERE` | `ADD_SCREENSHOT_HERE` |

## ✨ Features

  - **Interactive Dashboard:** A central hub to view and control all your smart devices.
  - **Device Control:** Easily switch devices on/off with smooth toggle animations.
  - **Detailed Analytics:** Dive into detailed screens for temperature and electricity usage.
  - **Stunning Visualizations:** Animated charts and graphs to monitor your home's data in real-time.
  - **Custom Animations:** Rich, fluid animations for a delightful user experience, including fade, bounce, and rotation effects.
  - **Modern UI/UX:** A clean, visually appealing design focused on usability.

## 🛠️ Technologies & Packages Used

  - **Framework:** [Flutter](https://flutter.dev/)
  - **Language:** [Dart](https://dart.dev/)
  - **State Management:** [flutter\_bloc](https://pub.dev/packages/flutter_bloc)
  - **Routing:** [go\_router](https://pub.dev/packages/go_router)
  - **Charts:** [fl\_chart](https://pub.dev/packages/fl_chart) for beautiful and animated charts.
  - **Animations:** Custom explicit and implicit animations using Flutter's built-in animation framework.
  - **UI:** Custom Painters for unique UI elements like circular sliders.

## 🚀 Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

  - [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.0.0 or higher)
  - An editor like VS Code or Android Studio

### Installation & Running

1.  **Clone the repository:**

    ```sh
    git clone https://github.com/your-username/smarthome-app-v2.git
    cd smarthome-app-v2
    ```

2.  **Install packages:**

    ```sh
    flutter pub get
    ```

3.  **Run the app:**

    ```sh
    flutter run
    ```

## 📂 Project Structure

The project is structured with a feature-first approach to promote scalability and maintainability.

```
lib/
├── common/             # Shared colors and constants
├── features/           # Feature-based modules
│   ├── datails/        # Device details screen
│   ├── graph/          # Graph visualization screen
│   ├── home/           # Main dashboard and home screens
│   └── navigation/     # Bottom navigation bar setup
├── router/             # Navigation and routing configuration (GoRouter)
├── main.dart           # App entry point
└── ...
```

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.
