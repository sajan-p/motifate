import SwiftUI

struct PomodoroView: View {
    
    @State var workTime = 10
    @State var breakTime = 5
    @State var onWork = true
    @State var isPlaying = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        VStack {
            VStack {
                Text(onWork ? "Currently on Work" : "Currently on Break")
                Text(onWork ? String(workTime):String(breakTime))
                    .onReceive(timer) {_ in
                        if isPlaying {
                            if onWork && workTime > 0 {
                                workTime -= 1
                            } else if onWork && workTime <= 0 {
                                onWork = false
                                workTime = 10
                            }
                            
                            if !onWork && breakTime > 0 {
                                breakTime -= 1
                            } else if !onWork && breakTime <= 0 {
                                onWork = true
                                breakTime = 5
                            }
                        }
                    }
                    .font(.system(size: 50, weight: .medium, design: .default))
            }
            
            HStack(spacing: 30) {
                Button("Play") {
                    isPlaying = true
                }
                Button("Pause") {
                    isPlaying = false
                }
                Button("Stop") {
                    isPlaying = false
                    workTime = 10
                    breakTime = 5
                    onWork = true
                }
            }
        }
    }
    
    
    struct PomodoroContentView_Previews: PreviewProvider {
        static var previews: some View {
            PomodoroView()
        }
    }
}

