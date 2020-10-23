import SwiftUI

class AppState: ObservableObject {
    @Published private(set) var isSignedIn = false

    func signIn() {
        isSignedIn = true
    }

    func signOut() {
        isSignedIn = false
    }
}
