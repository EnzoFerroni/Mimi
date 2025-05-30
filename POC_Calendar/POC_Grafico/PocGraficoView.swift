import SwiftUI
import Charts

struct aaa: View {
    var body: some View {
        VStack(){
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 50 , height: 50)
                .padding()
            

            ZStack(){
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 350 , height: 150)
                    .foregroundColor(.pink)
                    .padding(.top , 250)
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 300 , height: 300)
                    .foregroundColor(.purple)
            }
        }
    }
}

struct aaa_Previews: PreviewProvider {
    static var previews: some View {
        aaa()
    }
}

