//
//  ContentView.swift
//  POC_Calendar
//
//  Created by Aluno Mack on 28/05/25.
//

import SwiftUI

struct ContentView: View {
    @State private var date = Date()
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0)
                .ignoresSafeArea()
            VStack{
                HStack{
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 50 , height: 50)

                        .colorInvert()
                    Spacer()
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 60 , height: 60)
                        .colorInvert()
                }
                .padding()
                DatePicker(
                    "Start Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .border(Color.black)
                .padding()
                .colorInvert()
                HStack{
                    Image(systemName: "chart.pie.fill")
                        .resizable()
                        .frame(width: 150 , height: 150)
                        .foregroundStyle(Color.white)
                        .padding()
                    Text("Key")
                        .foregroundStyle(Color.white)
                }
            }
        }
    }
}

//#Preview {
//    ContentView()
//}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
