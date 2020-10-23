import SwiftUI

public struct AlertErrorHandler: ErrorHandler {
    // We give our handler an ID, so that SwiftUI will be able
    // to keep track of the alerts that it creates as it updates
    // our various views:
    private let id = UUID()

    public func handle<T: View>(
        _ error: Binding<Error?>,
        in view: T,
        recoveryHandler: @escaping (RecoveryOption) -> Void,
        signOutHandler: @escaping () -> Void
    ) -> AnyView {
        guard error.wrappedValue?.resolveCategory() != .requiresSignout else {
            signOutHandler()
            return AnyView(view)
        }

        var presentation = error.wrappedValue.map {
            Presentation(
                id: id,
                error: $0,
                recoveryHandler: { recoveryOption in
                    // Seems that this needs to happen on the next run loop
                    // to give the error binding time to be set to nil,
                    // so that if recovering fails with the same error then
                    // another Alert is presented.
                    DispatchQueue.main.async {
                        recoveryHandler(recoveryOption)
                    }
                }
            )
        }

        // We need to convert our model to a Binding value in
        // order to be able to present an alert using it.
        // Because the same error may occur multiple times,
        // in order for each error to present an Alert we need
        // to set it to nil when the Alert is dismissed.
        let binding = Binding(
            get: { presentation },
            set: { possiblePresentation in
                presentation = possiblePresentation
                if possiblePresentation == nil {
                    error.wrappedValue = nil
                }
            }
        )

        return AnyView(view.alert(item: binding, content: makeAlert))
    }
}

private extension AlertErrorHandler {
    struct Presentation: Identifiable {
        let id: UUID
        let error: Error
        let recoveryHandler: (RecoveryOption) -> Void
    }

    func makeAlert(for presentation: Presentation) -> Alert {
        let error = presentation.error

        switch error.resolveCategory() {
        case let .recoverable(recoveryOption):
            return Alert(
                title: Text("An error occured"),
                message: Text(error.localizedDescription),
                primaryButton: .default(Text("Dismiss")),
                secondaryButton: .default(Text(recoveryOption.description),
                                          action: { presentation.recoveryHandler(recoveryOption) })
            )
        case .nonRecoverable:
            return Alert(
                title: Text("An error occured"),
                message: Text(error.localizedDescription),
                dismissButton: .default(Text("Dismiss"))
            )
        case .requiresSignout:
            // We don't expect this code path to be hit, since
            // we're guarding for this case above, so we'll
            // trigger an assertion failure here.
            assertionFailure("Should have logged out")
            return Alert(title: Text("Logging out..."))
        }
    }
}
