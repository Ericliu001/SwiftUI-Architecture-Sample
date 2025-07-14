/*
 See the LICENSE.txt file for this sample’s licensing information.

 Abstract:
 The top level tab navigation for the app.
 */

import SwiftUI

struct ContentView: View {
    private let scope: RootScope
    
    init(scope: RootScope) {
        self.scope = scope
    }
    
    var body: some View {
        @Bindable var router = scope.rootRouter
        TabView(selection: $router.selectedTab) {
            Tab(
                Tabs.chats.name,
                systemImage: Tabs.chats.systemImageName,
                value: Tabs.chats
            ) {
                NavigationStack(path: $router.chatTabPath) {
                    scope.chatScope.chatFeatureRootview()
                        .navigationDestination(for: Destination.self) {
                            dest in
                            scope.routerView(dest: dest)
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
                            scope.routerView(dest: dest)
                        }
                }
            }
        }

    }
}

#Preview() {
    ContentView(scope: RootScope.mock)
}

