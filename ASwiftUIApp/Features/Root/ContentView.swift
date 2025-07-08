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
        TabView(selection: $router.selectedTab) {
            Tab(
                Tabs.chats.name,
                systemImage: Tabs.chats.systemImageName,
                value: Tabs.chats
            ) {
                NavigationStack(path: $router.chatTabPath) {
                    ChatFeatureRootView(router: router)
                        .navigationDestination(for: Destination.self) {
                            dest in
                            RouterView(router: router, destination: dest)
                        }
                }
            }
            
            Tab(
                Tabs.settings.name,
                systemImage: Tabs.settings.systemImageName,
                value: Tabs.settings
            ) {
                NavigationStack(path: $router.settingsTabPath) {
                    SettingsHomeView(router: router)
                        .navigationDestination(for: Destination.self) {
                            dest in
                            RouterView(router: router, destination: dest)
                        }
                }
            }
        }

    }
}

#Preview() {
    ContentView()
        .environment(DataModel())
        .environment(Router())
}

