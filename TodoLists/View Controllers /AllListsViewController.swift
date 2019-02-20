//
//  AllListsViewController.swift
//  TodoLists
//
//  Created by curtis scott on 06/02/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate{
    
    
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding item: TodoList) {
        //let newRowIndex = dataModel.lists.count
        dataModel.lists.append(item)
        dataModel.sortTodolists()
        tableView.reloadData()
      //  let indexPath = IndexPath(row: newRowIndex, section: 0)
      //  let indexPaths = [indexPath]
       // tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing item: TodoList) {
       /* if let index = dataModel.lists.index(of: item){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                cell.textLabel!.text = item.name
            }
        }
 */
        dataModel.sortTodolists()
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    let cellIdentifier = "TodoListCell"
    var lists = [TodoList]()
    var dataModel : DataModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        

       

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = self
        let index = dataModel.indexOfSelectedTodolist
        if index >= 0 && index < dataModel.lists.count {
            let todolist = dataModel.lists[index]
            performSegue(withIdentifier: "ShowTodoList", sender: todolist)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataModel.lists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      // let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let cell: UITableViewCell
        
        if let c = tableView.dequeueReusableCell(withIdentifier: cellIdentifier){
            cell = c
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        // Configure the cell...
        
        let todolist = dataModel.lists[indexPath.row]
        cell.textLabel!.text = todolist.name
        cell.accessoryType = .detailDisclosureButton
        let count = todolist.countUncheckedItems()
        if todolist.items.count == 0{
            cell.detailTextLabel!.text = "No todos"
        }else {
        cell.detailTextLabel!.text = count == 0 ? "Completed" : "\(count) Remaining "
        }
        cell.imageView!.image = UIImage(named: todolist.iconName)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       dataModel.indexOfSelectedTodolist = indexPath.row
        let todolist = dataModel.lists[indexPath.row]
        performSegue(withIdentifier: "ShowTodoList", sender: todolist)
    }
    
   override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let controller = storyboard!.instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        controller.delegate = self
        
        let todolist = dataModel.lists[indexPath.row]
        controller.todolistToEdit = todolist
        
        navigationController?.pushViewController(controller, animated: true)
        
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    dataModel.lists.remove(at: indexPath.row)
        let indexPaths = [indexPath]
            // Delete the row from the data source
            tableView.deleteRows(at: indexPaths, with: .automatic)
          
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ShowTodoList"{
            let controller = segue.destination as! TodoListViewController
            controller.todolist = sender as? TodoList
        } else if segue.identifier == "AddTodoList" {
            let controller = segue.destination as! ListDetailViewController
            controller.delegate = self
        }
    }
    
    // MARK: - Navigation controller delegates
    
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController, animated: Bool){
        
        
        if viewController === self {
           dataModel.indexOfSelectedTodolist = -1
        }
    }

 

}
