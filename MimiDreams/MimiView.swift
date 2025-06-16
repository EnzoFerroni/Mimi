import SwiftUI

struct MimiView: View {
    @State private var showCookie: Bool = false // Controls if the cookie is visible
    @State private var cookieOffset: CGFloat = 0 // Controls the cookie animation
    @State private var cookieEaten: Bool = false // Controls if the cookie was "eaten"
    
    var body: some View {
        NavigationStack() {
            ZStack(){
                Color("Background")
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Image("Mimi")
                        .scaledToFit()
                        .padding(.bottom, 50)
                        .padding(.leading, 10)
                    Spacer()
                    ZStack {
                        if showCookie && !cookieEaten {
                            // MARK: - Cookie (orange square)
                            Rectangle()
                                .fill(Color.orange)
                                .frame(width: 60, height: 60)
                                .overlay(Image("Cookie").font(.largeTitle))
                                .offset(y: cookieOffset)
                                .onTapGesture {
                                    // Animate the cookie moving up to Mimi
                                    withAnimation(.easeIn(duration: 0.7)) {
                                        cookieOffset = -170
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
                        Text("generate a cookie")
                            .font(.system(size: 20 , weight: .bold))
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 40)
                }
                .navigationTitle("Mimi")
            }
        }
    }
}

#Preview {
    MimiView()
}
