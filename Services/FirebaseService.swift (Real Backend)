import Firebase
import FirebaseAuth
import FirebaseFirestore
import CoreData

class FirebaseService: ObservableObject {
    private let db = Firestore.firestore()
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // Auth
    func register(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            completion(error == nil, error)
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            completion(error == nil, error)
        }
    }
    
    // Fetch Accounts (Sync to Core Data)
    func fetchAccounts(completion: @escaping ([Account]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        db.collection("users").document(uid).collection("accounts").getDocuments { snapshot, error in
            let accounts = snapshot?.documents.compactMap { doc -> Account? in
                let data = doc.data()
                return Account(name: data["name"] as? String ?? "", balance: data["balance"] as? Double ?? 0, accountNumber: data["accountNumber"] as? String ?? "")
            } ?? []
            self.saveToCoreData(accounts: accounts)
            completion(accounts)
        }
    }
    
    // Send Transfer (Call Cloud Function)
    func sendTransfer(amount: Double, toEmail: String, completion: @escaping (Bool) -> Void) {
        Functions.functions().httpsCallable("processTransfer").call(["amount": amount, "toEmail": toEmail]) { result, error in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    // Similar for fetchTransactions, fetchContacts...
    
    private func saveToCoreData(accounts: [Account]) {
        for account in accounts {
            let fetchRequest: NSFetchRequest<AccountEntity> = AccountEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", account.name)
            if let existing = try? context.fetch(fetchRequest).first {
                existing.balance = account.balance
            } else {
                let new = AccountEntity(context: context)
                new.name = account.name
                new.balance = account.balance
            }
        }
        try? context.save()
    }
}
