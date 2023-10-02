import SwiftUI

struct PostView: View {
    var post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading){
                    HStack {
                        Text(post.user_name)
                            .fontWeight(.bold)
                        Text(post.timestamp)
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
                
            }
            .padding()
            .padding(.leading, 20)
            Divider()
        }
        .buttonStyle(PlainButtonStyle())
        .foregroundColor(Color.primary)
    }
}
