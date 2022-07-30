import SwiftUI
import Combine

struct Todo: View {
    
    @ObservedObject var taskStore = TaskStore()
    @State var newToDo : String = ""
    
    var inputText: some View {
        HStack {
            TextField("Enter Task", text: self.$newToDo)
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
            }
        }
    }
    
    
    func addNewToDo() {
        
        if self.newToDo.count > 0 {
            taskStore.tasks.append(Task(id: String(taskStore.tasks.count + 1), toDoItem: newToDo))
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
                        Text(task.toDoItem)
                        
                        
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
