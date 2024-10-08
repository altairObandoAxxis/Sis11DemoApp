//
//  QuoteItem.swift
//  EquityDemoApp
//
//  Created by NOEL OBANDO on 8/10/24.
//

import SwiftUI;
import Sis11Framework;

struct QuoteItem: View {
    @State var policy: LifePolicy
    var body: some View {
        HStack(){
            Image(systemName: "checkmark.shield")
                .foregroundColor(.accentColor)
                .font(.system(size: 24))
            VStack(alignment: .leading){
                Text("Option \(policy.code ?? String() )").fontWeight(.semibold)
                HStack(){
                    Text(policy.lob)
                    Text(policy.productCode ?? String())
                }
                HStack(){
                    Text("Sum Insured")
                    Text(policy.insuredSum.formatted())
                    Text("\(policy.currency ?? String())")
                }
                HStack(){
                    Text("Premium")
                    Text(policy.annualTotal.formatted())
                    Text("\(policy.currency ?? String())")
                }
            }
        }
    }
}
