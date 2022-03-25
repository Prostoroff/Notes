//
//  Models.swift
//  Notes
//
//  Created by Иван Осипов on 24/3/22.
//

import Foundation

class Base {
    let defaults = UserDefaults.standard
    static let shared = Base()
    
    struct Note: Codable {
        let text: String
    }
    
    var notes: [Note] {
        get {
            if let data = defaults.value(forKey: "notes") as? Data {
                return try! PropertyListDecoder().decode([Note].self, from: data)
            } else {
                return [Note]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue){
                defaults.set(data, forKey: "notes")
            }
        }
    }
    
    func saveNote(text: String) {
        let note = Note(text: text)
        notes.insert(note, at: 0)
    }
}

