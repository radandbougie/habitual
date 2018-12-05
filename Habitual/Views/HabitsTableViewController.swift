//
//  HabitsTableViewController.swift
//  Habitual
//
//  Created by Kandy M on 12/4/18.
//  Copyright © 2018 Kandy M. All rights reserved.
//

import UIKit

class HabitsTableViewController: UITableViewController {
    private var persistance = PersistenceLayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavbar()
        
        // Register the custom tableViewCell class to the TableView to use
        tableView.register(
            HabitTableViewCell.nib,
            forCellReuseIdentifier: HabitTableViewCell.indentifier
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        persistance.setNeedsToReloadhabits()
        tableView.reloadData()
    }
    
    // Return the number of the rows for the given section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persistance.habits.count
    }
    
    // Return the UITableViewCell for the given indexPath
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitTableViewCell.indentifier, for: indexPath) as! HabitTableViewCell
        let habit = persistance.habits[indexPath.row]
        cell.configure(habit)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let habitToDelete = persistance.habits[indexPath.row]
            let habitIndexToDelete = indexPath.row
            let deleteAlert = UIAlertController(habitTitle: habitToDelete.title) {
                self.persistance.delete(habitIndexToDelete)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
            self.present(deleteAlert, animated: true)
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = HabitDetailViewController()
        detailVC.habit = persistance.habits[indexPath.row]
        detailVC.habitIndex = indexPath.row
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        persistance.swapHabits(habitIndex: sourceIndexPath.row, destinationIndex: destinationIndexPath.row)
    }
}

extension HabitsTableViewController{
    func setupNavbar() {
        title = "Habitual"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAddHabit))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    @objc func pressAddHabit(){
        let addHabitVC = AddhabitViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: addHabitVC)
        present(navigationController, animated: true, completion: nil)
    }
}

extension UIAlertController {
    convenience init(habitTitle: String, comfirmHandler: @escaping () -> Void) {
        self.init(title: "Delete Habit", message: "Are you sure you want to delete \(habitTitle)?", preferredStyle: .actionSheet)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { _ in
            comfirmHandler()
        }
        self.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        self.addAction(cancelAction)
    }
}
