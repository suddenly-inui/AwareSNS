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
                        Text(formatDateString(inputString: post.timestamp))
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
    }
    
    func formatDateString(inputString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = inputFormatter.date(from: inputString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy/MM/dd HH:mm"
            let outputString = outputFormatter.string(from: date)
            return outputString
        } else {
            return "" // パースに失敗した場合はnilを返すか、エラーを処理する方法を選んでください
        }
    }
}
