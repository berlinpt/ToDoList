//
//  ToDo.swift
//  ToDoList
//
//  Created by Berlin Thomas on 2024-03-28.
//

import Foundation

struct ToDo: Equatable, Codable {
    //let id = UUID()
    let id: UUID
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    init(title: String, isComplete: Bool, dueDate: Date, notes: String? = nil) {
        self.id = UUID()
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
    }
    
    static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
        return lhs.id == rhs.id
    }
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("toDos").appendingPathExtension("plist")
    
    static func saveToDos(_ toDos: [ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(toDos)
        try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadToDos() -> [ToDo]? {
        guard let codedToDos = try? Data(contentsOf: archiveURL) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        
        return try? propertyListDecoder.decode([ToDo].self, from: codedToDos)
    }
    
    static func loadSampleToDos() -> [ToDo] {
        let toDo1 = ToDo(title: "To-Do One", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let toDo2 = ToDo(title: "To-Do Two", isComplete: false, dueDate: Date(), notes: "Notes 2")
        let toDo3 = ToDo(title: "To-Do Three", isComplete: false, dueDate: Date(), notes: "Notes 3")
        
        return [toDo1, toDo2, toDo3]
    }
    
    
}
