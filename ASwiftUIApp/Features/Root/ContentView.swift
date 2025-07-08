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
            
        TabView {
            @Bindable var router = router
            NavigationStack(path: $router.navigationPath) {
                HomeScreen(router: router)
                    .navigationDestination(for: Destination.self) {
                        dest in
                        RouterView(router: router, destination: dest)
                    }
            }
            .tabItem {
                Label("Chats", systemImage: "star")
            }
                
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }

    }
}

#Preview() {
    ContentView()
        .environment(DataModel())
        .environment(Router())
}

