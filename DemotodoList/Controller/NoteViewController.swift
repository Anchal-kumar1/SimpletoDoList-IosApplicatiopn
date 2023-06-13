//
//  NoteViewController.swift
//  DemotodoList
//
//  Created by Anchal on 05/06/23.
//

import UIKit

class NoteViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var tableVwDetailsPage: UIView!
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var presentVw: UIView!
    @IBOutlet weak var optionsVw: UIView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var noteTF: UITextField!
    @IBOutlet weak var centerAlertVw: UIView!
    @IBOutlet weak var otherVw: UIView!
    @IBOutlet weak var tableVw: UITableView!
    
    var selectedRow = ToDoList()
    private var modals = [ToDoList]()
    var flag = 0
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer?.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        otherVw.isHidden = true
        optionsVw.isHidden = true
        presentVw.layer.cornerRadius = 10
        presentVw.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        editBtn.layer.cornerRadius = 10
        deleteBtn.layer.cornerRadius = 10
        updateBtn.layer.cornerRadius = 10
        centerAlertVw.layer.cornerRadius = 10
        noteTF.layer.cornerRadius = 10
        btnSubmit.layer.cornerRadius = 10
        cancelBtn.layer.cornerRadius = 10
        tableVwDetailsPage.layer.cornerRadius = 20
        tableVw.layer.cornerRadius = 20
        
        
        
        getDataFromDb()
        
    }
    
    //MARK: - Private Function
    
    func getDataFromDb(){
        do{
            modals = try context!.fetch(ToDoList.fetchRequest())
            DispatchQueue.main.async {
                self.tableVw.reloadData()
            }
           
        }catch{
            //error
        }
        
    }
    func createData(name: String){
        let newItem = ToDoList(context: context!)
        newItem.name = name
        newItem.date = Date()
        
        do{
            try context?.save()
            getDataFromDb()
        }catch{
            
        }
        
    }
    func deleteData(item : ToDoList){
        context?.delete(item)
        
        do{
            try context?.save()
            getDataFromDb()
        }catch{
            
        }
        
    }
    
    func updateData(item : ToDoList,newName : String){
        item.name = newName
        
        do{
            try context?.save()
            getDataFromDb()
        }catch{
            
        }
    }
    
    //MARK: - End
    
    //MARK: - IBAction
    @IBAction func plusBtnTapped(_ sender: UIButton) {
        
        otherVw.isHidden = false
        noteTF.text = ""
        
  
        
        
        
//        let alert = UIAlertController(title: "New Note", message: "Enter new note", preferredStyle: .alert)
//        alert.addTextField()
//        alert.addAction(UIAlertAction(title: "Submit", style: .cancel,handler: { [weak self] _ in
//            guard let feild = alert.textFields?.first, let text = feild.text , !text.isEmpty else{
//                return
//            }
//            self?.createData(name: text)
//        }))
//
//        present(alert, animated: true)

    }
    
    @IBAction func updateBtnTapped(_ sender: Any) {
        
        optionsVw.isHidden = true
        
    }
    @IBAction func deleteBTn(_ sender: Any) {
        
        optionsVw.isHidden = true
        self.deleteData(item: selectedRow)
        otherVw.isHidden = true
        tableVw.reloadData()
        
        
    }
    @IBAction func editBtn(_ sender: Any) {
        flag = 1
        optionsVw.isHidden = true
        otherVw.isHidden = false
        noteTF.text = selectedRow.name as! String
        
    }
    @IBAction func binBtn(_ sender: Any) {
        optionsVw.isHidden = true
    }
    @IBAction func btnSubmitTapped(_ sender: Any) {
        
        guard let field = noteTF.text , !field.isEmpty else{
            return
        }
        
        print("feild...",field)
        if flag == 1 {
            updateData(item: selectedRow, newName: field)
        }else{
            self.createData(name: field)
            tableVw.reloadData()
        }
        
        otherVw.isHidden = true
        
    }
    
    @IBAction func cancelBtnTapped(_ sender: UIButton) {
        otherVw.isHidden = true
    }
    //MARK: - End
    
    //MARK: - Textfield Delegate

    func textFieldDidBeginEditing(_ textField: UITextField) {
        noteTF.text = textField.text
        print("noteTf...",noteTF.text)
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        <#code#>
//    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    //MARK: - End
}

//MARK: - TableVw
extension NoteViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = modals[indexPath.row]
        print("models...",model)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NoteTableViewCell
        cell.nameLbl.text = model.name
        let date = model.date
            print("date...",date)
        //let dates = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let result =  dateFormatter.string(from: date!)
            cell.dateLbl.text = result
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = modals[indexPath.row]
        print("itemmmss..",item)
        tableView.deselectRow(at: indexPath, animated: true)
        selectedRow = item
        print("selectedRow",selectedRow)
        optionsVw.isHidden = false
        
        
        
//        let actionSheet = UIAlertController(title: "Edit Note", message: nil, preferredStyle: .actionSheet)
//        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        actionSheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
//
//            let alert = UIAlertController(title: "Edit Note", message: "Edit your note", preferredStyle: .alert)
//            alert.addTextField()
//            alert.textFields?.first?.text = item.name
//            alert.addAction(UIAlertAction(title: "Save", style: .cancel,handler: { [weak self] _ in
//                guard let feild = alert.textFields?.first, let newName = feild.text , !newName.isEmpty else{
//                    return
//                }
//                self?.updateData(item: item, newName: newName)
//            }))
//
//            self.present(alert, animated: true)
//
//        }))
//        actionSheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self]_ in
//            self?.deleteData(item: item)
//        }))
//        present(actionSheet, animated: true)
   }
//
    
    
    
}

//MARK: - End
class NoteTableViewCell : UITableViewCell{
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
}
