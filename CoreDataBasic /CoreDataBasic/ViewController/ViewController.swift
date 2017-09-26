//
//  ViewController.swift
//  CoreDataBasic
//
//  Created by Appinventiv Technologies on 20/09/17.
//  Copyright © 2017 Appinventiv Technologies. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func addDataButton(_ sender: UIButton) {
        
        let addData = UIStoryboard(name: "Main", bundle: nil)
        
        guard let addDataScene =  addData.instantiateViewController(withIdentifier: "AddDataVcId") as? AddDataVc else{
            return print("Scene not found")
        }
        
        self.present(addDataScene,
                     animated: true,
                     completion: nil)
    }
    
    @IBAction func fetchDataButton(_ sender: UIButton) {
        
        let showData = UIStoryboard(name: "Main", bundle: nil)
        
        guard let showDataScene =  showData.instantiateViewController(withIdentifier: "ShowDataVcId") as? ShowDataVc else{
            return print("Scene not found")
        }
        self.present(showDataScene, animated: true, completion: nil)
    }
}
