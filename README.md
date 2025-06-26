# 📰 Articles - iOS App (SwiftUI + Clean Architecture)

A modern iOS application built with **SwiftUI** that displays the most popular articles from **The New York Times**.  
This app demonstrates **Clean Architecture**, **MVVM design pattern**, and modern iOS development.


## 🧱 Architecture Overview

├── UI Layer
│ ├── SwiftUI Views
│ └── ViewModels (MVVM)
│
├── Business Layer
│ └── Use Cases (Business Logic)
│
└── Data Layer
├── Repositories (Protocol)
└── Data Sources
├── Remote
└── Local

## 🚀 Features

- Fetches and displays the most popular NYT articles
- Uses modern SwiftUI with reactive Combine pipelines
- Implements clear separation of concerns using Clean Architecture
- Unit tested with XCTest
- Safe and configurable environment via `plist`


