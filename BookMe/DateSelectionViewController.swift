//
//  DateSelectionViewController.swift
//  BookMe
//
//  Created by Héctor Miranda García on 22/09/22.
//

import SwiftUI

struct DateSelectionViewController: View {
    var body: some View {
        Home()
    }
}

// ============================
class ChildHostingController: UIHostingController<DateSelectionViewController> {

    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: DateSelectionViewController())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
// ============================

struct DateSelectionViewController_Previews: PreviewProvider {
    static var previews: some View {
        DateSelectionViewController()
    }
}

struct Home : View {
    
    // https://www.youtube.com/watch?v=JXX9ZewWP-Y
    @State var x : CGFloat = 0
    @State var count : CGFloat = 0
    @State var screen = UIScreen.main.bounds.width - 120
    var body : some View{
        NavigationView{
            VStack{
                Spacer()
                HStack(spacing: 15){
                    ForEach(data){i in
                        CardView(data: i)
                            .offset(x: self.x)
                            .highPriorityGesture(DragGesture()
                                .onChanged({(value) in
                                    if value.translation.width > 0{
                                        self.x = value.location.x
                                        //self.x = 100
                                    }else{
                                        self.x = value.location.x - self.screen
                                    }
                                })
                                .onEnded({(value)in
                                    if value.translation.width > 0{
                                        if value.translation.width > ((screen) / 2) && Int(self.count) != self.getMid(){
                                            self.count += 1
                                            self.x = (screen + 15) * self.count
                                        }
                                        else {
                                            self.x = (screen + 15) * self.count
                                        }
                                        
                                    }
                                    else {
                                        if -value.translation.width > ((screen) / 2) && -Int(self.count) != self.getMid(){
                                            self.count -= 1
                                            
                                            self.x = (screen + 15) * self.count
                                        }
                                        else {
                                            self.x = (screen + 15) * self.count
                                        }
                                    }
                                })
                            )
                    }
                }
                
                Spacer()
                /*
                Button(action: {print("Lol")}){
                    Image("nextButtonSquare").renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))

                }.padding(.leading, 200)
                */
                
                NavigationLink(
                    destination: HourSelectionUIKitView(),
                    label: {
                        Image("nextButtonSquare").renderingMode(Image.TemplateRenderingMode?.init(Image.TemplateRenderingMode.original))
                    }
                )
                
            }
            .background(Color.black.opacity(1).edgesIgnoringSafeArea(.all))
            //.navigationBarTitle("Carousel List")
            .animation(.easeIn, value: x == 120)
            .navigationBarItems(leading:
                            Button(action: {
                                print("Edit button pressed...")
                            }) {
                                Image("closeXButtonWhite")
                            }
                        )

        }
    }
    
    func getMid()->Int{
        return data.count / 2
    }
}

struct CardView : View {
    
    var data : Card
    
    var body : some View{
        VStack(alignment: .leading, spacing: 0){
            Text(data.date)
                .font(.system(size: 50))
                .fontWeight(.bold)
                .padding(.vertical, 13)
                .padding(.leading)
                .frame(
                    minWidth: UIScreen.main.bounds.width - 120,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: 390,
                    alignment: .topLeading
                )
        }.background(Color.white)
        .cornerRadius(0)
        /*
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
         */
    }
}

struct Card : Identifiable {
    var id : Int
    var date : String
    var show : Bool
}

var data = [
    Card(id: 0, date: "TUESDAY 23TH AUGUST 2022", show: false),
    Card(id: 1, date: "TUESDAY 24TH AUGUST 2022", show: false),
    Card(id: 2, date: "TUESDAY 25TH AUGUST 2022", show: false),
    Card(id: 3, date: "TUESDAY 26TH AUGUST 2022", show: false),
    Card(id: 4, date: "TUESDAY 27TH AUGUST 2022", show: false)
]


struct HourSelectionUIKitView: UIViewControllerRepresentable{
    
    typealias UIViewControllerType = HourSelectionViewController
    
    func makeUIViewController(context: Context) -> HourSelectionViewController {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let viewController = sb.instantiateViewController(identifier: "HourSelectionViewController") as! HourSelectionViewController
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: HourSelectionViewController, context: Context) {
        
    }
    
    
    
}
