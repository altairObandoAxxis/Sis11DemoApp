//
//  ContentView.swift
//  EquityDemoApp
//
//  Created by NOEL OBANDO on 18/9/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var users: [Sis11AuthData];
    @State private var userLogged: Bool = false;
    var body: some View {
        VStack{
            if !userLogged {
                LoginView(userLogged: $userLogged)
            }else{
                MainView(userLogged: $userLogged)
            }
        }.task {
            userLogged = !users.isEmpty && (users.first?.userToken ?? String()) != String()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Sis11AuthData.self, inMemory: true )
}
