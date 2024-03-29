import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("animal_kuma")
                .resizable()
                .overlay(
                    Circle().stroke(Color.gray, lineWidth: 1))
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            Text("SwiftUIへの道")
                .font(.largeTitle)
            Text("@road2swiftui")
                .font(.caption)
            Divider()
            ScrollView (.vertical, showsIndicators: true) {
                HStack {
                    Image(systemName: "person")
                    Text("Profile")
                }
                HStack {
                    Image(systemName: "list.dash")
                    Text("Lists")
                }
                HStack {
                    Image(systemName: "text.bubble")
                    Text("Topics")
                }
            }
            Divider()
            Text("Settings and privacy")
        }
        .padding(.horizontal, 20)
    }
}
