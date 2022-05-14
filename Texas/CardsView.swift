import SwiftUI
import PlayingCards

struct CardsView: View {
    
    let model: ViewModel
    
    let cardHeight: CGFloat
    
    var body: some View {
        VStack {
            makeSpread(with: model.river)
            makeSpread(with: model.deal)
        }
    }
    
    private func makeSpread(with cards: [PlayingCard]) -> some View {
        HStack {
            ForEach(cards) { card in
                CardView(card: card, size: cardHeight)
            }
        }
    }
}

extension CardsView {
    
    struct ViewModel {
        
        let deal: [PlayingCard]
        let river: [PlayingCard]
        
        // The game must be texas hold'em
        init(cards: [PlayingCard]) {
            guard cards.count == 7 else {
                fatalError("Unexpected count of cards.")
            }
            river = Array(cards.suffix(5))
            deal = Array(cards.prefix(2))
        }
    }
}

struct CardsView_Previews: PreviewProvider {
    
    private static var cards: [PlayingCard] {
        [
            ClubCard(rank: .ace),
            DiamondCard(rank: .two),
            ClubCard(rank: .three),
            ClubCard(rank: .four),
            ClubCard(rank: .five),
            ClubCard(rank: .six),
            ClubCard(rank: .seven)
        ]
    }
    
    static var previews: some View {
        CardsView(model: .init(cards: cards), cardHeight: 200)
            .previewInterfaceOrientation(.landscapeLeft)
            .previewLayout(.sizeThatFits)
    }
}
