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
    @State private var checking: Bool = true
    var body: some View {
        VStack{
            if checking {
                ProgressView()
            }
            if !userLogged {
                LoginView(userLogged: $userLogged)
            }else{
                MainView(userLogged: $userLogged)
            }
        }.task {
            userLogged = !users.isEmpty && (users.first?.userToken ?? String()) != String()
            checking.toggle()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Sis11AuthData.self, inMemory: true )
}
