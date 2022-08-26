//
//  FavoriteCell.swift
//  GiorgiPilishvili_Homework26
//
//  Created by GIORGI PILISSHVILI on 26.08.22.
//

import UIKit

class FavoriteCell: UITableViewCell {

    // MARK: - Variables
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    static let identifier = "FavoriteCell"
    
    let cornerRadius: CGFloat = 35
    
    // MARK: - Lifecycle methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureDesign()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: - Functions
    
    func configureDesign() {
        backgroundColor = UIColor.clear
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
    }
    
    func configure(with note: Note) {
        
        labelTitle.text = note.title
        labelContent.text = note.content
        
        let formatter = DateFormatter()

        let isToday = Calendar.current.isDateInToday(note.date ?? Date.now)
        
        if isToday {
            formatter.dateStyle = .none
            formatter.timeStyle = .short
        } else {
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
        }
        
        labelDate.text = formatter.string(from: note.date!)
        
    }

}
