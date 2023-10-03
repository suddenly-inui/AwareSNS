import SwiftUI

struct ReplyView: View {
    var reply: Reply
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading){
                    HStack {
                        Text(reply.user_name)
                            .fontWeight(.bold)
                        Text(reply.timestamp)
                            .foregroundColor(.gray)
                    }
                    Text("@\(reply.user_id)")
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 10)
                
                Text(reply.content)
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
