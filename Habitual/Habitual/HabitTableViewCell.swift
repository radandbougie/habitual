//
//  HabitTableViewCell.swift
//  Habitual
//
//  Created by Kandy M on 12/7/18.
//  Copyright © 2018 Kandy M. All rights reserved.
//

import UIKit

class HabitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var labelHabitTitle: UILabel!
    @IBOutlet weak var labelStreaks: UILabel!
    
    // Set the identifer for the custom cell
    static let indentifier = "habitCell"
    
    // Returning the xib file after instantiating it
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(_ habit: Habit){
        self.imageViewIcon.image = habit.selectedImage.image
        self.labelHabitTitle.text = habit.title
        self.labelStreaks.text = "Streak: \(habit.currentStreak)"
        
        if habit.hasCompletedForToday{
            self.accessoryType = .checkmark
        }else{
            self.accessoryType = .disclosureIndicator
        }
    }
}
