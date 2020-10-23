import SwiftUI

@main
struct ErrorHandlingExampleApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .environment(\.signOutHandler, appState.signOut)
        }
    }
}
