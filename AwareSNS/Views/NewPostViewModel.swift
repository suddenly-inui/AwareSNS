//
//  NewPostViewModel.swift
//  AwareSNS
//
//  Created by Yuki Inui on 2023/10/04.
//

import SwiftUI

struct NewPostViewModel {
    
    @Binding var active: Bool
    @Binding var emotion: String
    
    
    let apiService = APIService()
    let defaults = UserDefaults.standard
    func send_post(user_id: String, content: String, emotion: String){
        apiService.sendPost(user_id: user_id, content: content, emotion: emotion) { result in
            switch result {
            case .success(let data):
                print("send_post: \(data)")
                active = false
            case .failure(let error):
                print("sendPost: \(error)")
            }
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
