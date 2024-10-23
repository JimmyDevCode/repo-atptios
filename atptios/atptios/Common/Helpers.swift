import SwiftUI
private func separatorString(
    _ text: String,
    character: String
) -> (beforeVS: String, afterVS: String) {
    guard !text.isEmpty else { return ("", "") }
    let components = text.split(separator: character, maxSplits: 1, omittingEmptySubsequences: true)
    let beforeVS = components.first.map { String($0).trimmingCharacters(in: .whitespaces) } ?? ""
    let afterVS = components.count > 1 ? String(components[1]).trimmingCharacters(in: .whitespacesAndNewlines) : ""
    return (beforeVS, afterVS)
}

func teamName(_ text: String, before: Bool) -> String {
    let resultString = separatorString(text, character: "vs.")
    if before {
        return resultString.beforeVS
    } else {
        return resultString.afterVS
    }
}

func eventScore(_ text: String, before: Bool) -> String {
    let resultString = separatorString(text, character: ":")
    if before {
        return resultString.beforeVS
    } else {
        return resultString.afterVS
    }
}

enum StatesBet: String, Codable, CaseIterable  {
    case simple = "SIMPLE"
        case multiple = "MULTIPLE"
        case won = "WON"
        case lost = "LOST"
        case cashout = "CASHOUT"
    
    var labelText: String {
        switch self {
        case .simple:
            return "SIMPLE"
        case .multiple:
            return "MULTIPLE"
        case .won:
            return "GANADA"
        case .lost:
            return "PERDIDA"
        case .cashout:
            return "CASHOUT"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .simple:
            return Color.gray
        case .multiple:
            return Color.blue
        case .won:
            return Color.green
        case .lost:
            return Color.red
        case .cashout:
            return Color.orange
        }
    }
}
