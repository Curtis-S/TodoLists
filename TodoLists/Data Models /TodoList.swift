//
//  TodoList.swift
//  TodoLists
//
//  Created by curtis scott on 06/02/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import UIKit

class TodoList: NSObject, Codable{
    var iconName  = "Appointments"
 var name = ""
    var items = [TodoListItem]()
    
    init(name: String, iconName: String = "No Icon" ) {
        
        self.name = name
        self.iconName = iconName
        super.init()
    }
    
    func countUncheckedItems() -> Int {
        var count  = 0
        for item in items where !item.checked {
            count += 1
        }
        return count
    }
}
