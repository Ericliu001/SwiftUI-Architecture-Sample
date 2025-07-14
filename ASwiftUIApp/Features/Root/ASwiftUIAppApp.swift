/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The main app structure.
*/

import SwiftUI

@main
struct ASwiftUIApp: App {
    let rootScope = RootScope()

    var body: some Scene {
        WindowGroup {
            ContentView(scope: rootScope)
            // Set minimum window size.
            #if os(macOS) || os(visionOS)
                .frame(minWidth: Constants.contentWindowWidth, maxWidth: .infinity, minHeight: Constants.contentWindowHeight, maxHeight: .infinity)
            #endif
        }
        .windowResizability(.contentSize)
    }
}
