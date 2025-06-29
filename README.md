# 📰 NY Times Articles App

A modern iOS application built with **Clean Swift (VIPER)** architecture that displays the most popular articles from The New York Times API.

## 🏗️ Clean Swift Architecture

This project implements **Clean Swift (VIPER)** architecture, ensuring separation of concerns and testability:

### Architecture Components

```
┌─────────────────────────────────────────────────────────────┐
│                    CLEAN SWIFT (VIPER)                     │
├─────────────────────────────────────────────────────────────┤
│  📱 View          │ SwiftUI Views & ViewControllers        │
│  🎯 Interactor    │ Business Logic & Use Cases             │
│  👨‍💼 Presenter     │ Presentation Logic & Formatting       │
│  🧭 Router        │ Navigation & Scene Transitions         │
│  ⚙️ Configurator   │ Dependency Injection & Setup          │
│  👷 Worker        │ Data Operations & Network Calls        │
└─────────────────────────────────────────────────────────────┘
```

## 📁 Project Structure

```
ArticlesApp/
├── ArticlesApp/
│   ├── Scenes/
│   │   └── Articles/
│   │       ├── ArticlesView.swift
│   │       ├── ArticlesInteractor.swift
│   │       ├── ArticlesPresenter.swift
│   │       ├── ArticlesRouter.swift
│   │       ├── ArticlesWorker.swift
│   │       ├── ArticlesModels.swift
│   │       └── ArticlesModule.swift
│   ├── Networking/
│   │   ├── NetworkClient.swift
│   │   ├── NetworkRequest.swift
│   │   ├── NetworkErrors.swift
│   │   └── Endpoints/
│   │       └── ArticlesEndPointsProvider.swift
│   ├── Models/
│   │   └── ArticalesResponseModel.swift
│   ├── Common/
│   │   ├── Views/
│   │   └── Configuration/
│   └── Resources/
├── ArticlesAppTests/
│   ├── ArticlesInteractorTests.swift
│   ├── ArticlesPresenterTests.swift
│   ├── NetworkClientTests.swift
│   └── Mocks/
│       ├── MockNetworkClient.swift
│       └── TestHelpers.swift
├── fastlane/
│   ├── Fastfile
│   └── Appfile
├── Gemfile
└── README.md
```

## 🚀 Getting Started

### Prerequisites

- Xcode 15.0+
- iOS 15.0+
- Swift 5.9+
- Ruby 3.0+
- NY Times API Key

### Installation

1. Clone the repository
   ```bash
   git clone https://github.com/your-username/ArticlesApp.git
   cd ArticlesApp
   ```

2. Install dependencies
   ```bash
   bundle install
   brew install swiftlint
   ```

3. Configure API Key
   
   Add your NY Times API key to `Info.plist`:
   ```xml
   <key>API_KEY</key>
   <string>YOUR_NY_TIMES_API_KEY_HERE</string>
   <key>BASE_URL</key>
   <string>https://api.nytimes.com/</string>
   ```

4. Build and run
   ```bash
   # Using Xcode
   open ArticlesApp.xcodeproj
   
   # Using Fastlane
   bundle exec fastlane ios build_debug
   ```

## 🏃‍♂️ Running the App

### Using Xcode
1. Open `ArticlesApp.xcodeproj`
2. Select your target device/simulator
3. Press `Cmd + R` to build and run

### Using Command Line
```bash
# Build debug version
bundle exec fastlane ios build_debug

# Build release version
bundle exec fastlane ios build_release

# Run complete pipeline
bundle exec fastlane ios build_and_test
```

## 🧪 Testing

### Running Tests

```bash
# Using Xcode
# Press Cmd + U to run all tests

# Using Fastlane
bundle exec fastlane ios test

# Using command line
xcodebuild test -project ArticlesApp.xcodeproj -scheme ArticlesApp -destination 'platform=iOS Simulator,name=iPhone 16 Pro'
```

### Test Coverage

The project includes comprehensive unit tests covering:

- Business Logic: Interactor tests for data fetching and processing
- Presentation Logic: Presenter tests for data formatting
- View State: ViewModel tests for UI state management
- Network Layer: Network client and error handling tests

```bash
# Generate test coverage report
bundle exec fastlane ios test
open coverage/index.html
```

## 🔧 Build Automation

### Available Fastlane Lanes

```bash
# Development
bundle exec fastlane ios build_debug      # Build debug version
bundle exec fastlane ios test            # Run unit tests
bundle exec fastlane ios build_and_test  # Complete pipeline

# Production
bundle exec fastlane ios build_release   # Build release version

# Utilities
bundle exec fastlane ios clean           # Clean project
```

## 🌐 API Integration

### NY Times Most Popular API

- Endpoint: `https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json`
- Authentication: API Key required
- Response Format: JSON with articles array

### Network Architecture

```swift
NetworkClient (Protocol) 
    ↓
ArticlesWorker (Data fetching)
    ↓
ArticlesInteractor (Business logic)
    ↓
ArticlesPresenter (Data formatting)
    ↓
ArticlesView (UI presentation)
```


## 🔍 Clean Swift Flow

User action flow through Clean Swift architecture:

1. User taps "Refresh" in ArticlesView
2. ArticlesView calls viewModel.refreshArticles()
3. ArticlesViewModel calls presenter.refreshArticles()
4. ArticlesPresenter calls interactor.fetchArticles()
5. ArticlesInteractor calls worker.fetchArticles()
6. ArticlesWorker makes network request via NetworkClient
7. Response flows back: Worker → Interactor → Presenter → ViewModel → View
8. ArticlesView updates UI with new data

## 🐛 Troubleshooting

### Common Issues

**Build Errors**
```bash
bundle exec fastlane ios clean
bundle exec fastlane ios build_debug
```

**Test Failures**
```bash
xcodebuild test -project ArticlesApp.xcodeproj -scheme ArticlesApp -only-testing:ArticlesAppTests/ArticlesInteractorTests/testFetchArticles_Success
```

**API Key Issues**
```bash
grep -A 1 "API_KEY" ArticlesApp/Info.plist
```

