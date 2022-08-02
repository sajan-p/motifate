import SwiftUI
import Combine

struct Todo: View {
    
    @ObservedObject var taskStore = TaskStore()
    @State var newToDo : String = ""
    @State var newDate : Date = Date.now
    
    var inputText: some View {
        HStack {
            VStack {
                TextField("Enter Task", text: self.$newToDo).font(.system(size: 30))
                DatePicker("", selection: $newDate).padding(.trailing, 90)
            }
            Button {
                addNewToDo()
            } label: {
                Text("Add New")
                    .font(.body)
                    .fontWeight(.medium)
                    .padding(.all, 15.0)
                    .background(Color(UIColor(named: "main-color-trans")!))
                    .foregroundColor(.blue)
                    .cornerRadius(30)
            }.padding(.trailing, 10)
        }
    }
    
    
    func addNewToDo() {
        if self.newToDo.count > 0 {
            taskStore.tasks.append(Task(id: String(taskStore.tasks.count + 1), toDoItem: newToDo, toDoDueDate: newDate))
            taskStore.tasks = taskStore.tasks.sorted(by: { lhs, rhs in
                lhs.toDoDueDate < rhs.toDoDueDate
            })
            
            self.newToDo = ""
        }
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                inputText.padding()
                List {
                    ForEach(self.taskStore.tasks) {
                        task in
                        
                        VStack (alignment: .leading) {
                            Text(task.toDoItem)
                                .font(.system(size: 20))
                                
                            Text("\(task.toDoDueDate.formatted())")
                                .font(.system(size: 15))
                        }
                        
                    }.onMove(perform: self.move)
                        .onDelete(perform: self.delete)
                }
            }.navigationBarHidden(true)
        }
    }
    
    func move (from source: IndexSet, to destination : Int) {
        taskStore.tasks.move(fromOffsets: source, toOffset: destination)
    }
    
    func delete (at offsets: IndexSet) {
        taskStore.tasks.remove(atOffsets: offsets)
    }
    
    
}

struct Todo_Previews: PreviewProvider {
    static var previews: some View {
        Todo()
    }
}
