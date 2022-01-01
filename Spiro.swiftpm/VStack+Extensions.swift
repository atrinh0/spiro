import SwiftUI

extension VStack {
    func paddedStack() -> some View {
        self.modifier(PaddedStyle())
    }
}

struct PaddedStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .accentColor(.init(white: 0.75))
            .padding(.vertical)
            .padding(.horizontal, 20)
            .background(RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .foregroundColor(Color(.sRGB, white: 0.1, opacity: 0.5)))
            .padding(.horizontal)
    }
}
