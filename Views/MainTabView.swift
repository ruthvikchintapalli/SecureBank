import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            TransferView()
                .tabItem {
                    Label("Send", systemImage: "paperplane")
                }
            
            P2PTransferView()
                .tabItem {
                    Label("Pay", systemImage: "arrow.up.right.circle")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .accentColor(.blue)
    }
}
