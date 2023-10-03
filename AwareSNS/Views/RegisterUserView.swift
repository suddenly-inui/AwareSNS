//
//  UserRegisterView.swift
//  AwareSNS
//
//  Created by Yuki Inui on 2023/10/03.
//

import SwiftUI

struct RegisterUserView: View {
    @State private var user_id: String = ""
    @State private var user_name: String = ""
    @Binding var active: Bool
    @State var showAlert: Bool = false
    @State var error_text: String = ""
    
    let defaults = UserDefaults.standard
    let apiService = APIService()
    
    var body: some View {
        VStack {
            TextField("IDを入力してください", text: $user_id)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
            
            TextField("ユーザーネームを入力してください", text: $user_name)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
            
            Button(action: {
                if containsNonAlphanumericCharacters(user_id) {
                    error_text = "IDは英数字で入力してください\n\(user_id)"
                    showAlert = true
                } else if user_id.isEmpty{
                    error_text = "IDを入力してください"
                    showAlert = true
                }else if user_name.isEmpty{
                    error_text = "ユーザーネームを入力してください"
                    showAlert = true
                } else if user_id.count > 30 || user_name.count > 30{
                    error_text = "ID,ユーザーネームは30文字いないで入力してください"
                    showAlert = true
                } else {
                    registerUser(user_id: user_id, user_name: user_name)
                }
            }) {
                Text("送信")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("エラー"),
                    message: Text(error_text),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .padding()
    }
    
    func registerUser(user_id: String, user_name: String){
        apiService.registerUser(user_id: user_id, user_name: user_name) { result in
            switch result {
            case .success(let data):
                print("registerUser: \(data)")
                defaults.set(user_id, forKey: "user_id")
                active = false
            case .failure(let error):
                print("registerUser: \(error)")
            }
        }
    }
    
    func containsNonAlphanumericCharacters(_ input: String) -> Bool {
        let alphanumeric = CharacterSet.alphanumerics
        return input.unicodeScalars.contains { !alphanumeric.contains($0) }
    }
}
