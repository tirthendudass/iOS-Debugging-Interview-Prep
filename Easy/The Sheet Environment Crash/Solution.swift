//
//  Created by Tirthendu on 23/05/26.
//

import SwiftUI
import Observation

/*
 
 The Solution:

 This is a classic runtime crash caused by a dependency injection issue in SwiftUI.

 SettingsView expects a SessionManager instance through @EnvironmentObject,
 but no SessionManager has been injected into the current view hierarchy.

 Because of this, the app crashes at runtime with:
 "No ObservableObject of type SessionManager found."

 The fix is to inject the required environment object before presenting the view.

 Solution:

 .sheet(isPresented: $isShowingSettings) {
     SettingsView()
         .environmentObject(sessionManager)
 }

 Note:
 If SessionManager is already injected at a higher level
 (for example in App or RootView),
 then this additional injection is not required.
 
 */

struct DashboardView: View {
    @EnvironmentObject var sessionManager: SessionManager
    @State private var isShowingSettings = false
    
    var body: some View {
        Button("Open Settings") {
            isShowingSettings = true
        }
        .sheet(isPresented: $isShowingSettings) {
            SettingsView()
                .environmentObject(sessionManager) // The Solution
        }
    }
}

struct SettingsView: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        Text("User: \(sessionManager.username)")
    }
}
