import SwiftUI

public extension View {
    func handlingErrors(
        using handler: ErrorHandler
    ) -> some View {
        environment(\.errorHandler, handler)
    }
}

public struct ErrorEmittingViewModifier: ViewModifier {
    @Environment(\.errorHandler) var errorHandler
    @Environment(\.signOutHandler) var signOutHandler

    var error: Binding<Error?>
    var recoveryHandler: (RecoveryOption) -> Void

    public func body(content: Content) -> some View {
        errorHandler.handle(error,
                            in: content,
                            recoveryHandler: recoveryHandler,
                            signOutHandler: signOutHandler)
    }
}

public extension View {
    func emittingError(
        _ error: Binding<Error?>,
        recoveryHandler: @escaping (RecoveryOption) -> Void
    ) -> some View {
        modifier(ErrorEmittingViewModifier(
            error: error,
            recoveryHandler: recoveryHandler
        ))
    }
}
