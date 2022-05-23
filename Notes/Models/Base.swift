//
//  Models.swift
//  Notes
//
//  Created by Иван Осипов on 24/3/22.
//

//import Foundation
//
//class Base {
//    let defaults = UserDefaults.standard
//    static let shared = Base()
//    
//    struct Note: Codable {
//        var text: String
//    }
//    
//    var notes: [Note] {
//        get {
//            if let data = defaults.value(forKey: "notes") as? Data {
//                return try! PropertyListDecoder().decode([Note].self, from: data)
//            } else {
//                return [Note(text: "Первая заметка. Что бы удалить, сделайте свайп вправо")]
//            }
//        }
//        set {
//            if let data = try? PropertyListEncoder().encode(newValue){
//                defaults.set(data, forKey: "notes")
//            }
//        }
//    }
//    
//    func saveNote(text: String) {
//        let note = Note(text: text)
//        if !note.text.isEmpty {
//            notes.insert(note, at: 0)
//        }
//    }
//}

