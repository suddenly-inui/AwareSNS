import SwiftUI

struct LogInView: View {
    @State private var user_id: String = ""
    @State private var password: String = ""
    
    @State var buttonDisabled: Bool = true
    @State var showAlert: Bool = false
    @State var error_text: String = ""
    
    @Binding var active: Bool

    let defaults = UserDefaults.standard
    let apiService = APIService()

    var body: some View {
        VStack {
            Text("ログイン")
                .font(.title)
            
            TextField("IDを入力してください", text: $user_id)
                .autocapitalization(.none)
                .textFieldStyle(PlainTextFieldStyle())
                .padding()
                .onChange(of: user_id){
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
            
            Button(action: {
                logIn(id: user_id, pass: password)
            }) {
                Text("ログイン")
                    .padding()
                    .background(buttonDisabled ? .gray :.blue)
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
            .disabled(buttonDisabled)
        }
        .padding()
    }
    
    func logIn(id: String, pass: String){
        apiService.LogIn(user_id: id, password: pass) { result in
            switch result {
            case .success(let data):
                print("registerUser: \(data)")
                if data.success {
                    defaults.set(user_id, forKey: "user_id")
                    active = false
                } else {
                    error_text = "IDまたはパスワードが一致しません"
                    showAlert = true
                    user_id = ""
                    password = ""
                }
            case .failure(let error):
                print("registerUser: \(error)")
            }
        }
    }
    
    func check_input(){
       buttonDisabled = password.isEmpty || user_id.isEmpty
    }
    
    func containsNonAlphanumericCharacters(_ input: String) -> Bool {
        let alphanumeric = CharacterSet.alphanumerics
        return input.unicodeScalars.contains { !alphanumeric.contains($0) }
    }
}

