//
//  temp.swift
//  TodoLists
//
//  Created by curtis scott on 14/02/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import Foundation

/*
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
 */
