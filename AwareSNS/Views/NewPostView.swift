import SwiftUI

struct NewPostView: View {
    @Binding var active: Bool
    @State var showAlert: Bool = false
    @State var post_content: String = ""
    
    let apiService = APIService()
    let defaults = UserDefaults.standard
    
    var body: some View {
        VStack{
            HStack(alignment: .top){
                Button(action: {
                    active = false
                }){
                    Text("キャンセル")
                }
                Spacer()
                Button(action: {
                    if !post_content.isEmpty || post_content.count > 120{
                        send_post(user_id: defaults.string(forKey: "user_id")!, content: post_content.trimmingCharacters(in: .whitespacesAndNewlines))
                    } else {
                        showAlert = true
                    }
                }){
                    Text("ポストする")
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("エラー"),
                        message: Text("ポストの内容を120字以内で入力してください"),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .padding()
            
            TextField("いまなにしてる？", text: $post_content, axis: .vertical)
                .lineLimit(15...15)
                .padding()
            
            Spacer()
        }
        
    }
    
    func send_post(user_id: String, content: String){
        apiService.sendPost(user_id: user_id, content: content) { result in
            switch result {
            case .success(let data):
                print(data)
                active = false
            case .failure(let error):
                print("APIエラー: \(error)")
            }
        }
    }
}

