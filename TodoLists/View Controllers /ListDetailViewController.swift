//
//  ListDetailViewController.swift
//  TodoLists
//
//  Created by curtis scott on 06/02/2019.
//  Copyright © 2019 CurtisScott. All rights reserved.
//

import Foundation
import UIKit

protocol ListDetailViewControllerDelegate: class {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) -> ()
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding item: TodoList) -> ()
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing item: TodoList) -> ()
}


class ListDetailViewController: UITableViewController,UITextFieldDelegate, IconPickerViewControllerDelegate{
    
    
    //MARK:- Icon picker delgate
    func iconPicker(_ picker: IconPickerViewController, didPick iconName: String) {
        self.iconName = iconName
        icon.image = UIImage(named: iconName)
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var textField:UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var iconImage: UITableViewCell!
    
    @IBOutlet weak var icon: UIImageView!
    weak var delegate: ListDetailViewControllerDelegate?
    
    var todolistToEdit: TodoList?
    
    var iconName = "Folder"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        if let item = todolistToEdit{
            title = "Edit TodoList"
            textField.text = item.name
            //doneBarButton.isEnabled = true
            iconName = item.iconName
        }
        icon.image = UIImage(named: iconName)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
        
    }
    
    
    // MARK:- Actions
    
    @IBAction func cancel(){
        delegate?.listDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done(){
        
        if let todolist = todolistToEdit{
            todolist.name = textField.text!
            todolist.iconName = iconName
            delegate?.listDetailViewController(self, didFinishEditing: todolist)
        } else {
            
            let todolist = TodoList(name: textField.text!, iconName: iconName)
            delegate?.listDetailViewController(self, didFinishAdding: todolist)
            
        }
    }
    
    
    // MARK:- Table View Delegates
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath.section == 1 ? indexPath : nil
    }
    // MARK:- Text Feild Delegates
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)-> Bool{
        
        let oldText = textField.text!
        let stringRange = Range(range,in:oldText)!
        let newText = oldText.replacingCharacters(in: stringRange,with: string)
        
        
        doneBarButton.isEnabled = !newText.isEmpty
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        doneBarButton.isEnabled = false
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickIcon"  {
            let controller  = segue.destination as! IconPickerViewController
            controller.delegate = self
        }
    }
}
