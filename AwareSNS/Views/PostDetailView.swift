import SwiftUI

struct PostDetailView: View {
    var post: Post
    
    var body: some View {
        VStack {
            Text(post.user_name)
                .font(.headline)
                .padding()
            Text(post.content)
                .font(.body)
                .padding()
            Spacer()
        }
        .navigationBarTitle(post.user_name)
    }
}
