import SwiftUI

struct MainTabView: View {
    @State private var showTransfer = false
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            Button("Transfer") {
                showTransfer = true
            }
            .tabItem {
                Label("Send", systemImage: "paperplane")
            }
            .sheet(isPresented: $showTransfer) {
                TransferView()
            }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}
