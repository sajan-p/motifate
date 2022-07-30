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
    
    @State var currentWorkHour = String()
    @State var currentWorkMinute = String()
    @State var currentWorkSecond = String()
    
    @State var currentBreakHour = String()
    @State var currentBreakMinute = String()
    @State var currentBreakSecond = String()
    
    @State var workFormatted = String()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
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
    
    var body: some View {
        
        VStack {
            VStack (spacing: 40) {
                Text("Work Timer").foregroundColor(.blue)
                    .font(.system(size: 30, weight: .medium, design: .default))
                HStack {
                    TextField(text: $workHour) {
                        Text("Hour")
                    }.background(Color(UIColor(named: "main-color-trans")!))
                        .foregroundColor(.blue)
                        .font(.system(size: 25, weight: .medium, design: .default))
                    Text(":")
                    TextField(text: $workMinute) {
                        Text("Minute")
                    }.background(Color(UIColor(named: "main-color-trans")!))
                        .foregroundColor(.blue)
                        .font(.system(size: 25, weight: .medium, design: .default))
                    Text(":")
                    TextField(text: $workSecond) {
                        Text("Second")
                    }.background(Color(UIColor(named: "main-color-trans")!))
                        .foregroundColor(.blue)
                        .font(.system(size: 25, weight: .medium, design: .default))
                }.padding(.top, -30.0)
                Text("Break Timer").foregroundColor(.blue)
                    .font(.system(size: 30, weight: .medium, design: .default))
                HStack {
                    TextField(text: $breakHour) {
                        Text("Hour")
                    }.background(Color(UIColor(named: "main-color-trans")!))
                        .foregroundColor(.blue)
                        .font(.system(size: 25, weight: .medium, design: .default))
                    Text(":")
                    TextField(text: $breakMinute) {
                        Text("Minute")
                    }.background(Color(UIColor(named: "main-color-trans")!))
                        .foregroundColor(.blue)
                        .font(.system(size: 25, weight: .medium, design: .default))
                    Text(":")
                    TextField(text: $breakSecond) {
                        Text("Second")
                    }.background(Color(UIColor(named: "main-color-trans")!))
                        .foregroundColor(.blue)
                        .font(.system(size: 25, weight: .medium, design: .default))
                }.padding(.top, -30.0)
                
                Button {
                    workTime = TimeToSeconds(hours: workHour, minutes: workMinute, seconds: workSecond)
                   
                    var (hour, minute, second) = secondsToTime(seconds: workTime)
                    
                    workDisplay = formatTime(hours: hour, minutes: minute, seconds: second)
                    
                    breakTime = TimeToSeconds(hours: breakHour, minutes: breakMinute, seconds: breakSecond)
                    
                    (hour, minute, second) = secondsToTime(seconds: breakTime)
                    
                    breakDisplay = formatTime(hours: hour, minutes: minute, seconds: second)
                } label: {
                    Text("Apply").padding(.horizontal, 125.0).padding(.vertical, 15.0).background(Color(UIColor(named: "main-color-trans")!))
                        .foregroundColor(.blue)
                        .font(.system(size: 25, weight: .medium, design: .default)).cornerRadius(30)
                }
                .padding(.bottom, 350.0)
                
            }.padding(40)
            VStack {
                Text(onWork ? "Currently Doing Work" : "Currently on Break").foregroundColor(.blue).font(.system(size: 20, weight: .medium, design: .default))
                Text(onWork ? workDisplay : breakDisplay)
                    .onReceive(timer) {_ in
                        if isPlaying {
                            if onWork && workTime > 0 {
                                workTime -= 1
                                
                                let (hour, minute, second) = secondsToTime(seconds: workTime)
                                
                                workDisplay = formatTime(hours: hour, minutes: minute, seconds: second)
                                
                                
                            } else if onWork && workTime <= 0 {
                                onWork = false
                                
                                workTime = TimeToSeconds(hours: workHour, minutes: workMinute, seconds: workSecond)
                               
                                let (hour, minute, second) = secondsToTime(seconds: workTime)
                                
                                workDisplay = formatTime(hours: hour, minutes: minute, seconds: second)
                                
                            }
                            
                            if !onWork && breakTime > 0 {
                                breakTime -= 1
                                
                                let (hour, minute, second) = secondsToTime(seconds: breakTime)
                                
                                breakDisplay = formatTime(hours: hour, minutes: minute, seconds: second)
                                
                            } else if !onWork && breakTime <= 0 {
                                onWork = true
                                
                                breakTime = TimeToSeconds(hours: breakHour, minutes: breakMinute, seconds: breakSecond)
                               
                                let (hour, minute, second) = secondsToTime(seconds: breakTime)
                                
                                workDisplay = formatTime(hours: hour, minutes: minute, seconds: second)
                            }
                        }
                    }
                    .font(.system(size: 70, weight: .medium, design: .default))
                    .foregroundColor(.blue)
            }.padding(.top, -300.0)
            
            HStack(spacing: 30) {
                Button("Play") {
                    isPlaying = true
                }
                .padding(.horizontal, 15.0)
                .padding(.vertical, 8.0)
                .background(Color(UIColor(named: "main-color-trans")!))
                    .foregroundColor(.blue)
                    .font(.system(size: 25, weight: .medium, design: .default))
                    .cornerRadius(30)
                
                Button("Pause") {
                    isPlaying = false
                }
                .padding(.horizontal, 15.0)
                .padding(.vertical, 8.0)
                .background(Color(UIColor(named: "main-color-trans")!))
                    .foregroundColor(.blue)
                    .font(.system(size: 25, weight: .medium, design: .default))
                    .cornerRadius(30)
                Button("Stop") {
                    isPlaying = false
                    workTime = 10
                    breakTime = 5
                    onWork = true
                }
                .padding(.horizontal, 15.0)
                .padding(.vertical, 8.0)
                .background(Color(UIColor(named: "main-color-trans")!))
                    .foregroundColor(.blue)
                    .font(.system(size: 25, weight: .medium, design: .default))
                    .cornerRadius(30)
            }.padding(.top, -230.0)
        }
    }
    
    
    struct PomodoroContentView_Previews: PreviewProvider {
        static var previews: some View {
            PomodoroView()
        }
    }
}

