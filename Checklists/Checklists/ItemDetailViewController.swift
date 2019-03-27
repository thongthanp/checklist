//
//  AddItemViewController.swift
//  Checklists
//
//  Created by student on 20/2/2562 BE.
//  Copyright © 2562 Buu. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    func itemDetailViewController(_ controller: ItemDetailViewController)
   
    func addItemViewController(_ controller: ItemDetailViewController,didFinisAdding item: ChecklistItem)
    
    func addItemViewController(_ controller: ItemDetailViewController,didFinishEditing item: ChecklistItem)
    
}

class ItemDetailViewController: UITableViewController,UITextFieldDelegate {
    var itemToEdit: ChecklistItem?
    weak var delegate: AddItemViewControllerDelegate?
    
    @IBOutlet weak var textField: UITextField!
       @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
    }


    
    //MAKE:- Actions
    @IBAction func cencel(){
       delegate?.itemDetailViewController(self)
    }
    @IBAction func done(){
        if let item = itemToEdit {
            item.text = textField.text!
            delegate?.addItemViewController(self, didFinishEditing: item)
        }else{
            let item = ChecklistItem()
            item.text = textField.text!
            
            delegate?.addItemViewController(self, didFinisAdding: item)
        }
        
        
        
        
    }
    //Make:- Table View Delegates
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) ->IndexPath? {
        return nil
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text!
        let stringRange = Range(range, in:oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        if newText.isEmpty {
            doneBarButton.isEnabled = false
        }else{
            doneBarButton.isEnabled = true
        }
        return true
    }
    
 
}
