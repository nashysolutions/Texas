import SwiftUI
import Poker
import PlayingCards

struct ContentView: View {
    
    private let dealer = Dealer()
    
    @State private var model = ViewModel(cards: Dealer.makeHiddenCards())
    
    var body: some View {
        VStack {
            Text(model.title).font(.largeTitle)
            CardsView(
                model: .init(cards: model.cards),
                cardHeight: 200
            )
            makeButton(with: model.buttonTitle)
                .padding()
        }
        .padding()
        .onReceive(dealer.publisher) {
            model = ViewModel(cards: $0)
        }
    }
    
    private func makeButton(with title: String) -> some View {
        Button(title) {
            dealer.shuffle()
        }
        .buttonStyle(.bordered)
        .foregroundColor(.black)
        .font(.system(size: 24))
    }
}

extension ContentView {
    
    struct ViewModel {
        
        let cards: [PlayingCard]
        
        var title: String {
            if isHidden {
                return "Texas Hold'em"
            }
            return hand.description
        }
        
        var buttonTitle: String {
            if isHidden {
                return "Reveal"
            }
            return "Deal Again"
        }
        
        // The game must be texas hold'em.
        private var hand: Hand {
            guard let hand = Hand(cards: cards) else {
                fatalError("Unexpected card count.")
            }
            return hand
        }
        
        private var isHidden: Bool {
            cards.first?.isHidden == true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeLeft)
            .previewLayout(.sizeThatFits)
    }
}
