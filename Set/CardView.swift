import SwiftUI

struct CardView: View {
    let card: SetGameModel<Symbol>.Card
    let cardColor: Color = .black
    
    init(_ card: SetGameModel<Symbol>.Card) {
        self.card = card
    }
    
    var body: some View {
        VStack {
            ForEach(0..<card.content.number, id: \.self) { _ in
                shapeView(
                    for: card.content.shape,
                    color: card.content.color.swiftUIColor,
                    shading: card.content.shading
                )
                .frame(width: 60, height: 30)
            }
        }
        .padding(Constants.inset)
        .cardify(cardColor: cardColor)
        .aspectRatio(Constants.aspectRatio, contentMode: .fit)
        .onAppear {
            print("Rendering:", card.content)
        }
    }
}

// MARK: - Helper Functions

@ViewBuilder
func shapeView(for shape: Symbol.Shape, color: Color, shading: Symbol.Shading) -> some View {
    switch shape {
    case .diamond:
        buildShape(Diamond(), color: color, shading: shading)
    case .oval:
        buildShape(Ellipse(), color: color, shading: shading)
    case .rectangle:
        buildShape(RoundedRectangle(cornerRadius: 10), color: color, shading: shading)
    }
}

func buildShape<ShapeType: Shape>(_ shape: ShapeType, color: Color, shading: Symbol.Shading) -> some View {
    switch shading {
    case .solid:
        return AnyView(shape.fill(color))
    case .striped:
        return AnyView(
            shape
                .stroke(color, lineWidth: 1)
                .background(Stripes().mask(shape))
        )
    case .open:
        return AnyView(shape.stroke(color, lineWidth: 2))
    }
}

// MARK: - Stripes View

struct Stripes: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let spacing: CGFloat = 5
                for x in stride(from: 0, through: geometry.size.width, by: spacing) {
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x, y: geometry.size.height))
                }
            }
            .stroke(Color.black, lineWidth: 1)
        }
    }
}

// MARK: - Constants

public struct Constants {
    static let cornerRadius: CGFloat = 12
    static let lineWidth: CGFloat = 5
    static let inset: CGFloat = 5
    static let aspectRatio: CGFloat = 1
    
    struct FontSize {
        static let largest: CGFloat = 200
        static let smallest: CGFloat = 10
        static let scaleFactor = smallest / largest
    }
}

// MARK: - Symbol Color Extension

import SwiftUI

extension Symbol.Color {
    var swiftUIColor: Color {
        switch self {
        case .red: return .red
        case .green: return .green
        case .purple: return .purple
        }
    }
}


// MARK: - Preview

//#Preview {
//    let symbol = Symbol(shape: .diamond, color: .red, number: 3, shading: .striped)
//    let card = SetGameModel<Symbol>.Card(id: "1", cardFace: symbol)
//    return CardView(card)
//}
