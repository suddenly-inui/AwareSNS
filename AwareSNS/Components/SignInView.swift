//
//  SignInView.swift
//  AwareSNS
//
//  Created by Yuki Inui on 2023/10/03.
//

import SwiftUI

struct SignInView: View {
    @State private var user_id: String = ""
    @State private var user_name: String = ""
    @State private var password: String = ""
    
    @State var buttonDisabled: Bool = true
    @State var showAlert: Bool = false
    @State var error_text: String = ""
    
    @Binding var active: Bool
    
    let defaults = UserDefaults.standard
    let apiService = APIService()
    
    var body: some View {
        VStack {
            Text("会員登録")
                .font(.title)
            
            TextField("IDを入力してください", text: $user_id)
                .autocapitalization(.none)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .onChange(of: user_id){
                    check_input()
                }
            Divider()
            
            TextField("ユーザーネームを入力してください", text: $user_name)
                .autocapitalization(.none)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .onChange(of: user_name){
                    check_input()
                }
            Divider()
            
            SecureField("パスワードを入力してください", text: $password)
                .autocapitalization(.none)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .onChange(of: password){
                    check_input()
                }
            Divider()
            
            if showAlert {
                Text(error_text)
            }
            
            Button(action: {
                if user_id.count > 30 || user_name.count > 30{
                    error_text = "ID,ユーザーネームは30文字以内で入力してください"
                    showAlert = true
                } else {
                    signIn(id: user_id, username: user_name)
                }
            }) {
                Text("登録")
                    .padding()
                    .background(buttonDisabled ? .gray :.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(buttonDisabled)
        }
        .padding()
    }
    
    func signIn(id: String, username: String){
        apiService.SignIn(user_id: user_id, user_name: user_name, password: password) { result in
            switch result {
            case .success(let data):
                print("registerUser: \(data)")
                if data.success {
                    defaults.set(user_id, forKey: "user_id")
                    active = false
                } else {
                    error_text = "不明な原因により会員登録できませんでした"
                    showAlert = true
                    user_id = ""
                    user_name = ""
                    password = ""
                }
            case .failure(let error):
                print("registerUser: \(error)")
            }
        }
    }
    
    func check_input(){
        if user_name.isEmpty || password.isEmpty || user_id.isEmpty {
            buttonDisabled = true
            showAlert = false
            error_text = ""
            
        } else {
            if (user_name.count < 5 || user_name.count > 30) {
                buttonDisabled = true
                showAlert = true
                error_text = "ユーザーネームは5文字以上30文字以内で入力してください"
                
            } else if containsNonAlphanumericCharacters(user_id){
                buttonDisabled = true
                showAlert = true
                error_text = "IDは英数字のみで入力してください"
                
            } else if user_id.count < 5 || user_id.count > 30{
                buttonDisabled = true
                showAlert = true
                error_text = "IDは5文字以上30文字以内で入力してください"
                
            } else if password.count < 5 || password.count > 30{
                buttonDisabled = true
                showAlert = true
                error_text = "パスワードは5文字以上30文字以内で入力してください"
                
            } else {
                showAlert = true
                error_text = ""
                buttonDisabled = false
            }
        }
    }
    
    func containsNonAlphanumericCharacters(_ input: String) -> Bool {
        let alphanumeric = CharacterSet.alphanumerics
        return input.unicodeScalars.contains { !alphanumeric.contains($0) }
    }
}

