//
//  ViewController.swift
//  TodoLists
//
//  Created by curtis scott on 30/01/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController, AddItemViewControllerDelegate {
    var todolist:TodoList!
    var items  = [TodoListItem]()
    
    // MARK:- Add Item view delegates
    func addItemViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemViewController(_ controller: ItemDetailViewController, didFinishAdding item: TodoListItem) {
        let newRowIndex = todolist.items.count
       todolist.items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
        

    }
    
    func addItemViewController(_ controller: ItemDetailViewController, didFinishEditing item: TodoListItem) {
        if let index = todolist.items.index(of: item){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)

    }
    
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view, typically from a nib.
       

        title = todolist.name
        //print(documentsDirectory())
        //print(dataFilePath())
    
    }
    
    
    // MARK:- table veiw data source 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int{
        return todolist.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)  -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoListItem", for: indexPath)
        let item = todolist.items[indexPath.row]
       configureText(for: cell, with: item)
        
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    func configureCheckmark(for cell: UITableViewCell,
                            with item:TodoListItem){
        let label = cell.viewWithTag(1001) as! UILabel
        
        if item.checked{
            label.text = "√"
        }else {
            label.text = ""
        }
    }
    func configureText(for cell:UITableViewCell, with item:TodoListItem){
        let label = cell.viewWithTag(1000) as! UILabel
        
        label.text = "\(item.itemID): \(item.text)"
    }
    
      // MARK:- Table View Delegate
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        
   
        
        if let cell = tableView.cellForRow(at: indexPath){
            
           let item = todolist.items[indexPath.row]
            item.toggleChecked()
            
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
   
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        todolist.items.remove(at: indexPath.row)
        
        
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
 
    }
    
          // MARK:- Actions
    
    @IBAction func addItems(){
        let newRowIndex = items.count
        
        let item = TodoListItem()
        item.text = "I am a new text row"
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    
     // MARK:- navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! ItemDetailViewController
            
            controller.delegate = self
        }else if segue.identifier == "EditItem" {
            let controller = segue.destination as! ItemDetailViewController
            
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                controller.itemToEdit = todolist.items[indexPath.row]
            }
        }
    }
    

}

