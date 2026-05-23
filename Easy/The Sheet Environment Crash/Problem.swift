//
//  Created by Tirthendu on 23/05/26.
//

import SwiftUI
import Observation

/*
The problem: The Sheet Environment Crash

The Setup:
An app uses a central @EnvironmentObject (or the newer @Environment with custom keys) to manage user session state. A deeply nested view presents a modal sheet.
  
The Bug:
The app builds perfectly. However, the moment the user taps "Open Settings," the app crashes instantly with: Fatal error: No ObservableObject of type SessionManager found in the view hierarchy.
 
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
        }
    }
}

struct SettingsView: View {
    @EnvironmentObject var sessionManager: SessionManager // <--- Crashes here
    
    var body: some View {
        Text("User: \(sessionManager.username)")
    }
}
