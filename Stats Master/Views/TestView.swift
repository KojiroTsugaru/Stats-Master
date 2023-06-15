import SwiftUI

struct TestView: View {
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 700, height: 350)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 5, y: 2)
                .overlay {
                    VStack(spacing: 0) {
//                        Rectangle()
//                            .frame(width: 50, height: 30)
//                            .foregroundColor(.white)
//                            .overlay {
//                                RoundedRectangle(cornerRadius: 1)
//                                    .stroke(Color("Color1"), lineWidth: 2)
//                                Text("2Q")
//                                    .font(.system(size: 15)).bold()
//                            }
                        HStack {
                            Spacer()
                            Image("logo2")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.black, lineWidth: 1))
                                .shadow(radius: 1)
                                .padding()
                            Text("40 - 49")
                                .font(.system(size: 35)).bold()
                            Image("logo2")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.black, lineWidth: 1))
                                .shadow(radius: 1)
                                .padding()
                            Spacer()
                        }
                        HStack() {
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("Team Foul 4")
                                Text("Timeout 3")
                            }.padding(.horizontal)
                        }
                        Spacer()
                        HStack{
                            VStack (alignment: .leading, spacing: 3){
                                HStack {
                                    Text("On-court")
                                        .frame(width: 130, alignment: .leading)
                                    Text("PTS")
                                        .frame(width: 50, alignment: .trailing)
                                    Text("FG%")
                                        .frame(width: 60, alignment: .trailing)
                                    Text("PF")
                                        .frame(width: 35, alignment: .trailing)
                                }.bold()
                                Divider()
                                ForEach(1..<6){ i in
                                    HStack{
                                        Text("#7 Kevin Durant")
                                            .frame(width: 130, alignment: .leading)
                                        Text("13")
                                            .frame(width: 50, alignment: .trailing)
                                        
                                        Text("63.1%")
                                            .frame(width: 60, alignment: .trailing)
                                        Text("2")
                                            .frame(width: 35, alignment: .trailing)
                                    }
                                }
                            }.frame(width: 330)
                            VStack (alignment: .leading, spacing: 3){
                                HStack {
                                    Text("Bench")
                                        .frame(width: 130, alignment: .leading)
                                    Text("PTS")
                                        .frame(width: 50, alignment: .trailing)
                                    Text("FG%")
                                        .frame(width: 60, alignment: .trailing)
                                    Text("PF")
                                        .frame(width: 35, alignment: .trailing)
                                }.bold()
                                Divider()
                                ForEach(1..<6){ i in
                                    HStack{
                                        Text("#7 Kevin Durant")
                                            .frame(width: 130, alignment: .leading)
                                        Text("13")
                                            .frame(width: 50, alignment: .trailing)
                                        
                                        Text("100.0%")
                                            .frame(width: 60, alignment: .trailing)
                                        Text("2")
                                            .frame(width: 35, alignment: .trailing)
                                    }
                                }
                            }.frame(width: 330)
                        }
                        Spacer()
                        
                        HStack {
                            Button {
                                // Add action to have a break inm the middle of the game
                            } label: {
                                RoundedRectangle(cornerRadius: 90)
                                    .stroke(Color(.systemGreen), lineWidth: 1.5)
                                    .shadow(radius: 1, x: 1, y: 1)
                                    .frame(width: 60, height: 30)
                                    .overlay(
                                        Text("Break")
                                            .font(.system(size: 15))
                                            .foregroundColor(.black)
                                    )
                                    .padding()
                            }
                            
                            Button {
                                // Add action to force to end the game
                                
                                
                            } label: {
                                RoundedRectangle(cornerRadius: 90)
                                    .stroke(Color(.systemRed), lineWidth: 1.5)
                                    .shadow(radius: 1, x: 1, y: 1)
                                    .frame(width: 60, height: 30)
                                    .overlay(
                                        Text("End")
                                            .font(.system(size: 15))
                                            .foregroundColor(.black)
                                    )
                                    .padding()
                            }
                        }
                    }
                }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
