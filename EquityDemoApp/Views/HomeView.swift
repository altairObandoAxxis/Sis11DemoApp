//
//  HomeView.swift
//  EquityDemoApp
//
//  Created by NOEL OBANDO on 19/9/24.
//

import SwiftUI;
import Sis11Framework;

struct HomeView: View {
    @State private var contactData : Sis11Framework.ContactDataOutData? = nil;
    @State private var fetching = false
    var body: some View {
        VStack{
            if fetching {
                ProgressView()
            }else{
                TabView{
                    PolicyList(userPolicies: contactData?.PoliciesAsHolder ?? [LifePolicy]())
                        .tabItem{
                            Label("Home", systemImage: "heart")
                        }
                    Text("Quote A Product").tabItem{
                        Label("Quote", systemImage: "list.bullet.below.rectangle")
                    }
                    Text("User Claims").tabItem{
                        Label("Claims", systemImage: "cross.case")
                    }
                    Text("Profile data").tabItem{
                        Label("Profile", systemImage: "person.circle.fill")
                    }
                }
            }
        }.task {
            fetching.toggle()
            let sdk = Sis11SDK.shared;
            do{
                let response = try await sdk.contact.GetContactData();
                contactData = response;
            }catch{
                print(error)
            }
            fetching.toggle()
        }
    }
}

#Preview {
    HomeView()
}
