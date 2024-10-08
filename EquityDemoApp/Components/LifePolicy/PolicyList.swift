//
//  PolicyList.swift
//  EquityDemoApp
//
//  Created by NOEL OBANDO on 19/9/24.
//

import SwiftUI
import Sis11Framework;
struct PolicyList: View {
    @State var userPolicies: [LifePolicy];
    @StateObject var model: PolicyViewModel = PolicyViewModel();
    var body: some View {
        NavigationView{
            List(model.filteredPolicies, id: \.id ){ lifePolicy in
                NavigationLink(destination: Text("Policy Selected: \(lifePolicy.code ?? lifePolicy.id.description )")){
                    PolicyItem(lifePolicy: lifePolicy)
                }
            }
        }.onAppear {
            model.policies = [LifePolicy]();
            model.policies.append(contentsOf: userPolicies);
        }.searchable(text: $model.searchText, prompt: "Search by policy code" )
    }
}

#Preview {
    PolicyList( userPolicies: [LifePolicy]())
}

class PolicyViewModel: ObservableObject{
    @Published var policies: [LifePolicy] = [LifePolicy]();
    @Published var searchText: String = String();
    init(){
        self.policies = [LifePolicy]();
    }
    init(policies: [LifePolicy]){
        self.policies = policies;
    }
    var filteredPolicies: [LifePolicy]{
        guard !searchText.isEmpty else { return self.policies }
        return self.policies.filter{ policy in
            let match = (policy.code?.lowercased().contains(searchText.lowercased()));
            return match != nil && match.unsafelyUnwrapped
        }
    }
}
