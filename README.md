# ErrorHandling

An easy way to thoroughly handle errors in SwiftUI, with support for retry/recovery and sign out.

By defaults errors are presented with alerts, and this can be customized by setting `.environment(\.errorHandler, newErrorHandler)`.

Errors can also be categorized into recoverable, non-recoverable and requiring signout. 
The alert error handler will provide a button to attempt to recover recoverable errors.
Errors requiring signout will automatically invoke the `\.signOutHandler` environment value. 
This should be set in the root view of your app.

## Installation

Support CocoaPods and Swift Package Manager.

## Usage

Use the `emittingError(_:recoveryHandler:)` modifier from a view that should present an error:

```swift
@State private var error: Error?

var body: some View {
    // ...
    .emittingError($error, recoveryHandler: { recoveryOption in
        switch recoveryOption {
        case .resubmit:
            submit()
        case .resave:
            save()
        default:
            break
        }
    })
}
```

Define RecoveryOptions that you'd like users to be able to perform.

```swift
public extension RecoveryOption {
    static let resubmit = RecoveryOption(id: "com.robotsandpencils.Tailboard.Resubmit", description: "Resubmit")
}

```

Add a CategorizedError conformance to your Error types.
This is recommended especially for authentication errors so your users will be automatically signed out when appropriate.
You can also return an appropriate RecoveryOption here.

```swift
extension ResponseCodeError: CategorizedError {
    public var category: ErrorCategory {
        switch self {
        case let .invalidResponseCode(possibleResponse, _) where possibleResponse?.statusCode == 401:
            return .requiresSignout
        default:
            return .nonRecoverable
        }
    }
}

extension AppStateError: CategorizedError {
    var category: ErrorCategory {
        switch self {
        case let .submitDraft(error):
            if error.resolveCategory() == .requiresSignout {
                return .requiresSignout
            } else {
                return .recoverable(recoveryOption: .resubmit)
            }
        default:
            return .nonRecoverable
        }
    }
}
```

Set a signOutHandler environment value on your root views. 
This can be any `() -> Void` function.

```swift
window.rootViewController = UIHostingController(
    rootView: RootView()
        .environment(\.signOutHandler, appState.signOut)
)
```

## Reference

- https://www.swiftbysundell.com/articles/propagating-user-facing-errors-in-swift/
- https://nshipster.com/swift-foundation-error-protocols/
