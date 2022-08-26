//
//  NotesViewController.swift
//  GiorgiPilishvili_Homework26
//
//  Created by GIORGI PILISSHVILI on 26.08.22.
//

import UIKit

class NotesViewController: UIViewController {
    
    // MARK: - Variables
    
    @IBOutlet weak var tableViewNotes: UITableView!
    @IBOutlet weak var labelNoNotes: UILabel!
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arrayOfNotes = [Note]()
    
    // MARK: Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTableView()
        loadNotes()
        listenToNewNote()
    }
    
    // MARK: - Functions
    
    func configureTableView() {
        tableViewNotes.delegate = self
        tableViewNotes.dataSource = self
        tableViewNotes.register(UINib(nibName: NoteCell.identifier, bundle: nil), forCellReuseIdentifier: NoteCell.identifier)
    }
    
    func loadNotes() {
        do {
            let notes = try managedContext.fetch(Note.fetchRequest())
            arrayOfNotes = notes
            tableViewNotes.reloadData()
            labelNoNotes.isHidden = !arrayOfNotes.isEmpty
        } catch {
            print(error)
        }
    }
    
    func listenToNewNote() {
        NotificationCenter.default.addObserver(self, selector: #selector(actionOnNewNote), name: Notification.Name("newNoteCreated"), object: nil)
    }
    
    // MARK: - Actions

    @IBAction func actionAddNote(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewNoteViewController")
        guard let vc = vc else { return }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func actionOnNewNote() {
        loadNotes()
    }
    
}

// MARK: - Extension for favorites

extension NotesViewController: NoteCellDelegate {
    
    func addToFavorites(cell: NoteCell) {
        let indexPath = tableViewNotes.indexPath(for: cell)
        guard let indexPath = indexPath else { return }
        
        let note = arrayOfNotes[indexPath.row]
        
        do {
            note.isFavorite = !note.isFavorite
            NotificationCenter.default.post(name: Notification.Name("favoriteStateChanged"), object: nil)
            try self.managedContext.save()
        } catch {
            print(error)
        }
        
        tableViewNotes.reloadRows(at: [indexPath], with: .none)
    }

}
