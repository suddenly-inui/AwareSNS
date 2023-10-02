import SwiftUI




struct ContentView: View {
    @State private var selectedTab: Int = 2
    @State private var isNewPostModalActive: Bool = false
    @State private var isUserRegisterModalActive: Bool = false
    @State private var reload_timeline: Bool = false
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                // ここに各タブのコンテンツを追加します
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                    }
                    .tag(1)
                
                TimeLineView(reload: $reload_timeline)
                    .tabItem {
                        Image(systemName: "house.fill")
                    }
                    .tag(2)
                    .onChange(of: isNewPostModalActive){
                        if !isNewPostModalActive{
                            reload_timeline.toggle()
                        }
                    }
                
                Text("cc")
                    .tabItem {
                        Image(systemName: "dollarsign")
                    }
                    .tag(3)
            }
            .navigationBarTitle("Aware SNS")
            .navigationBarTitleDisplayMode(.inline)
            .overlay(
                Button(action: {
                    isNewPostModalActive = true
                }) {
                    if selectedTab == 2{
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(15)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                }
                    .padding(30)
                    .padding(.bottom, 40)
                    .fullScreenCover(isPresented: $isNewPostModalActive, content: {
                            NewPostView(active: $isNewPostModalActive)
                    })
                , alignment: .bottomTrailing
            )
        }
        .fullScreenCover(isPresented: $isUserRegisterModalActive, content: {
            UserRegisterView(active: $isUserRegisterModalActive)
        })
        .onAppear{
            isUserRegisterModalActive = (defaults.object(forKey: "user_id") == nil)
        }
    }
}
