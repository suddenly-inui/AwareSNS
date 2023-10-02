//
//  ProfileView.swift
//  AwareSNS
//
//  Created by Yuki Inui on 2023/10/03.
//

import SwiftUI

struct ProfileView: View {
    let defaults = UserDefaults.standard
    var body: some View {
        VStack{
            Text(defaults.string(forKey: "user_id")!)
        }
    }
}

#Preview {
    ProfileView()
}
