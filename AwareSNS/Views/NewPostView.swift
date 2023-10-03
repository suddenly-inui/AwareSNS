import SwiftUI

struct NewPostView: View {
    @Binding var active: Bool
    @State var showAlert: Bool = false
    @State var post_content: String = ""
    @State var buttonDisabled: Bool = true
    
    //emotion
    @Binding var emotion: String
    
    @FocusState var isFocused: Bool
    
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
                    if !post_content.isEmpty || post_content.count <= 120{
                        send_post(user_id: defaults.string(forKey: "user_id")!, content: post_content.trimmingCharacters(in: .whitespacesAndNewlines), emotion: emotion)
                    } else {
                        showAlert = true
                    }
                }){
                    Text("ポストする")
                }
                .disabled(buttonDisabled)
            }
            .padding()
            
            TextField("いまなにしてる？", text: $post_content, axis: .vertical)
                .lineLimit(15...15)
                .padding()
                .focused($isFocused)
                .onChange(of: post_content){
                    if post_content.isEmpty || post_content.count > 120{
                        buttonDisabled = true
                    } else {
                        buttonDisabled = false
                    }
                }
            
            Spacer()
        }
        .onAppear{
            isFocused = true
            getEmotion(user_id: defaults.string(forKey: "user_id")!)
        }
    }
    
    func send_post(user_id: String, content: String, emotion: String){
        apiService.sendPost(user_id: user_id, content: content, emotion: emotion) { result in
            switch result {
            case .success(let data):
                print("send_post: \(data)")
                active = false
            case .failure(let error):
                print("sendPost: \(error)")
            }
        }
    }
    
    func getEmotion(user_id: String){
        apiService.getEmotion(user_id:user_id) { result in
            switch result {
            case .success(let data):
                print("got Emotion: \(data.emotion)")
                emotion = data.emotion
            case .failure(let error):
                print("fetchPosts: \(error)")
            }
        }
    }
}

