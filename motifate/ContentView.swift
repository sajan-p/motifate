import SwiftUI

struct ContentView: View {
    
    
    var menuQuotes = MenuQuotes()
    @State var randomQuote = String()
    
    var body: some View {
        CustomNavView {
            ZStack {
                Color.white.ignoresSafeArea()
                VStack {
                    VStack {
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                    }.frame(width: 250, height: 250, alignment: .top)
                    
                    
                    HStack (spacing: 50) {
                        VStack (spacing: 50) {
                            CustomNavLink(destination:
                                            Text("Resources not included in the MVP")
                                .customNavBarItems(title: "Resources", subtitle: "Search for reliable resources and add your own to the mix")
                                          
                                          
                            ) {
                                iconButton(icon: "desktopcomputer", name: "Resources")
                            }
                            
                            CustomNavLink(destination:
                                            PomodoroView()
                                .customNavBarItems(title: "Pomodoro", subtitle: "Manage your time by setting custom timers")
                                          
                            ) {
                                iconButton(icon: "timer", name: "Pomodoro")
                            }
                        }
                        
                        VStack (spacing: 50) {
                            CustomNavLink(destination:
                                            Text("Journal not inluded in the MVP")
                                .customNavBarItems(title: "Journal", subtitle: "Write about your day or write about the prompts below")
                            ) {
                                iconButton(icon: "book.fill", name: "Journal")
                            }
                            
                            CustomNavLink(destination:
                                            Todo()
                                .customNavBarItems(title: "To-Do", subtitle: "Manage your life by easily creating and deleting tasks")
                                          
                            ) {
                                iconButton(icon: "doc.on.clipboard.fill", name: "To-Do")
                            }
                        }
                    }.padding(.bottom, 30)
                        .padding(.top, 40)
                    
                    Text(randomQuote)
                        .onAppear() {
                            randomQuote = menuQuotes.getRandomQuote()
                        }
                        .foregroundColor(.blue)
                        .font(.system(size: 16, weight: .medium, design: .default))
                        .frame(width: 400, height: 120, alignment: .center)
                        .multilineTextAlignment(.center)
                }
            }.customNavBarItems(title: "Good morning, Sajan!", subtitle: nil, backButtonHidden: true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct iconButton: View {
    
    let icon:String
    let name:String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(name).foregroundColor(.blue)
                .font(.system(size: 20, weight: .bold, design: .default))
        }.frame(width: 110, height: 110)
            .padding(20.0)
            .background(Color(UIColor(named: "main-color-trans")!))
            .cornerRadius(30)
    }
}

