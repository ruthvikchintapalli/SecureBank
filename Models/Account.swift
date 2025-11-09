import Foundation

struct Account: Identifiable, Codable {
    let id = UUID()
    var name: String
    var balance: Double
    var accountNumber: String
}

struct Transaction: Identifiable, Codable {
    let id = UUID()
    let amount: Double
    let description: String
    let date: Date
    let isPending: Bool
}

struct Contact: Identifiable, Codable {
    let id = UUID()
    let name: String
    let email: String
    let phone: String
}
