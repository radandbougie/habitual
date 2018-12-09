//
//  HabitImageCollectionViewCell.swift
//  Habitual
//
//  Created by Kandy M on 12/7/18.
//  Copyright © 2018 Kandy M. All rights reserved.
//

import UIKit

class HabitImageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "habitImageCell"
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    func setImage(image: UIImage) {
        self.habitImage.image = image
    }
    
    @IBOutlet weak var habitImage: UIImageView!
    
    
    
}

