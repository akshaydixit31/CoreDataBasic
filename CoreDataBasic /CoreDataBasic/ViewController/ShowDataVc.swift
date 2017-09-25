//
//  ShowDataVc.swift
//  CoreDataBasic
//
//  Created by Appinventiv Technologies on 20/09/17.
//  Copyright © 2017 Appinventiv Technologies. All rights reserved.
//

import UIKit
import CoreData

class ShowDataVc: UIViewController {
    //-------- Outlet's ---------
    @IBOutlet weak var showDataTableView: UITableView!
    
    //------- Variable's ----------
    var personArray = [Person]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "ShowDataCell", bundle: nil)
        showDataTableView.register(cellNib,
                                   forCellReuseIdentifier: "ShowDataCellId")  //----- register cell....
        
        showDataTableView.dataSource = self
        showDataTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.personArray = CoreDataManager.fetch()
        self.showDataTableView.reloadData()
        
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
}

//============== ShowDataVc extension ==============

extension ShowDataVc: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 187
        
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return personArray.count
        
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShowDataCellId",
                                                       for: indexPath) as? ShowDataCell else{
                                                        fatalError()
                                                        
        }
        
        let personData = personArray[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        //            let strDate = dateFormatter.string(from: personData.dob!)
        
        cell.nameLabel.text =   personData.name
        cell.emailLabel.text =  personData.email
        //            cell.dobLabel.text = strDate
        cell.cityLabel.text =   personData.city
        cell.contactLabel.text = personData.contact
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView,
                   editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteButton = UITableViewRowAction(style: .normal,
                                                title: "Delete") { action,
                                                    index in
                                                    
                                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                                    let context = appDelegate.persistentContainer.viewContext   //===============
                                                    
                                                    
                                                    context.delete(self.personArray[editActionsForRowAt.row])
                                                    self.personArray.remove(at: editActionsForRowAt.row)
                                                    tableView.deleteRows(at: [editActionsForRowAt],
                                                                         with: .automatic)
                                                    
                                                    let _ : NSError! = nil
                                                    do {
                                                        try context.save()
                                                        self.showDataTableView.reloadData()
                                                    } catch {
                                                        print("error : \(error)")
                                                    }
        }
        deleteButton.backgroundColor = .red
        
        let updateData = UITableViewRowAction(style: .normal,
                                              title: "UpDate") { action, index in
                                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                                let context = appDelegate.persistentContainer.viewContext   //===============
                                                
                                                guard let addDataScene = self.storyboard?.instantiateViewController(withIdentifier: "AddDataVcId") as? AddDataVc else{
                                                    fatalError("View not foundL:")
                                                }
                                                addDataScene.person = self.personArray[editActionsForRowAt.row]//== For editing row
                                                
                                                context.delete(self.personArray[editActionsForRowAt.row])
                                                //                                                self.personArray.remove(at: editActionsForRowAt.row)
                                                //
                                                self.present(addDataScene,
                                                             animated: true, completion: nil)
                                                
        }
        updateData.backgroundColor = .orange
        return [deleteButton,updateData]
    }
    
    
}


