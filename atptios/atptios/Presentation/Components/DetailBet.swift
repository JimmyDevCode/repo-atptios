import SwiftUI

struct DetailBet: View {
    let marketName: String?
    let wager: Double?
    let odds: Double?
    let betId: String?
    let home: String?
    let visitor: String?
    let homeScore: String?
    let visitorScore: String?
    let createdDate: String?
    let type: StatesBet
    let status: StatesBet
    let listBbSelections: [BBSelections]?
    let listBetSelections: [BetSelection]?
    
    init(
        marketName: String? = nil,
        wager: Double? = nil,
        odds: Double? = nil,
        betId: String? = nil,
        home: String? = nil,
        visitor: String? = nil,
        homeScore: String? = nil,
        visitorScore: String? = nil,
        createdDate: String? = nil,
        type: StatesBet,
        status: StatesBet,
        listBbSelections: [BBSelections]? = nil,
        listBetSelections: [BetSelection]? = nil
    ) {
        self.marketName = marketName
        self.wager = wager
        self.odds = odds
        self.betId = betId
        self.home = home
        self.visitor = visitor
        self.homeScore = homeScore
        self.visitorScore = visitorScore
        self.createdDate = createdDate
        self.type = type
        self.status = status
        self.listBbSelections = listBbSelections
        self.listBetSelections = listBetSelections
    }
    var body: some View {
        VStack {
            VStack{
                VStack{
                    Text("apuestatotal")
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                }
                HStack {
                    Text("Apuesta")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("S/ \(String(format: "%.2f", wager ?? 0.0))")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                HStack {
                    Text("Cuotas")
                        .font(.caption)
                        .foregroundColor(.black)
                    Spacer()
                    Text(String(format: "%.2f", odds ?? 0.0))
                        .font(.caption)
                        .foregroundColor(.black)
                }
            }
            VStack {
                itemDetail(listBetSelections: listBetSelections ?? [])
                multipleView(for: listBbSelections ?? [])
                HStack {
                    Text("RESULTADO FINAL")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.top, 6)
            }
            .padding(8)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            VStack {
                Text("Nro. de cupón: \(betId ?? String())")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("Fecha de apuesta: \(createdDate ?? String())")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.top, 6)
        }
    }
    
    private func itemDetail(listBetSelections: [BetSelection]) -> some View {
        VStack {
            if listBetSelections.count > 1 {
                ForEach(listBetSelections, id: \.SelectionId) { selection in
                    VStack {
                        HStack {
                            TagText(text: selection.SelectionStatus == 1 ? .won : .lost)
                            Spacer()
                        }
                        HStack{
                            Text(selection.MarketName ?? String())
                                .font(.caption)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.top, 6)
                        HStack{
                            Text(teamName(selection.EventName!, before: true))
                                .font(.caption)
                                .foregroundColor(.black)
                                .fontWeight(.light)
                            Spacer()
                            Text(eventScore(selection.EventScore!, before: true))
                                .font(.caption)
                                .foregroundColor(.black)
                                .fontWeight(.light)
                        }
                        HStack{
                            Text(teamName(selection.EventName!, before: false))
                                .font(.caption)
                                .foregroundColor(.black)
                                .fontWeight(.light)
                            Spacer()
                            Text(eventScore(selection.EventScore!, before: false))
                                .font(.caption)
                                .foregroundColor(.black)
                                .fontWeight(.light)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            } else {
                HStack {
                    TagText(text: type)
                    TagText(text: status)
                    Spacer()
                }
                HStack{
                    Text((marketName ?? "") == "BetBuilder" ? "Apuesta creada" : (marketName ?? ""))
                        .font(.caption)
                        .foregroundColor(.black)
                    Spacer()
                    Text(String(format: "%.2f", odds ?? 0.0))
                        .font(.caption)
                        .foregroundColor(.black)
                }
                .padding(.top, 6)
                HStack{
                    Text(home ?? String ())
                        .font(.caption)
                        .foregroundColor(.black)
                        .fontWeight(.light)
                    Spacer()
                    Text(homeScore ?? String())
                        .font(.caption)
                        .foregroundColor(.black)
                        .fontWeight(.light)
                }
                HStack{
                    Text(visitor ?? String())
                        .font(.caption)
                        .foregroundColor(.black)
                        .fontWeight(.light)
                    Spacer()
                    Text(visitorScore ?? String())
                        .font(.caption)
                        .foregroundColor(.black)
                        .fontWeight(.light)
                }
            }
        }
    }
    
    private func multipleView(for list: [BBSelections]) -> some View {
        VStack {
            if !list.isEmpty {
                ForEach(list, id: \.SelectionId) { selection in
                    VStack {
                        Text("\(selection.MarketName ?? String()) - \(selection.SelectionName ?? String())")
                            .foregroundColor(Color.black.opacity(0.7))
                            .fontWeight(.light)
                            .font(.caption)
                            .padding(.vertical, 0.1)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

struct DetailBet_Previews: PreviewProvider {
    static var previews: some View {
        DetailBet(type: .simple, status: .won)
            .previewLayout(.sizeThatFits)
            .previewLayout(.sizeThatFits)
            .padding()
        
    }
}
