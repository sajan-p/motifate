import SwiftUI

struct PomodoroView: View {
    
    @State var workTime = 10
    @State var workDisplay = "00 : 00 : 00"
    @State var breakDisplay = "00 : 00 : 00"
    @State var breakTime = 5
    @State var onWork = true
    @State var isPlaying = false
    
    @State var workHour = String()
    @State var workMinute = String()
    @State var workSecond = String()
    
    @State var breakHour = String()
    @State var breakMinute = String()
    @State var breakSecond = String()
    @State var bugBreakSecond = String()
    
    @State var currentWorkHour = String()
    @State var currentWorkMinute = String()
    @State var currentWorkSecond = String()
    
    @State var currentBreakHour = String()
    @State var currentBreakMinute = String()
    @State var currentBreakSecond = String()
    
    @State var workFormatted = String()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            VStack {
                VStack (spacing: 10) {
                    timerInput(timerName: "Work Timer", trackedHour: $workHour, trackedMinute: $workMinute, trackedSecond: $workSecond)
                    
                    timerInput(timerName: "Break Timer", trackedHour: $breakHour, trackedMinute: $breakMinute, trackedSecond: $breakSecond)
                }.padding(.bottom,10)
                
                
                Button {
                    applyButtonClicked()
                } label: {
                    Text("Apply").padding(.horizontal, 125.0).padding(.vertical, 15.0).background(Color(UIColor(named: "main-color-trans")!))
                        .foregroundColor(.blue)
                        .font(.system(size: 25, weight: .medium, design: .default)).cornerRadius(30)
                }
            }.padding(30)
            
            
            VStack {
                Text(onWork ? "Currently Doing Work" : "Currently on Break").foregroundColor(.blue).font(.system(size: 20, weight: .medium, design: .default))
                Text(onWork ? workDisplay : breakDisplay)
                    .onReceive(timer) {_ in
                        onRecieved()
                    }
                    .font(.system(size: 70, weight: .medium, design: .default))
                    .foregroundColor(.blue).padding(.bottom, -10)
                
                VStack (spacing: 30) {
                    HStack(spacing: 30) {
                        functionButton(buttonImageName: isPlaying ? "pause.fill" : "play.fill", buttonFunction: isPlaying ? pauseButtonPressed : playButtonPressed)
                        functionButton(buttonImageName: "stop.fill", buttonFunction: stopButtonPressed)
                    }
                    Image(systemName: onWork ? "book.closed.fill" : "gamecontroller.fill").resizable()                .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)
                        .foregroundColor(.blue)
                }
            }
        } .padding(.bottom, 60)
    }
    func formatTime (hours:Int, minutes:Int, seconds:Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        
        return timeString
    }
    
    func secondsToTime (seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600) , ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    func TimeToSeconds (hours:String, minutes:String, seconds:String) -> Int {
        return Int(hours)! * 3600 + Int(minutes)! * 60 + Int(seconds)!
    }
    
    func applyButtonClicked () {
        workTime = TimeToSeconds(hours: workHour, minutes: workMinute, seconds: workSecond)
        
        var (hour, minute, second) = secondsToTime(seconds: workTime)
        
        workDisplay = formatTime(hours: hour, minutes: minute, seconds: second)
        
        bugBreakSecond = String(Int(breakSecond )! + 1)
        
        breakTime = TimeToSeconds(hours: breakHour, minutes: breakMinute, seconds: bugBreakSecond)
        
        (hour, minute, second) = secondsToTime(seconds: breakTime)
        
        breakDisplay = formatTime(hours: hour, minutes: minute, seconds: second)
        
        onWork = true
        isPlaying = false
    }
    
    func onRecieved() {
        if isPlaying {
            if onWork && workTime > 0 {
                workTime -= 1
                
                let (hour, minute, second) = secondsToTime(seconds: workTime)
                
                workDisplay = formatTime(hours: hour, minutes: minute, seconds: second)
                
                
            } else if onWork && workTime <= 0 {
                
                workTime = TimeToSeconds(hours: workHour, minutes: workMinute, seconds: workSecond)
                
                let (hour, minute, second) = secondsToTime(seconds: breakTime)
                
                breakDisplay = formatTime(hours: hour, minutes: minute, seconds: second)
                
                onWork = false
                
            }
            
            if !onWork && breakTime > 0 {
                breakTime -= 1
                
                let (hour, minute, second) = secondsToTime(seconds: breakTime)
                
                breakDisplay = formatTime(hours: hour, minutes: minute, seconds: second)
                
            } else if !onWork && breakTime <= 0 {
                breakTime = TimeToSeconds(hours: breakHour, minutes: breakMinute, seconds: bugBreakSecond)
                
                let (hour, minute, second) = secondsToTime(seconds: workTime)
                
                workDisplay = formatTime(hours: hour, minutes: minute, seconds: second)
                
                onWork = true
            }
        }
    }
    
    func playButtonPressed() {
        isPlaying = true
    }
    
    func pauseButtonPressed() {
        isPlaying = false
    }
    
    func stopButtonPressed() {
        isPlaying = false
        onWork = true
        workTime = TimeToSeconds(hours: workHour, minutes: workMinute, seconds: workSecond)
        let (hour, minute, second) = secondsToTime(seconds: workTime)
        
        workDisplay = formatTime(hours: hour, minutes: minute, seconds: second)
        breakTime = TimeToSeconds(hours: breakHour, minutes: breakMinute, seconds: bugBreakSecond)
    }
    
}


struct PomodoroContentView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroView()
    }
}


struct inputItem: View {
    let trackedVar: Binding<String>
    let placeholder: String
    
    var body: some View {
        TextField(text: trackedVar) {
            Text(placeholder)
        }.background(Color(UIColor(named: "main-color-trans")!))
            .foregroundColor(.blue)
            .font(.system(size: 25, weight: .medium, design: .default))
    }
}

struct timerInput : View {
    let timerName: String
    let trackedHour: Binding<String>
    let trackedMinute: Binding<String>
    let trackedSecond: Binding<String>
    
    var body: some View {
        Text(timerName).foregroundColor(.blue)
            .font(.system(size: 30, weight: .medium, design: .default))
            .padding(.bottom, 30.0)
        HStack {
            inputItem(trackedVar: trackedHour, placeholder: "Hours")
            Text(":")
            inputItem(trackedVar: trackedMinute, placeholder: "Minutes")
            Text(":")
            inputItem(trackedVar: trackedSecond, placeholder: "Seconds")
        }.padding(.top, -30.0)
            .padding(.bottom, 20)
    }
}

struct functionButton : View {
    let buttonImageName: String
    let buttonFunction: () -> ()
    
    var body: some View {
        Button(action: buttonFunction) {
            Image(systemName: buttonImageName)
        }
        .foregroundColor(.blue)
        .font(.system(size: 25, weight: .medium, design: .default))
        .padding(.horizontal, 15.0)
        .padding(.vertical, 8.0)
        .background(Color(UIColor(named: "main-color-trans")!))
        .cornerRadius(30)
        
    }
}


//Button("Play") {
//    isPlaying = true
//}
//.padding(.horizontal, 15.0)
//.padding(.vertical, 8.0)
//.background(Color(UIColor(named: "main-color-trans")!))
//    .foregroundColor(.blue)
//    .font(.system(size: 25, weight: .medium, design: .default))
//    .cornerRadius(30)
