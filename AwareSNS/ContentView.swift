import SwiftUI




struct ContentView: View {
    @State private var selectedTab: Int = 2
    @State private var isNewPostModalActive: Bool = false
    @State private var isUserRegisterModalActive: Bool = false
    @State private var reload_timeline: Bool = false
    @State private var emotion: String = "0"
    
    let defaults = UserDefaults.standard
    let apiService = APIService()
    
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
            .navigationBarTitle("Aware SNS \(emotion)")
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
                        NewPostView(active: $isNewPostModalActive, emotion: $emotion)
                    })
                , alignment: .bottomTrailing
            )
        }
        .fullScreenCover(isPresented: $isUserRegisterModalActive, content: {
            RegisterUserView(active: $isUserRegisterModalActive)
        })
        .onAppear{
            isUserRegistered { isSuccess in
                if isSuccess {
                    if defaults.object(forKey: "user_id") != nil {
                        isUserRegisterModalActive = false
                        getEmotion(user_id: defaults.string(forKey: "user_id")!)
                    } else {
                        isUserRegisterModalActive = true
                    }
                } else {
                    isUserRegisterModalActive = true
                }
            }
            
        }
    }
    
    func isUserRegistered(completion: @escaping (Bool) -> Void) {
        if defaults.object(forKey: "user_id") != nil {
            apiService.isUserRegistered(user_id: defaults.string(forKey: "user_id")!) { result in
                switch result {
                case .success(let data):
                    print("isUserRegistered: \(data)")
                    completion(data.success) // APIの結果をコールバックで返す
                case .failure(let error):
                    print("isUserRegistered: \(error)")
                    completion(false) // エラーが発生した場合もコールバックで結果を返す
                }
            }
        } else {
            completion(false)
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
