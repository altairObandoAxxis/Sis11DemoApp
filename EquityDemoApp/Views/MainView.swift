//
//  MainView.swift
//  EquityDemoApp
//
//  Created by NOEL OBANDO on 18/9/24.
//

import SwiftUI;
import SwiftData;
import Sis11Framework;

struct MainView: View {
    @Query private var users: [Sis11AuthData];
    @State private var checkingData: Bool = true;
    @State private var userName: String = String();
    /// Update Content View Reference
    @Binding var userLogged: Bool;
    var body: some View {
        VStack{
            if(checkingData){
                ProgressView()
            }else{
                HomeView()
            }
        }.task {
            let sdk = Sis11SDK.shared;
            if let currentUser = users.first {
                // Configure sis11Token
                if sdk.token.isEmpty {
                    sdk.token = currentUser.userToken;
                }
                userName = currentUser.userName;
            }
            Task{
                do{
                    // Make a connection test.
                    let command = Sis11Command<GetPingDTO>();
                    let pong = try await command.DoCmd(cmd: "GetPing", data: [:]);
                    print(pong.ok)
                    checkingData.toggle()
                }catch{
                    userLogged.toggle()
                }
            }
        }
    }
}

#Preview {
    MainView(userLogged: .constant(true))
}
