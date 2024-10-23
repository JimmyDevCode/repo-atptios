import Foundation
struct Bet: Identifiable, Codable {
    let id = UUID()
    let db: Int
    let operation: Int
    let game: String
    let createdDate: String
    let status: StatesBet
    let wager: Double
    let winning: Double?
    let odds: Double
    let type: StatesBet
    let account: String

    enum CodingKeys: String, CodingKey {
        case db
        case operation
        case game
        case createdDate = "created_date"
        case status
        case wager
        case winning
        case odds
        case type
        case account
    }
}

struct BetDetail: Codable {
    let BetId: Int
    let BetNivel: String
    let BetStatusName: String
    let BetTypeName: String
    let TotalOdds: String
    let TotalStake: String
    let TotalWin: String
    let CreatedDate: String
    let BetSelections: [BetSelection]?
}

struct BetSelection: Codable {
    let SelectionId: Int?
    let SelectionStatus: Int?
    let Price: String?
    let Name: String?
    let MarketName: String?
    let BBSelections: [BBSelections]?
    let EventName: String?
    let EventScore: String?
}

struct BBSelections: Codable {
    let SelectionId: Int?
    let SelectionName: String?
    let MarketName: String?
}
