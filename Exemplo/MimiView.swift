import SwiftUI

struct MimiView: View {
    // MARK: - State
    @State private var showCookie: Bool = false // Controls if the cookie is visible
    @State private var cookieOffset: CGFloat = 0 // Controls the cookie animation
    @State private var cookieEaten: Bool = false // Controls if the cookie was "eaten"
    @State private var observer: NSObjectProtocol? // Holds the notification observer

    var body: some View {
        VStack {
            Spacer()
            // MARK: - Mimi mascot (purple square)
            Rectangle()
                .fill(Color.purple)
                .frame(width: 120, height: 120)
                .overlay(Text("Mimi").foregroundColor(.white).bold())
                .padding(.bottom, 40)
            Spacer()
            ZStack {
                if showCookie && !cookieEaten {
                    // MARK: - Cookie (orange square)
                    Rectangle()
                        .fill(Color.orange)
                        .frame(width: 60, height: 60)
                        .overlay(Text("🍪").font(.largeTitle))
                        .offset(y: cookieOffset)
                        .onTapGesture {
                            // Animate the cookie moving up to Mimi
                            withAnimation(.easeIn(duration: 0.7)) {
                                cookieOffset = -180
                            }
                            // After animation, hide the cookie
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                cookieEaten = true
                            }
                        }
                }
            }
            .frame(height: 80)
            Spacer()
            // MARK: - Button to simulate adding a new dream (for demo)
            Button {
                showCookie = true
                cookieEaten = false
                cookieOffset = 0
            } label: {
                Text("Simulate new dream (show cookie)")
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(10)
            }
            .padding(.bottom, 40)
        }
        .navigationTitle("Mimi")
        .onAppear {
            observer = NotificationCenter.default.addObserver(forName: .dreamAdded, object: nil, queue: .main) { _ in
                showCookie = true
                cookieEaten = false
                cookieOffset = 0
            }
        }
        .onDisappear {
            if let observer = observer {
                NotificationCenter.default.removeObserver(observer)
            }
        }
    }
}

extension Notification.Name {
    static let dreamAdded = Notification.Name("dreamAdded")
}

#Preview {
    MimiView()
}
