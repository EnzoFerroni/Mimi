//
//  ContentView.swift
//  MimiDreams
//
//  Created by Enzo Ferroni on 04/06/25.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Core Data persistence controller singleton
    let persistenceController = PersistenceController.shared
    @State var showCookie: Bool = false
    @State var cookieEaten: Bool = false
    @State var cookieOffset: CGFloat = 0


    // MARK: - Body
    var body: some View {
        TabView {
            MimiView(showCookie: $showCookie , cookieOffset: $cookieOffset, cookieEaten: $cookieEaten)
                .tabItem {
                    Image("mimi")
                    Text("Mimi")
                }
            CalendarView(showCookie: $showCookie , cookieEaten: $cookieEaten ,  cookieOffset: $cookieOffset)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Dreams")
                }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .toolbarBackground(Color("Background"), for: .tabBar)
        }
    }
}

#Preview {
    ContentView()
}
