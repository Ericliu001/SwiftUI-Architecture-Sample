/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The main app structure.
*/

import SwiftUI

@main
struct ASwiftUIApp: App {
    @State private var dataModel = DataModel()
    
    // In prduction, Router instance should be provided by dependency injection.
    @State private var router = Router()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataModel)
                .environment(router)
            // Set minimum window size.
            #if os(macOS) || os(visionOS)
                .frame(minWidth: Constants.contentWindowWidth, maxWidth: .infinity, minHeight: Constants.contentWindowHeight, maxHeight: .infinity)
            #endif
        }
        .windowResizability(.contentSize)
    }
}
