//
//  ConfigNotes.swift
//  GiorgiPilishvili_Homework26
//
//  Created by GIORGI PILISSHVILI on 26.08.22.
//

import UIKit

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.identifier, for: indexPath) as? NoteCell
        guard let cell = cell else { return UITableViewCell() }
        
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        cell.selectionStyle = .none
        cell.delegate = self
        
        let currentNote = arrayOfNotes[indexPath.row]
        cell.configure(with: currentNote)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NoteViewController") as? NoteViewController
        guard let vc = vc else { return }
        
        let currentNote = arrayOfNotes[indexPath.row]
        vc.note = currentNote
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alert = UIAlertController(title: "Delete Note?", message: nil, preferredStyle: .alert)
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
            let actionYes = UIAlertAction(title: "Yes", style: .default) { alert in
                
                let currentNote = self.arrayOfNotes[indexPath.row]
                
                do {
                    self.managedContext.delete(currentNote)
                    try self.managedContext.save()
                    NotificationCenter.default.post(name: Notification.Name("favoriteStateChanged"), object: nil)
                    self.loadNotes()
                } catch {
                    print(error)
                }
                
            }
            
            alert.addAction(actionCancel)
            alert.addAction(actionYes)
            
            present(alert, animated: true)
            
        }
    }
    
}
