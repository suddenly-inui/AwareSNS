import SwiftUI


struct TimeLineView: View {
    let apiService = APIService()
    
    @State private var posts: [Post] = []
    @Binding var reload: Bool
    
    var body: some View {
        ScrollView{
            VStack{
                ForEach($posts, id: \.post_id) { $post in
                    NavigationLink(destination: PostDetailView(post: post)) {
                        PostView(post: post)
                    }
                }
            }
        }
        .onAppear{
            fetchPosts()
        }
        .onChange(of: reload){
            fetchPosts()
        }
        .refreshable(action:{
            fetchPosts()
        })
    }
    
    func fetchPosts(){
        apiService.fetchPosts() { result in
            switch result {
            case .success(let data):
                print("fetched posts")
                posts = data
            case .failure(let error):
                print("fetchPosts: \(error)")
            }
        }
        
    }
}
