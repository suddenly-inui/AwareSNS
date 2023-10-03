import SwiftUI

struct PostDetailView: View {
    var post: Post
    let apiService = APIService()
    let defaults = UserDefaults.standard
    
    @State var replies: [Reply] = []
    @State var text: String = ""
    @State var showAlert: Bool = false
    @State var buttonDisabled: Bool = true
    
    @State private var offset: CGFloat = 0
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack {
            PostView(post: post)
            
            HStack{
                TextField("返信をポスト", text: $text, axis: .vertical)
                    .lineLimit(1...5)
                    .padding()
                    .focused($isFocused)
                    .onChange(of: text){
                        if text.isEmpty || text.count > 120{
                            buttonDisabled = true
                        } else {
                            buttonDisabled = false
                        }
                    }
                
                Button(action: {
                    send_reply(post_id: post.post_id, user_id: defaults.string(forKey: "user_id")!, content: text.trimmingCharacters(in: .whitespacesAndNewlines))
                }){
                    Text("送信")
                }
                .padding()
                .disabled(buttonDisabled)
            }
            
            Divider()
            
            ScrollView{
                VStack{
                    ForEach(replies, id: \.reply_id) { reply in
                        ReplyView(reply: reply)
                    }
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { _ in
                        isFocused = false
                    }
            )
            
            
            Spacer()
        }
        .navigationBarTitle(post.user_name)
        .onAppear{
            fetchReplies(post_id: post.post_id)
        }
    }
    
    func fetchReplies(post_id: String){
        apiService.fetchReplies(post_id: post_id) { result in
            switch result {
            case .success(let data):
                print("fetched replies")
                replies = data
                text = ""
            case .failure(let error):
                print("fetchRepies: \(error)")
            }
        }
    }
    
    func send_reply(post_id: String, user_id: String, content: String){
        apiService.sendReply(post_id: post_id, user_id: user_id, content: content) { result in
            switch result {
            case .success(let data):
                print("send_reply: \(data)")
                isFocused = false
                fetchReplies(post_id: post_id)
            case .failure(let error):
                print("sendReply: \(error)")
            }
        }
    }
}
