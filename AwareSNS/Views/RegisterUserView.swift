//
//  UserRegisterView.swift
//  AwareSNS
//
//  Created by Yuki Inui on 2023/10/03.
//

import SwiftUI

struct RegisterUserView: View {
    @Binding var active: Bool
    @State var logInPage: Bool = true
    
    var body: some View {
        if logInPage {
            LogInView(active: $active)
        } else {
            SignInView(active: $active)
        }
                
        Button(action: {
            logInPage.toggle()
        }){
            Text(logInPage ? "会員登録" : "ログイン")
        }
    }
}
