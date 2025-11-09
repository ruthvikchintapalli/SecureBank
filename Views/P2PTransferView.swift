import SwiftUI
import LocalAuthentication

struct P2PTransferView: View {
    @EnvironmentObject var authService: AuthService
    @StateObject private var dataService = BankDataService()
    @State private var searchText = ""
    @State private var selectedContact: Contact?
    @State private var amount = ""
    @State private var showSuccess = false
    @Environment(\.dismiss) var dismiss
    
    private var filteredContacts: [Contact] {
        if searchText.isEmpty {
            return dataService.contacts
        } else {
            return dataService.contacts.filter { 
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.email.localizedCaseInsensitiveContains(searchText) ||
                $0.phone.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search by name, email, or phone", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                .padding(.horizontal)
                
                List(filteredContacts) { contact in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(contact.name).font(.headline)
                            Text(contact.email).font(.caption).foregroundColor(.secondary)
                            Text(contact.phone).font(.caption).foregroundColor(.secondary)
                        }
                        Spacer()
                        Button("Pay") {
                            selectedContact = contact
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.blue)
                    }
                    .onTapGesture { selectedContact = contact }
                }
                .listStyle(PlainListStyle())
                
                if let contact = selectedContact {
                    VStack(spacing: 10) {
                        Text("Pay \(contact.name)")
                            .font(.title2).bold()
                        TextField("$0.00", text: $amount)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .multilineTextAlignment(.center)
                            .font(.title2)
                        
                        Button("Send $\(Double(amount) ?? 0, specifier: "%.2f")") {
                            guard let amt = Double(amount), amt > 0 else { return }
                            dataService.sendP2PTransfer(amount: amt, toContact: contact) { success in
                                if success { showSuccess = true }
                            }
                        }
                        .disabled(amount.isEmpty || Double(amount) == nil || Double(amount) == 0)
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                        .padding(.top)
                    }
                    .transition(.scale.combined(with: .opacity))
                }
            }
            .navigationTitle("Pay Friends")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
            .alert("Zelle Sent!", isPresented: $showSuccess) {
                Button("OK") { dismiss() }
            } message: {
                Text("$\(amount) sent to \(selectedContact?.name ?? "") via Zelle. They'll get it instantly!")
            }
        }
    }
}
