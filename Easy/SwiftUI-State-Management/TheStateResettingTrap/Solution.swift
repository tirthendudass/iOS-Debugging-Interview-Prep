//
//  Created by Tirthendu on 23/05/26.
//

import SwiftUI
import Observation

/*
 
 Solution:
 
 DetailView is a SwiftUI struct, and SwiftUI can recreate view structs frequently
 during state updates or view hierarchy changes.
 
 The problem is that the view model is being created like this:
 
 let viewModel = DetailViewModel()
 
 Since the view model is initialized inside the view struct, a new instance can be
 created whenever DetailView is recreated, causing the data/state to reset.
 
 Because DetailViewModel uses the @Observable macro, SwiftUI can observe its changes,
 but observation alone does not preserve the instance lifecycle.
 
 To persist the same instance across view redraws/recreations, the view model should
 be stored using:
 
 @State private var viewModel = DetailViewModel()
 
 @State keeps the same instance alive for the lifetime of the view, preventing
 unnecessary reinitialization and preserving state.
 
 */

@Observable
class DetailViewModel {
    var items: [String] = []
    
    func fetchData() {
        // Simulating network fetch
        self.items = ["SwiftUI", "Combine", "Concurrency"]
    }
}

struct DetailView: View {
    @State private var viewModel = DetailViewModel() //The solution
    
    var body: some View {
        List(viewModel.items, id: \.self) { item in
            Text(item)
        }
        .onAppear { viewModel.fetchData() }
    }
}
