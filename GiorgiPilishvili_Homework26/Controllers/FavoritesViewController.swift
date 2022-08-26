//
//  FavoritesViewController.swift
//  GiorgiPilishvili_Homework26
//
//  Created by GIORGI PILISSHVILI on 26.08.22.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - Variables
    
    @IBOutlet weak var tableViewNotes: UITableView!
    @IBOutlet weak var labelNoFavorites: UILabel!
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arrayOfNotes = [Note]()
    
    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTableView()
        loadNotes()
        listenToNotifications()
    }
    
    // MARK: - Functions
    
    func configureTableView() {
        tableViewNotes.delegate = self
        tableViewNotes.dataSource = self
        tableViewNotes.register(UINib(nibName: FavoriteCell.identifier, bundle: nil), forCellReuseIdentifier: FavoriteCell.identifier)
    }
    
    func loadNotes() {
        do {
            let notes = try managedContext.fetch(Note.fetchRequest())
            arrayOfNotes = notes.filter { $0.isFavorite }
            tableViewNotes.reloadData()
            labelNoFavorites.isHidden = !arrayOfNotes.isEmpty
            
        } catch {
            print(error)
        }
    
    }
    
    func listenToNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(actionOnNewNote), name: Notification.Name("newNoteCreated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(actionOnNewNote), name: Notification.Name("favoriteStateChanged"), object: nil)
    }
    
    // MARK: - Actions
    
    @objc func actionOnNewNote() {
        loadNotes()
    }

}
