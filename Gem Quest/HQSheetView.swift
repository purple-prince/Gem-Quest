import SwiftUI

let mdata = [
    "Wood" : 120
]

struct HQSheetView: View {
    
    var body: some View {
        VStack {
            ForEach(Array(mdata.keys), id: \.self) { resource in
                HStack {
                    Text("\(resource): \(mdata[resource]!)")
                    
                    Spacer()
                    
                    Text("Sell:")
                    
                    Button(action: {}) {
                        Text("10%")
                            .font(.body)
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 4)
                                        .foregroundStyle(Color(red: 0.1, green: 0.1, blue: 0.1))
                                    
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color(red: 0.3, green: 0.3, blue: 0.3))
                                }
                                
                            )
                    }
                    
                    Button(action: {}) {
                        Text("50%")
                            .font(.body)
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 4)
                                        .foregroundStyle(Color(red: 0.1, green: 0.1, blue: 0.1))
                                    
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color(red: 0.3, green: 0.3, blue: 0.3))
                                }
                                
                            )
                    }
                    
                    Button(action: {}) {
                        Text("100%")
                            .font(.body)
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(
                                ZStack {
                                    RoundedRectangle(cornerRadius: 4)
                                        .foregroundStyle(Color(red: 0.1, green: 0.1, blue: 0.1))
                                    
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color(red: 0.3, green: 0.3, blue: 0.3))
                                }
                                
                            )
                    }
                }
                .font(.title3)
                
            }
        }
        .padding()
    }
    
}

#Preview {
    HQSheetView()
}
