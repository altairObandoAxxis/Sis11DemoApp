//
//  PolicyItem.swift
//  EquityDemoApp
//
//  Created by NOEL OBANDO on 19/9/24.
//

/// PolicyItem.swift
import SwiftUI
import Sis11Framework

struct PolicyItem: View {
    @ObservedObject var lifePolicy: LifePolicy;
    var body: some View {
        HStack{
            Image(systemName: "checkmark.shield")
                .foregroundStyle(Color.red)
                .font(.system(size: 24))
            VStack(alignment: .leading){
                Text(lifePolicy.code ?? "Policy Code").fontWeight(.semibold)
                Text("Insured Sum: \( lifePolicy.insuredSum.formatted()  )").fontWeight(.thin)
                Text("Annual Total: \(lifePolicy.annualTotal.formatted() )").fontWeight(.thin)
            }.padding()
            Spacer()
        }.padding()
    }
}

#Preview {
    PolicyItem(lifePolicy: LifePolicy(id: 15, lob: String(), active: false, insuredSum: 1500000, annualTotal: 23568, holderId: 253, payerId: 253))
}
