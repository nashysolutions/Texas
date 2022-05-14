import SwiftUI
import PlayingCards

struct CardView<C: Card>: View {
    
    let card: C
    let size: CGFloat
    
    var body: some View {
        Text(card.description)
            .font(.system(size: size))
            .foregroundColor(color)
    }
    
    private var color: Color {
        if card.isHidden {
            return .black
        }
        switch card.suit {
        case .diamonds, .hearts: return .red
        case .clubs, .spades: return .black
        }
    }
}

struct Previews_CardView_Previews: PreviewProvider {
    
    static var previews: some View {
        CardView(
            card: ClubCard(rank: .seven),
            size: 200
        ).previewLayout(.sizeThatFits)
    }
}
