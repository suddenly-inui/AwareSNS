//
//  ProfileView.swift
//  AwareSNS
//
//  Created by Yuki Inui on 2023/10/03.
//

import SwiftUI

struct ProfileView: View {
    let defaults = UserDefaults.standard
    let apiService = APIService()
    
    @State var user: User = User(user_id: "", user_name: "")
    
    var body: some View {
        VStack{
            Text(user.user_id)
            Text(user.user_name)
        }
        .onAppear{
            fetchUser(user_id: defaults.string(forKey: "user_id")!)
        }
    }
    
    func fetchUser(user_id: String){
        apiService.fetchUser(user_id:user_id) { result in
            switch result {
            case .success(let data):
                print("user: \(data)")
                user = data
            case .failure(let error):
                print("fetchUser: \(error)")
            }
        }
        
    }
}
