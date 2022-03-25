//
//  NewNoteViewController.swift
//  Notes
//
//  Created by Иван Осипов on 24/3/22.
//

import UIKit

class NewNoteViewController: UIViewController {
    @IBOutlet var textView: UITextView!
    @IBOutlet var navigationBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Text View
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = .gray
        textView.keyboardType = .default
        textView.returnKeyType = .continue
        textView.autocapitalizationType = .sentences
        
    }
    @IBAction func doneButtonAction(_ sender: UIBarButtonItem) {
        textView.resignFirstResponder()
        Base.shared.saveNote(text: textView.text)

        
        navigationController?.popViewController(animated: true)
    }
    
}
