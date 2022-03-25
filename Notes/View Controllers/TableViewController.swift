//
//  TableViewController.swift
//  Notes
//
//  Created by Иван Осипов on 23/3/22.
//

import UIKit

class TableViewController: UITableViewController {
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let newNoteVC = segue.destination as? NewNoteViewController else { return }
//        newNoteVC.delegate = self
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Base.shared.notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = Base.shared.notes[indexPath.row].text
        
        return cell
    }    
}


