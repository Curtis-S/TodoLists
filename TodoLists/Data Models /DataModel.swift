//
//  DataModel.swift
//  TodoLists
//
//  Created by curtis scott on 14/02/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import Foundation

class DataModel{
    var lists = [TodoList]()
    var indexOfSelectedTodolist: Int {
        get{
            return UserDefaults.standard.integer(forKey: "TodoListIndex")
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "TodoListIndex")
        }
    }
    
    // MARK:- TData Saving
    func documentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL{
        return documentsDirectory().appendingPathComponent("TodoLists.plist")
    }
    
    func saveTodolists(){
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(lists)
            
            try data.write(to: dataFilePath(),options: Data.WritingOptions.atomic)
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    func loadTodolists(){
        let path = dataFilePath()
        
        if let data = try? Data(contentsOf: path){
            let decoder = PropertyListDecoder()
            do{
                lists = try decoder.decode([TodoList].self, from: data)
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func regsiterDefaults(){
        
        let dictionary = ["TodoListIndex":-1,"FirstTime": true] as [String: Any]
        UserDefaults.standard.register(defaults: dictionary)
        
    }
    
    func firstTimeAppOpened(){
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
        if firstTime {
            let todolist = TodoList(name: "New Todo List")
            lists.append(todolist)
            
            indexOfSelectedTodolist = 0
            userDefaults.set(false, forKey: "FirstTime")
            userDefaults.synchronize()
        }
    }
    
    func sortTodolists(){
        lists.sort(by:{ list1, list2 in  return list1.name.localizedStandardCompare(list2.name) == .orderedAscending})
    }
    
    class func nextTodolistItemID() -> Int {
        let userDefaults = UserDefaults.standard
        let itemID = userDefaults.integer(forKey: "TodolistItemID")
        userDefaults.set(itemID + 1 , forKey: "TodolistItemID")
        userDefaults.synchronize()
        return itemID
    }
    
    
    init() {
        loadTodolists()
        regsiterDefaults()
        firstTimeAppOpened()
    }
}
