import SwiftUI

struct ContentView: View {
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
                                            Text("Resources view goes here")
                                .customNavigationTitle("Resources")
                                .customNavigationSubtitle("Resources information goes here")
                            
                            ) {
                                iconButton(icon: "desktopcomputer", name: "Resources")
                            }
                            
                            CustomNavLink(destination:
                                            PomodoroView()
                                .customNavigationTitle("Pomodoro")
                                .customNavigationSubtitle("Manage your time by setting custom timers")
                            
                            ) {
                                iconButton(icon: "timer", name: "Pomodoro")
                            }
                        }
                        
                        VStack (spacing: 50) {
                            CustomNavLink(destination:
                                            Text("Journal view goes here")
                                .customNavigationTitle("Journal")
                                .customNavigationSubtitle("Journal information goes here")
                            
                            ) {
                                iconButton(icon: "book.closed.fill", name: "Journal")
                            }
                            
                            CustomNavLink(destination:
                                            Todo()
                                .customNavigationTitle("To-Do")
                                .customNavigationSubtitle("Manage your life by easily creating and deleting tasks")
                            
                            ) {
                                iconButton(icon: "doc.on.clipboard.fill", name: "To-Do")
                            }
                        }
                    }.padding(.bottom, 80)
                        .padding(.top, 40)
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

