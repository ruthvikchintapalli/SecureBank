import Foundation
import Combine

class BankDataService: ObservableObject {
    @Published var accounts: [Account] = []
    @Published var transactions: [Transaction] = []
    @Published var contacts: [Contact] = []

    private let defaults = UserDefaults.standard
    private let accountsKey = "cachedAccounts"
    private let transactionsKey = "cachedTransactions"
    private let contactsKey = "cachedContacts"

    init() { loadCachedData() }

    func loadCachedData() {
        accounts = load(key: accountsKey) ?? mockAccounts()
        transactions = load(key: transactionsKey) ?? mockTransactions()
        contacts = load(key: contactsKey) ?? mockContacts()
    }

    private func load<T: Decodable>(key: String) -> [T]? {
        guard let data = defaults.data(forKey: key),
              let decoded = try? JSONDecoder().decode([T].self, from: data) else { return nil }
        return decoded
    }

    private func saveCache() {
        save(accounts, key: accountsKey)
        save(transactions, key: transactionsKey)
        save(contacts, key: contactsKey)
    }

    private func save<T: Encodable>(_ items: [T], key: String) {
        if let data = try? JSONEncoder().encode(items) {
            defaults.set(data, forKey: key)
        }
    }

    func sendTransfer(amount: Double, to: String, completion: @escaping (Bool) -> Void) {
        simulateNetwork {
            let tx = Transaction(amount: -amount, description: "To \(to)", date: Date(), isPending: true)
            self.transactions.insert(tx, at: 0)
            self.accounts[0].balance -= amount
            self.saveCache()
            completion(true)
        }
    }

    func sendP2PTransfer(amount: Double, toContact: Contact, completion: @escaping (Bool) -> Void) {
        simulateNetwork {
            let tx = Transaction(amount: -amount,
                                 description: "Zelle to \(toContact.name)",
                                 date: Date(),
                                 isPending: true)
            self.transactions.insert(tx, at: 0)
            self.accounts[0].balance -= amount
            self.saveCache()
            completion(true)
        }
    }

    private func simulateNetwork(_ block: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: block)
    }

    private func mockAccounts() -> [Account] {
        [
            Account(name: "Checking", balance: 5420.00, accountNumber: "****1234"),
            Account(name: "Savings", balance: 12500.00, accountNumber: "****5678")
        ]
    }

    private func mockTransactions() -> [Transaction] {
        [
            Transaction(amount: -45.99, description: "Starbucks", date: .now.addingTimeInterval(-86400), isPending: false),
            Transaction(amount: -1200.00, description: "Rent", date: .now.addingTimeInterval(-172800), isPending: false),
            Transaction(amount: 3000.00, description: "Paycheck", date: .now.addingTimeInterval(-345600), isPending: false)
        ]
    }

    private func mockContacts() -> [Contact] {
        [
            Contact(name: "Alice Johnson", email: "alice@email.com", phone: "(555) 123-4567"),
            Contact(name: "Bob Smith", email: "bob@email.com", phone: "(555) 987-6543"),
            Contact(name: "Charlie Lee", email: "charlie@email.com", phone: "(555) 456-7890")
        ]
    }
}
