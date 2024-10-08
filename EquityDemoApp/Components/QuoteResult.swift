//
//  QuoteResult.swift
//  EquityDemoApp
//
//  Created by NOEL OBANDO on 8/10/24.
//

import SwiftUI
import Sis11Framework

// A view that displays the result of a quote with a list of new policies.
struct QuoteResult: View {
    // Array to hold the new policies received from the quote.
    var newPolicies: [LifePolicy] = [LifePolicy]()
    var body: some View {
        VStack {
            // List to display each policy.
            List(newPolicies, id: \.quoteId) { policy in
                // Navigation link to show details of the selected policy.
                NavigationLink(destination: Text("New Policy Code: \(policy.code ?? String())")) {
                    // Custom view to display the policy item.
                    QuoteItem(policy: policy)
                }
            }
            .navigationTitle("Options") // Set the title for the navigation bar.
            .scrollContentBackground(.hidden) // Hide the background of the scrollable content.
        }
    }
}
