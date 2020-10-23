import ErrorHandling
import SwiftUI

struct RandomNumberView: View {
    @State private var number: Int?
    @State private var error: Swift.Error?

    var body: some View {
        VStack {
            if let number = number {
                Text("Random number: \(number)")
                    .padding()
            }

            Button(action: generateRandomNumber) {
                Label("Generate", systemImage: "shuffle")
            }
        }
        .emittingError($error, recoveryHandler: { recoveryOption in
            if recoveryOption == .retry {
                generateRandomNumber()
            }
        })
    }

    private func generateRandomNumber() {
        switch Int.random(in: 0...2) {
        case 0:
            error = nil
            number = Int.random(in: 0..<1000)
        case 1:
            error = Error.numberGenerationFailed
        case 2:
            error = Error.sessionExpired
        default:
            assertionFailure("Should only generate 0-2")
        }
    }

    private enum Error: LocalizedError, CategorizedError {
        case numberGenerationFailed
        case sessionExpired

        var errorDescription: String? {
            switch self {
            case .numberGenerationFailed:
                return "Random number generation failed"
            case .sessionExpired:
                return "Your session has expired"
            }
        }

        var category: ErrorCategory {
            switch self {
            case .numberGenerationFailed:
                return .recoverable(recoveryOption: .retry)
            case .sessionExpired:
                return .requiresSignout
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RandomNumberView()
    }
}
