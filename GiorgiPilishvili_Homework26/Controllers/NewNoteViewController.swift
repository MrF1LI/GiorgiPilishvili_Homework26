//
//  NoteViewController.swift
//  GiorgiPilishvili_Homework26
//
//  Created by GIORGI PILISSHVILI on 26.08.22.
//

import UIKit

class NewNoteViewController: UIViewController {
    
    // MARK: - Variables
    
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textViewContent: UITextView!
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "New Note"
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        guard let title = textFieldTitle.text, !title.isEmpty,
              let content = textViewContent.text, !content.isEmpty else {
            return
        }
        
        let note = Note(context: managedContext)
        note.id = UUID()
        note.title = title
        note.content = content
        note.date = Date.now
        
        do {
            try managedContext.save()
            NotificationCenter.default.post(name: Notification.Name("newNoteCreated"), object: nil)
        } catch {
            print(error)
        }
        
    }

}
