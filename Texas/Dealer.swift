import Foundation
import PlayingCards
import Combine

struct Dealer {
    
    static let totalCards: Int = 7
        
    var publisher: AnyPublisher<[PlayingCard], Never> {
        subject.eraseToAnyPublisher()
    }
    
    private let subject = PassthroughSubject<[PlayingCard], Never>()
    
    static func makeHiddenCards() -> [PlayingCard] {
        var ranks = Rank.allCases.makeIterator()
        var total = Self.totalCards
        var cards: [PlayingCard] = []
        while total > 0 {
            guard let rank = ranks.next() else {
                break
            }
            let card = ClubCard(rank: rank)
            card.isHidden = true
            cards.append(card)
            total -= 1
        }
        return cards
    }

    func shuffle() {
        let deck = Deck()
        deck.shuffle()
        let cards: [PlayingCard] = deck.cards.prefix(Self.totalCards).map { (card: PlayingCard) in
            switch card.suit {
            case .clubs:
                return ClubCard(rank: card.rank)
            case .hearts:
                return HeartCard(rank: card.rank)
            case .diamonds:
                return DiamondCard(rank: card.rank)
            case .spades:
                return SpadeCard(rank: card.rank)
            }
        }
        subject.send(cards)
    }
}
