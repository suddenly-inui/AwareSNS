import SwiftUI

struct PostView: View {
    var post: Post
    let apiService = APIService()
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading){
                    HStack {
                        Text(post.user_name)
                            .fontWeight(.bold)
                        Text(post.timestamp)
                            .foregroundColor(.gray)
                        Text("\(post.emotion)")
                            .foregroundColor(.gray)
                    }
                    Text("@\(post.user_id)")
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 10)
                
                Text(post.content)
                    .lineLimit(nil)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                HStack{
                    Image(systemName: "message")
                        .foregroundColor(.gray)
                    Text("\(post.reply_count)")
                        .foregroundColor(.gray)
                }
                .padding(.top, 5)
            }
            .padding(.leading, 20)
            Divider()
        }
        .buttonStyle(PlainButtonStyle())
        .foregroundColor(Color.primary)
        .onAppear{
            
        }
    }
}
