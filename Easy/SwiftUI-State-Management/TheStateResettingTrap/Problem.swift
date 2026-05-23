//
//  Created by Tirthendu on 23/05/26.
//

import SwiftUI
import Observation

/*
 
Problem: The "Resetting State" Trap (Macro vs. Lifecycle)
 
 The Setup
 The candidate is given a parent view that holds a list of items and a details view. The detail view uses the modern iOS @Observable macro for its View Model.
 
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
    let viewModel = DetailViewModel()
    
    var body: some View {
        List(viewModel.items, id: \.self) { item in
            Text(item)
        }
        .onAppear { viewModel.fetchData() }
    }
}
