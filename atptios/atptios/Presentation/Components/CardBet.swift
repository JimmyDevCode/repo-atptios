import SwiftUI

struct CardBet: View {
    @State private var isExpanded: Bool = false
    
    let createdDate: String?
    let wager: Double?
    let odds: Double?
    let status: StatesBet
    let type: StatesBet
    let winning: Double?
    let marketName: String?
    let eventName: String?
    let betId: String?
    let home: String?
    let visitor: String?
    let homeScore: String?
    let visitorScore: String?
    let listBbSelections: [BBSelections]?
    let listBetSelections: [BetSelection]?
    
    init(
        createdDate: String? = nil,
        wager: Double? = nil,
        odds: Double? = nil,
        status: StatesBet,
        type: StatesBet,
        winning: Double? = nil,
        marketName: String? = nil,
        eventName: String? = nil,
        betId: String? = nil,
        home: String? = nil,
        visitor: String? = nil,
        homeScore: String? = nil,
        visitorScore: String? = nil,
        listBbSelections: [BBSelections]? = nil,
        listBetSelections: [BetSelection]? = nil
    ) {
        self.createdDate = createdDate
        self.wager = wager
        self.odds = odds
        self.status = status
        self.type = type
        self.winning = winning
        self.marketName = marketName
        self.eventName = eventName
        self.betId = betId
        self.home = home
        self.visitor = visitor
        self.homeScore = homeScore
        self.visitorScore = visitorScore
        self.listBbSelections = listBbSelections
        self.listBetSelections = listBetSelections
    }
    
    var body: some View {
        VStack {
            HStack{
                TagText(text: type)
                TagText(text: status)
                Spacer()
                Text(createdDate ?? String())
                    .font(.caption)
                    .foregroundColor(.gray)
                Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                    .foregroundColor(.red)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isExpanded.toggle()
                        }
                    }
            }
            HStack {
                VStack(alignment: .leading) {
                    Text((marketName ?? "") == "BetBuilder" ? "Apuesta creada" : (marketName ?? ""))
                        .font(.caption)
                        .foregroundColor(.black)
                    
                        .lineLimit(nil)
                    Text(eventName ?? String())
                        .font(.caption)
                        .lineLimit(nil)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            HStack{
                VStack (alignment: .leading){
                    Text("Apuesta")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("S/ \(String(format: "%.2f", wager ?? 0.0))")
                        .font(.caption)
                        .foregroundColor(.black)
                }
                Spacer()
                VStack {
                    Text("Cuotas")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(String(format: "%.2f", odds ?? 0.0))
                        .font(.caption)
                        .foregroundColor(.black)
                }
                Spacer()
                VStack (alignment: .trailing) {
                    Text("Pago")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("S/ \(String(format: "%.2f", winning ?? 0.0))")
                        .font(.caption)
                        .foregroundColor(.black)
                }
            }
            .padding(.top, 8)
            VStack {
                if isExpanded {
                    DetailBet(
                        marketName: marketName,
                        wager: wager,
                        odds: odds,
                        betId: betId,
                        home: home,
                        visitor: visitor,
                        homeScore: homeScore,
                        visitorScore: visitorScore,
                        createdDate: createdDate,
                        type: type,
                        status: status,
                        listBbSelections: listBbSelections,
                        listBetSelections: listBetSelections
                    )
                    .padding(.top, 16)
                    .transition(.opacity)
                    .id(UUID())
                }
            }
        }
    }
}

#Preview {
    CardBet(status: .simple, type: .won)
}
