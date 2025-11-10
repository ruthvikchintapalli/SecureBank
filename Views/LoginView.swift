import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        ZStack {
            Color.blue.opacity(0.1).ignoresSafeArea()
            
            VStack(spacing: 30) {
                Image(systemName: "lock.shield")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                
                Text("SecureBank")
                    .font(.largeTitle).bold()
                
                Text("Banking made simple & secure")
                    .foregroundColor(.secondary)
                
                Button {
                    authService.authenticateWithBiometrics()
                } label: {
                    Label("Login with Face ID", systemImage: "faceid")
                        .font(.title2).bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 40)
            }
        }
    }
}
