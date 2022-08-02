import Foundation
import SwiftUI
import Combine

struct Task : Identifiable {
    var id = String()
    var toDoItem = String()
    var toDoDueDate = Date()
}

class TaskStore : ObservableObject {
    @Published var tasks = [Task]()
}
