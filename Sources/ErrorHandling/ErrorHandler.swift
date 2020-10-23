import SwiftUI

public protocol ErrorHandler {
    func handle<T: View>(
        _ error: Binding<Error?>,
        in view: T,
        recoveryHandler: @escaping (RecoveryOption) -> Void,
        signOutHandler: @escaping () -> Void
    ) -> AnyView
}

public struct ErrorHandlerEnvironmentKey: EnvironmentKey {
    public static var defaultValue: ErrorHandler = AlertErrorHandler()
}

public struct SignOutHandlerEnvironmentKey: EnvironmentKey {
    public static var defaultValue: () -> Void = {}
}

public extension EnvironmentValues {
    var errorHandler: ErrorHandler {
        get { self[ErrorHandlerEnvironmentKey.self] }
        set { self[ErrorHandlerEnvironmentKey.self] = newValue }
    }

    var signOutHandler: () -> Void {
        get { self[SignOutHandlerEnvironmentKey.self] }
        set { self[SignOutHandlerEnvironmentKey.self] = newValue }
    }
}
