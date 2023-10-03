import SwiftUI

struct PostButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .frame(width: 60, height: 60)
            .background(.blue, in: Circle())
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(), value: configuration.isPressed)
            .shadow(radius: 3)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(15)
    }
}

extension ButtonStyle where Self == PostButtonStyle {
    static var twitterPostButton: PostButtonStyle {
        .init()
    }
}
