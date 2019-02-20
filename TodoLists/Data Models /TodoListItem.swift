//
//  TodoListItem.swift
//  TodoLists
//
//  Created by curtis scott on 02/02/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import Foundation
import UserNotifications

class TodoListItem: NSObject, Codable{
    var text = ""
    var checked = false
    var dueDate = Date()
    var shouldRemind = false
    var itemID = -1 
    func toggleChecked() {
        self.checked = !checked
    }
    func  scheduleNotification(){
        removeNotification()
        if shouldRemind  && dueDate > Date() {
            let content  = UNMutableNotificationContent()
            content.title = "Reminder"
            content.body = self.text
            content.sound = UNNotificationSound.default
            
            
            let calendar  = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.year,.month,.day,.hour,.minute], from: dueDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            let request = UNNotificationRequest(identifier: "\(itemID)", content: content, trigger: trigger)
            
            let center = UNUserNotificationCenter.current()
            center.add(request)
            
            print("shceduled \(request) for id \(itemID)")
        }
    }
    
    
    func removeNotification(){
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
    }
    override init() {
        super.init()
        itemID = DataModel.nextTodolistItemID()
    }
    
    deinit {
        removeNotification()
    }
}
