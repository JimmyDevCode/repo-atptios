import SwiftUI
class BetsViewModel: ObservableObject {
    @Published var combinedBets: [(Bet, BetDetail)] = []
    @Published var selectedStatus: StatesBet? = nil
    @Published var selectedType: StatesBet? = nil
    @Published var isLoading: Bool = true

    init() {
        loadData()
    }
    private func loadData(){
        DispatchQueue.global(qos: .userInitiated).async {
            Thread.sleep(forTimeInterval: 2.0)
            let bets = self.loadBets()
            let betDetails = self.loadBetDetails()
            DispatchQueue.main.async {
                self.combinedBets = self.crossData(bets: bets, betDetails: betDetails)
                self.isLoading = false
            }
        }
    }
    
    private func loadDataGeneric<T: Decodable>(from filename: String) -> [T] {
        if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                return try decoder.decode([T].self, from: data)
            } catch {
                print("Error al cargar datos de \(filename).json: \(error)")
            }
        }
        return []
    }

    private func loadBets() -> [Bet]{
        return loadDataGeneric(from: "betsAll")
    }
    
    private func loadBetDetails() -> [BetDetail] {
        return loadDataGeneric(from: "betsDetailsAll")
    }
    
    private func crossData(bets: [Bet], betDetails: [BetDetail]) -> [(Bet, BetDetail)] {
        var combinedData = [(Bet, BetDetail)]()
        
        for bet in bets {
            if let detail = betDetails.first(where: { $0.BetId == Int(bet.game) }) {
                combinedData.append((bet, detail))
            }
        }
        
        return combinedData
    }
    
    func filteredBets(searchText: String) -> [(Bet, BetDetail)] {
        var filtered = combinedBets
        
        if !searchText.isEmpty {
            filtered = filtered.filter { (bet, detail) in
                detail.BetSelections?.first?.EventName?.localizedCaseInsensitiveContains(searchText) ?? false
            }
        }
        if let selectedStatus = selectedStatus {
            filtered = filtered.filter { (bet, _) in
                bet.status == selectedStatus
            }
        }
        if let selectedType = selectedType {
            filtered = filtered.filter { (bet, _) in
                bet.type == selectedType
            }
        }
        
        return filtered
    }
}
