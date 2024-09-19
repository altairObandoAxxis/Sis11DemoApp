//
//  AuthModel.swift
//  EquityDemoApp
//
//  Created by NOEL OBANDO on 18/9/24.
//

import Foundation
import SwiftData

@Model
final class Sis11AuthData{
    var userName : String;
    var userEmail : String;
    var userToken : String;
    
    init(userName: String, userEmail: String, userToken: String) {
        self.userName = userName
        self.userEmail = userEmail
        self.userToken = userToken
    }
}
