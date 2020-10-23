import Foundation

/// A recovery option to present to the user when a recoverable error occurs
public struct RecoveryOption: Identifiable, Equatable, CustomStringConvertible {
    public let id: String
    public let description: String

    public init(id: String, description: String) {
        self.id = id
        self.description = description
    }
}

public extension RecoveryOption {
    static let retry = RecoveryOption(id: "com.robotsandpencils.ErrorHandling.retry", description: "Retry")
}
