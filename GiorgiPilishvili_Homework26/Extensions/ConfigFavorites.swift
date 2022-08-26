//
//  ConfigFavorites.swift
//  GiorgiPilishvili_Homework26
//
//  Created by GIORGI PILISSHVILI on 26.08.22.
//

import UIKit

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.identifier, for: indexPath) as? FavoriteCell
        guard let cell = cell else { return UITableViewCell() }
        
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        cell.selectionStyle = .none
        
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
            
            let alert = UIAlertController(title: "Remove from favorites?", message: nil, preferredStyle: .alert)
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
            let actionYes = UIAlertAction(title: "Yes", style: .default) { alert in
                
                let currentNote = self.arrayOfNotes[indexPath.row]
                currentNote.isFavorite = false
                
                do {
                    try self.managedContext.save()
                    NotificationCenter.default.post(name: Notification.Name("newNoteCreated"), object: nil)
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
