A modern iOS application built with SwiftUI that displays the most popular articles from The New York Times. The app demonstrates clean architecture principles, MVVM design pattern, and modern iOS development best practices.
┌─────────────────────────────────────────┐
│                UI Layer                 │
│  ┌─────────────┐  ┌─────────────────┐   │
│  │   SwiftUI   │  │   ViewModels    │   │
│  │    Views    │  │     (MVVM)      │   │
│  └─────────────┘  └─────────────────┘   │
└─────────────────────────────────────────┘
                    │
┌─────────────────────────────────────────┐
│            Business Layer               │
│  ┌─────────────────────────────────────┐ │
│  │           Use Cases                 │ │
│  │      (Business Logic)              │ │
│  └─────────────────────────────────────┘ │
└─────────────────────────────────────────┘
                    │
┌─────────────────────────────────────────┐
│              Data Layer                 │
│  ┌─────────────┐  ┌─────────────────┐   │
│  │ Repositories│  │   Data Sources  │   │
│  │  (Protocol) │  │ Remote │ Local  │   │
│  └─────────────┘  └─────────────────┘   │
└─────────────────────────────────────────┘


🛠️ Tech Stack
UI Framework: SwiftUI
Architecture: Clean Architecture + MVVM
Reactive Programming: Combine
Networking: URLSession with custom NetworkClient
Dependency Injection: Constructor injection
Testing: XCTest + Swift Testing
Configuration: Secure plist-based configuration




