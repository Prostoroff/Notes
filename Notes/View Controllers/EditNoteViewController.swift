//
//  EditNoteViewController.swift
//  Notes
//
//  Created by Иван Осипов on 26/3/22.
//

import UIKit

class EditNoteViewController: UIViewController {
    @IBOutlet var textView: UITextView!
    
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Text View
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = .gray
        textView.keyboardType = .default
        textView.returnKeyType = .continue
        textView.autocapitalizationType = .sentences
        textView.text = Base.shared.notes[index].text
    }
    
    @IBAction func doneButtonAction(_ sender: UIBarButtonItem) {
        textView.resignFirstResponder()
        Base.shared.notes[index].text = textView.text
        navigationController?.popViewController(animated: true)
    }
}
