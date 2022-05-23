//
//  TableViewController.swift
//  Notes
//
//  Created by Иван Осипов on 23/3/22.
//

import UIKit
import CoreData

class NoteListViewController: UITableViewController {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let cellID = "cell"
    private var notes: [Note] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        setupNavigationBar()
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        let editNoteVC = segue.destination as? EditNoteViewController
    //        guard let indexPath = tableView.indexPathForSelectedRow else { return }
    //        editNoteVC?.index = indexPath.row
    //    }
    
    private func setupNavigationBar() {
        title = "Заметки"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBarAppearance.backgroundColor = UIColor(red: 50/255,
                                                          green: 72/255,
                                                          blue: 168/255,
                                                          alpha: 200/255
        )
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewNote))
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func addNewNote() {
        showAlert(title: "Новая заметка", message: "Нажмите сохранить, что бы добавить новую заметку.")
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let saveButton = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let note = alert.textFields?.first?.text else { return }
            self.save(note)
        }
        let cancelButton = UIAlertAction(title: "Отменить", style: .destructive)
        
        alert.addTextField()
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }
    
    private func save(_ noteName: String) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Note", in: context) else { return }
        guard let note = NSManagedObject(entity: entityDescription, insertInto: context) as? Note else { return }
        
        note.name = noteName
        notes.append(note)
        
        let cellIndex = IndexPath(row: notes.count - 1, section: 0)
        tableView.insertRows(at: [cellIndex], with: .none)
        
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        dismiss(animated: true)
    }
    
    private func fetchData() {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        do {
            notes = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}

// MARK: Table View Data Source

extension NoteListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { [self] (_, _, completionHandler) in
            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

