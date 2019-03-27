import UIKit

class ChecklistViewController : UITableViewController,AddItemViewControllerDelegate {
    
    func saveChecklistItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(items)
            
            try data.write(to: dataFilePath(),options: Data.WritingOptions.atomic)
        } catch{
            print("Error encoding item arrayL \(error.localizedDescription)")
        }
    }
    func loadChecklistItems(){
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path){
            let decoder = PropertyListDecoder()
            do{
                items = try decoder.decode([ChecklistItem].self, from: data)
            }catch{
                print("Error decoding item array: \(error.localizedDescription)")
            }
        }
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController) {
         navigationController?.popViewController(animated:true)
    }
    
    func addItemViewController(_ controller: ItemDetailViewController, didFinisAdding item: ChecklistItem) {
        let newRowIndex = items.count
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
         navigationController?.popViewController(animated:true)
        saveChecklistItems()
    }
    
    var items = [ChecklistItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add the following lines
        navigationController?.navigationBar.prefersLargeTitles = true
        let item1 = ChecklistItem()
        item1.text = "Walk the dog."
        item1.checked = false
        items.append(item1)
        
        let item2 = ChecklistItem()
        item2.text = "Brush my teeth"
        item2.checked = false
        items.append(item2)
        
        let item3 = ChecklistItem()
        item3.text = "Learn iOS development"
        item3.checked = false
        items.append(item3)
        
        let item4 = ChecklistItem()
        item4.text = "Soccer practice"
        item4.checked = false
        items.append(item4)
        
        let item5 = ChecklistItem()
        item5.text = "Eat ice cream"
        item5.checked = false
        items.append(item5)

        print("Documents folder is \(documentsDirectory())")
        print("Data File Path is \(dataFilePath())")
        
        loadChecklistItems()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //    MARK: data soure protocol.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem",for: indexPath)
        
        let label = cell.viewWithTag(1000) as! UILabel
        
        let item = items[indexPath.row]
        
        
        label.text = item.text
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell

    }
    
    //    MARK: accsessory tableview
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let cell = tableView.cellForRow(at: indexPath){
            //         var isChecked = false
            let item = items[indexPath.row]
            item.toggleChecked()
            
            configureCheckmark(for: cell, with: item)
            
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
        saveChecklistItems()
        
    }
  
    
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem){
        
        //        let item = items[indexPath.row]

        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }

    func configureText(for cell: UITableViewCell, with item: ChecklistItem){
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //1
        items.remove(at: indexPath.row)
        //2
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        saveChecklistItems()
    }
    
    //MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue,sender: Any?){
        //1
        if segue.identifier == "AddItem"{
            //2
            let controller = segue.destination
                as! ItemDetailViewController
            //3
            controller.delegate = self
            
        }else if segue.identifier == "EditItem" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                controller.itemToEdit = items[indexPath.row]
            }
        }
    }
    func addItemViewController(_ controller:ItemDetailViewController,didFinishEditing item: ChecklistItem){
        if let index = items.index(of: item){
            let indexPath = IndexPath(row: index,section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated: true)
        saveChecklistItems()
    }
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    

}
