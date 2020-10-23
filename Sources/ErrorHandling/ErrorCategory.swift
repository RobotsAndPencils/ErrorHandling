import Foundation

public enum ErrorCategory: Equatable {
    case nonRecoverable
    case recoverable(recoveryOption: RecoveryOption)
    case requiresSignout
}

public protocol CategorizedError: Error {
    var category: ErrorCategory { get }
}

public extension Error {
    func resolveCategory() -> ErrorCategory {
        guard let categorized = self as? CategorizedError else {
            // We could optionally choose to trigger an assertion
            // here, if we consider it important that all of our
            // errors have categories assigned to them.
            return .nonRecoverable
        }

        return categorized.category
    }
}
