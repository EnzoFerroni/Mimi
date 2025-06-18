import SwiftUI

struct MimiView: View {
    @Binding public var showCookie: Bool// Controls if the cookie is visible
    @Binding public var cookieOffset: CGFloat// Controls the cookie animation
    @Binding public var cookieEaten: Bool // Controls if the cookie was "eaten"
    @State var mimiEating : String = "eating1"
    @State var onLimit : Bool = true
    @State var index: Int = 1
    private let totalFrames = 42 // Total frames in eating animation
    private let frameDuration = 0.05 // Duration of each animation frame in seconds
    private let cookieAnimationDuration = 1.3 // Duration of cookie movement animation
    private let cookieVerticalOffset: CGFloat = -200 // How high the cookie moves up
    private let cookieSize: CGFloat = 60 // Size of the cookie in points
    
    func timerMimi(){
        index = 1
        repeat{
            let timer = Timer.scheduledTimer(withTimeInterval: frameDuration, repeats: onLimit,){  (Timer) in
                
                mimiEating = "eating\(index)"
                if index < 42{
                    index += 1
                }
            }
        }while index >= 41
        onLimit = false
    }
    
    var body: some View {
        NavigationStack() {
            ZStack(){
                Color("Background")
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Image(mimiEating)
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 50)
                        .padding(.leading, 30)
                    Spacer()
                    ZStack {
                        if showCookie && !cookieEaten {
                            // MARK: - Cookie (orange square)
                            Rectangle()
                                .fill(Color.orange)
                                .frame(width: cookieSize, height: cookieSize)
                                .overlay(Image("Cookie").font(.largeTitle))
                                .offset(y: cookieOffset)
                                .onTapGesture {
                                    // Animate the cookie moving up to Mimi
                                    withAnimation(.easeIn(duration: cookieAnimationDuration)) {
                                        cookieOffset = cookieVerticalOffset
                                        timerMimi()
                                        
                                    }
                                    // After animation, hide the cookie
                                    DispatchQueue.main.asyncAfter(deadline: .now() + cookieAnimationDuration) {
                                        cookieEaten = true
                                        
                                    }
                                }
                        }
                    }
                    .frame(height: 80)
                    Spacer()
                    // MARK: - Button to simulate adding a new dream (for demo)
//                    Button {
//                        showCookie = true
//                        cookieEaten = false
//                        cookieOffset = 0
//                    } label: {
//                        Text("generate a cookie")
//                            .font(.system(size: 20 , weight: .bold))
//                            .padding()
//                            .background(Color.blue.opacity(0.2))
//                            .cornerRadius(10)
//                    }
//                    .padding(.bottom, 40)
                }
                .navigationTitle("Mimi")
            }
        }
    }
}

#Preview {
    MimiView(showCookie: .constant(false) , cookieOffset: .constant(0) , cookieEaten: .constant(false))
}
