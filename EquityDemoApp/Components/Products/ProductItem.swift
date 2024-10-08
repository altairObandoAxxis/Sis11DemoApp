//
//  ProductItem.swift
//  EquityDemoApp
//
//  Created by NOEL OBANDO on 8/10/24.
//

import SwiftUI
import Sis11Framework

struct ProductItem: View {
    @State var product: Product;
    var body: some View {
        HStack{
            Image(systemName: "checkmark.shield")
                .foregroundStyle(Color.red)
                .font(.system(size: 24))
            VStack(alignment: .leading){
                Text(product.code).font(
                    Font.custom("Open Sans", size: 16)
                        .weight(.semibold)
                )
                .foregroundColor(Color(red: 0.13, green: 0.12, blue: 0.12))
                .frame(width: 207, alignment: .topLeading)
                Text(product.name ?? String()) .font(Font.custom("Open Sans", size: 14))
                    .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.47))
                    .frame(width: 207, alignment: .topLeading)
            }.padding()
            Spacer()
        }.padding()
    }
}

#Preview {
    ProductItem(product: Product(code: "EDU", configJson: String(), lobCode: "", name: "Education Insurance"))
}
