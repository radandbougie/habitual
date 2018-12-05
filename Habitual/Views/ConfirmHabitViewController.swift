//
//  ConfirmHabitViewController.swift
//  Habitual
//
//  Created by Kandy M on 12/4/18.
//  Copyright © 2018 Kandy M. All rights reserved.
//

import UIKit

class ConfirmHabitViewController: UIViewController {
    
    var habitImage: Habit.Images!
    
    @IBOutlet weak var habitImageView: UIImageView!
    
    @IBOutlet weak var habitNameInputField: UITextField!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
    
    private func updateUI() {
        title = "New Habit"
        habitImageView.image = habitImage.image
    }
    
    @IBAction func createHabitButtonPressed(_ sender: Any) {
        var persisenceLayer = PersistenceLayer()
        guard let habitText = habitNameInputField.text else {return}
        persisenceLayer.creatingNewHabit(name: habitText, image: habitImage)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

