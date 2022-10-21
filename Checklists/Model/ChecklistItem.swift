//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Gabriel de Castro Chaves on 25/08/22.
//

import Foundation
import UIKit
import UserNotifications

class ChecklistItem: NSObject, Codable {
    
    //MARK: - Var
    var text = ""
    var isChecked = false
    var dueDate = Date()
    var shouldRemind = false
    var itemID = -1
    
    //MARK: - Init
    init(text: String, isChecked: Bool = false) {
        self.text = text
        self.isChecked = isChecked
        itemID = DataModel.nextChecklistItemID()
    }
    
    deinit {
        removeNotification()
    }
    
    //MARK: - Functions
    private func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
    }
    
    func scheduleNotification() {
        removeNotification()
        
        if shouldRemind && dueDate > Date() {
            
            let content = UNMutableNotificationContent()
            content.title = "Reminder"
            content.body = text
            content.sound = .default
            
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents( [.year, .month, .day, .hour, .minute], from: dueDate)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            
            let request = UNNotificationRequest(identifier: "\(itemID)", content: content, trigger: trigger)
            
            let center = UNUserNotificationCenter.current()
            center.add(request)
        }
    }
    
}
