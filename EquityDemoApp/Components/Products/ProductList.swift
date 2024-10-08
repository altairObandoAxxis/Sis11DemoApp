//
//  ProductList.swift
//  EquityDemoApp
//
//  Created by NOEL OBANDO on 8/10/24.
//
import SwiftUI
import Sis11Framework

/// A view that displays a list of products and allows searching through them.
///
/// This view presents a list of filtered products, allowing the user to select a product for more details.
///
/// - Parameters:
///   - products: An array of products to be displayed in the list.
struct ProductListView: View {
    /// The list of products to display.
    @State var products: [Product]
    /// The view model to manage product logic.
    @StateObject var model: ProductViewModel = ProductViewModel()
    var body: some View {
        NavigationStack {
            List(model.filtered.map { ProductWrapper(product: $0) }, id: \.product.code) { wrapper in
                NavigationLink(value: wrapper) {
                    ProductItem(product: wrapper.product)
                }
            }.navigationDestination(for: ProductWrapper.self) { wrapper in
                QuotationForm(product: wrapper.product)
            }
        }.task {
            model.pro = [Product]()
            model.pro.append(contentsOf: products)
        }
        .searchable(text: $model.searchText, prompt: "Search your Products")
    }
}

/// A wrapper for the product that conforms to `Hashable`.
struct ProductWrapper: Hashable {
    let product: Product

    /// Implements the `hash(into:)` method to conform to `Hashable`.
    func hash(into hasher: inout Hasher) {
        hasher.combine(product.code)
    }
    
    /// Comparison to determine if two `ProductWrapper` instances are equal.
    static func == (lhs: ProductWrapper, rhs: ProductWrapper) -> Bool {
        lhs.product.code == rhs.product.code
    }
}

/// View model to manage product logic.
class ProductViewModel: ObservableObject {
    /// The list of products to display.
    @Published var pro: [Product] = []
    
    /// Text for searching products.
    @Published var searchText: String = ""

    /// Default initializer.
    init() {
        self.pro = [Product]()
    }

    /// Initializer that accepts a list of products.
    init(products: [Product]) {
        self.pro = products
    }

    /// Filters the list of products based on the search text.
    var filtered: [Product] {
        guard !searchText.isEmpty else { return self.pro }
        return self.pro.filter { p in
            if let productName = p.name {
                return productName.lowercased().contains(searchText.lowercased())
            }
            return p.code.lowercased().contains(searchText.lowercased())
        }
    }
}
