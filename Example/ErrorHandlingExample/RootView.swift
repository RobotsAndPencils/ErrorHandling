//
//  RootView.swift
//  ErrorHandlingExample
//
//  Created by Brandon Evans on 2020-10-23.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        if appState.isSignedIn {
            RandomNumberView()
        } else {
            VStack {
                Button("Sign In", action: appState.signIn)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
