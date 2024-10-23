import SwiftUI
import Foundation
struct ContentView: View {
    @State private var isExpanded: Bool = false
    @StateObject private var viewModel = BetsViewModel()
    @State private var searchText: String = ""
    @State private var selectedType: StatesBet?
    @FocusState private var isSearchFieldFocused: Bool
    var body: some View {
        VStack {
            headerTop()
            .padding(.horizontal, 16)
            if !viewModel.isLoading {
                List(viewModel.filteredBets(searchText: searchText), id: \.0.operation) { (bet, betDeail) in
                    VStack {
                        Section(header: headerView(for: betDeail.BetNivel)) {
                            CardBet(
                                createdDate: bet.createdDate,
                                wager: bet.wager,
                                odds: bet.odds,
                                status: bet.status,
                                type: bet.type,
                                winning: bet.winning,
                                marketName: betDeail.BetSelections?.first?.MarketName,
                                eventName: betDeail.BetSelections?.first?.EventName,
                                betId: String(betDeail.BetId),
                                home: {
                                    let eventName = betDeail.BetSelections?.first?.EventName ?? ""
                                    return teamName(eventName, before: true)
                                }(),
                                visitor: {
                                    let eventName = betDeail.BetSelections?.first?.EventName ?? ""
                                    return teamName(eventName, before: false)
                                }(),
                                homeScore: {
                                    let eventName = betDeail.BetSelections?.first?.EventScore ?? ""
                                    return eventScore(eventName, before: true)
                                }(),
                                visitorScore: {
                                    let eventName = betDeail.BetSelections?.first?.EventScore ?? ""
                                    return eventScore(eventName, before: false)
                                }(),
                                listBbSelections: betDeail.BetSelections?.first?.BBSelections ?? [],
                                listBetSelections: betDeail.BetSelections
                            )
                        }
                    }
                }
            } else {
                ProgressView("Cargando...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                Spacer()
            }
        }
        .onAppear {
            isSearchFieldFocused = true
        }
    }
    
    private func headerView(for level: String) -> some View {
        HStack {
            Text(level)
                .font(.headline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func headerTop() -> some View {
        VStack {
            Image("Apuesta_total_logo.svg")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
            Text("Todas tus apuestas")
                .font(.title2)
                .fontWeight(.bold)
                .lineLimit(nil)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)
            TextField("Buscar...", text: $searchText)
                .font(.caption)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($isSearchFieldFocused)
            Picker("Estatus", selection: $viewModel.selectedStatus) {
                Text("Todos").tag(StatesBet?.none as StatesBet?)
                Text("Ganada").tag(StatesBet.won as StatesBet?)
                Text("Perdida").tag(StatesBet.lost as StatesBet?)
            }
            .pickerStyle(SegmentedPickerStyle())
            DisclosureGroup(isExpanded: $isExpanded) {
                ForEach(StatesBet.allCases.prefix(2), id: \.self) { type in
                    Button(action: {
                        if selectedType == type {
                            selectedType = nil
                            viewModel.selectedType = nil
                        } else {
                            selectedType = type
                            viewModel.selectedType = type
                        }
                    }) {
                        HStack {
                            Text(type.labelText)
                                .font(.caption)
                                .foregroundColor(.gray)
                            Spacer()
                            if selectedType == type {
                                Image(systemName: "checkmark")
                            }
                        }
                        .padding(.vertical, 1)
                    }
                }
            } label: {
                Text("Seleccionar Tipo de Apuesta")
                    .font(.caption)
                    .foregroundColor(.black)
                    .fontWeight(.medium)
            }
            .padding(.bottom, 8)
        }
    }
}

#Preview {
    ContentView()
}
