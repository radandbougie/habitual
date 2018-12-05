//
//  PersistanceLayer.swift
//  Habitual
//
//  Created by Kandy M on 12/4/18.
//  Copyright © 2018 Kandy M. All rights reserved.
//

import Foundation

struct PersistenceLayer {
    
    private(set) var habits: [Habit] = []
    
    private static let userDefaultHabitsKeyValue = "HABITS_ARRAY"
    
    init() {
        self.loadHabits()
    }
    
    private mutating func loadHabits() {
        let userDefaults = UserDefaults.standard
        
        guard
            let habitData = userDefaults.data(forKey: PersistenceLayer.userDefaultHabitsKeyValue),
            let habits = try? JSONDecoder().decode([Habit].self, from: habitData) else{
                return
        }
        
        self.habits = habits
    }
    
    // Create habit
    @discardableResult
    mutating func creatingNewHabit(name: String, image: Habit.Images) -> Habit{
        let newHabit = Habit(title: name, image: image) // Create new habit with the attributes that the user passes in
        self.habits.insert(newHabit, at: 0) // Prepend the habits to the array
        self.saveHabits() // save and return new habit
        return newHabit
    }
    
    // Saving habit
    private func saveHabits(){
        guard let habitsData = try? JSONEncoder().encode(self.habits) else{
            fatalError("Could not encode list of habits")
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(habitsData, forKey: PersistenceLayer.userDefaultHabitsKeyValue)
    }
    
    // delete habit
    mutating func delete(_ habitIndex: Int){
        // Remove habit at the given index
        self.habits.remove(at: habitIndex)
        
        // Persist the changes we made to our habits array
        self.saveHabits()
    }
    
    mutating func markHabitAsCompleted(_ habitIndex: Int) -> Habit {
        var updateHabit = self.habits[habitIndex]
        
        guard updateHabit.hasCompletedForToday == false else{ return updateHabit }
        
        updateHabit.numberOfCompletions += 1
        
        // Add on the current streak if the user didn't miss a day else set it to 1
        if let lastCompletionDate = updateHabit.lastCompletionDate, lastCompletionDate.isYesterday{
            updateHabit.currentStreak += 1
        }else{
            updateHabit.currentStreak = 1
        }
        
        // Check if the user current streak is more than their best streak
        // if so set the best streak to the current streak else do nothing
        if updateHabit.currentStreak > updateHabit.bestStreak {
            updateHabit.bestStreak = updateHabit.currentStreak
        }
        
        // Set selected habit as the updated habits
        // Save all the attributes changes to the habits array
        self.habits[habitIndex] = updateHabit
        self.saveHabits()
        
        return updateHabit
    }
    
    mutating func swapHabits(habitIndex: Int, destinationIndex: Int) {
        let habitToSwap = self.habits[habitIndex]
        self.habits.remove(at: habitIndex)
        self.habits.insert(habitToSwap, at: destinationIndex)
        self.saveHabits()
    }
    
    mutating func setNeedsToReloadhabits() {
        self.loadHabits()
    }
}
