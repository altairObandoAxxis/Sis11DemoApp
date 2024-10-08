//
//  ProductView.swift
//  EquityDemoApp
//
//  Created by NOEL OBANDO on 7/10/24.
//
import SwiftUI
import Sis11Framework

// A view that displays a list of products.
struct ProductView: View {
    // State variable to hold the list of products.
    @State private var products: [Product] = [Product]()
    // State variable to indicate whether products are being fetched.
    @State private var fetching = false

    var body: some View {
        VStack {
            // Show a loading indicator if fetching products.
            if fetching {
                Text("Getting SelfService Products") // Display a message while fetching.
                ProgressView() // Show a progress view.
            } else {
                // Show the list of products when not fetching.
                ProductListView(products: products)
            }
        }
        .task {
            // Start fetching products when the view appears.
            Task {
                await getProducts()
            }
        }
    }

    // Asynchronous function to fetch products.
    func getProducts() async {
        let SDK = Sis11SDK.shared // Access the shared SDK instance.
        fetching.toggle() // Start fetching by toggling the fetching state.
        
        do {
            // Fetch products from the portal, filtering for those containing "SelfService".
            let response = try await SDK.portal.GetPortalProducts()
                .filter { item in return item.configJson.contains("SelfService") }
            // Clear the existing products and append the fetched products.
            products = [Product]()
            products.append(contentsOf: response)
        } catch {
            // Print any error encountered during the fetching process.
            print(error.localizedDescription)
        }
        
        fetching.toggle() // Toggle fetching state to indicate completion.
    }
}

