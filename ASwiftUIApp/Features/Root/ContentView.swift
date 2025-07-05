/*
 See the LICENSE.txt file for this sample’s licensing information.

 Abstract:
 The top level tab navigation for the app.
 */

import SwiftUI

struct ContentView: View {
    // In prduction, the Router instance should be provided by dependency injection.
    @Environment(Router.self) var router
    
    var body: some View {
        @Bindable var router = router
        NavigationStack(path: $router.navigationPath) {
            HomeScreen()
                .navigationDestination(for: Destination.self) {
                    dest in
                    RouterView(destination: dest)
                }
        }
    }
}

#Preview() {
    ContentView()
        .environment(DataModel())
}

