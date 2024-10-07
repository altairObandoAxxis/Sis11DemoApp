//
//  LoginView.swift
//  EquityDemoApp
//
//  Created by NOEL OBANDO on 18/9/24.
//

import SwiftUI;
import Sis11Framework;
struct LoginView: View {
    @Environment(\.modelContext) private var modelContext;
    /// User Name
    @State var email: String = "equityuat\\noel.obando@axxis-systems.com";
    /// User Password
    @State var pass : String = "Axxis2024!!!";
    /// Reference for loading state
    @State var loading: Bool = false;
    /// Show Error message
    @State var showMsg : Bool = false;
    /// Error Message
    @State var errorMsg: String = String();
    /// Update Content View Reference
    @Binding var userLogged: Bool;
    var body: some View {
        VStack{
            Image(systemName: "person.badge.shield.checkmark.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.blue)
            TextField("User Name", text: $email)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $pass)
                .textFieldStyle(.roundedBorder)
            Button {
                doLogin()
            }
            label: {
                VStack{
                    if(loading) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }else{
                        Text("Sign In")
                    }
                }.frame(maxWidth: .infinity, maxHeight:40)
            }.buttonStyle(.borderedProminent)
                .padding(.top)
        }
        .padding()
        .alert("Sign In Error", isPresented: $showMsg){
            Button("Ok"){}
        } message: {
            Text(errorMsg)
        }
    }
    func doLogin(){
        // Get the instance.
      let sis11Sdk = Sis11SDK.shared;
      // Make api request.
      Task {
          do{
              let userData: Credentials = Credentials(email: email, clave: pass)
              let userResponse = try await sis11Sdk.doAuth(credentials: userData );
              // Save the user information
              let newAuthData = Sis11AuthData(userName: userResponse.nombre, userEmail: userResponse.email, userToken: userResponse.token );
              modelContext.insert(newAuthData)
              userLogged.toggle();
          }catch{
              errorMsg = error.localizedDescription;
              showMsg.toggle()
          }
        }
    }
}

#Preview {
    LoginView(userLogged: .constant(false))
}
