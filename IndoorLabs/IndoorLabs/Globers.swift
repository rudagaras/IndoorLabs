//
//  Globers.swift
//  IndoorLabs
//
//  Created by Ruben Garcia on 3/05/18.
//  Copyright © 2018 Ruben Garcia. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct GloberCellStruct {
    var globerPhoto: UIImage!
    var globerName: String!
    var globerPosition: String!
    var globerEmail: String!
    var globerStatus: UIImage!
}

class Globers: UIViewController {

    @IBOutlet weak var globersTable: UITableView!
    var globerCellData = [GloberCellStruct]()
    var ref: DatabaseReference?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        ref?.child("glober").observeSingleEvent(of: .value, with: { (snapshot) in
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? DataSnapshot {
                let value = rest.value as? NSDictionary
                let name = value?["name"] as? String ?? ""
                let position = value?["position"] as? String ?? ""
                let email = value?["email"] as? String ?? ""
                var statusImg = UIImage()
                let status = value?["status"] as? String ?? ""
                if status == "on" {
                    statusImg = UIImage(named: "on.png")!
                } else {
                    statusImg = UIImage(named: "off.png")!
                }
                self.globerCellData.append(GloberCellStruct(globerPhoto: #imageLiteral(resourceName: "imagen1"), globerName: name, globerPosition: position, globerEmail: email, globerStatus: statusImg))
                self.globersTable.reloadData()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
 
        /*
        ref?.child("glober").child("1").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? ""
            let position = value?["position"] as? String ?? ""
            let email = value?["email"] as? String ?? ""
            let status = value?["status"] as? String ?? ""

            print("aca el resultado =====================")
            print(name)
            print(position)
            print(email)
            print(status)

            self.globerCellData = [
                GloberCellStruct(globerPhoto: #imageLiteral(resourceName: "imagen1"), globerName: name, globerPosition: position, globerEmail: email, globerStatus: #imageLiteral(resourceName: "on")),
                GloberCellStruct(globerPhoto: #imageLiteral(resourceName: "imagen1"), globerName: "testing2", globerPosition: "position2", globerEmail: "email2", globerStatus: #imageLiteral(resourceName: "on")),
                GloberCellStruct(globerPhoto: #imageLiteral(resourceName: "imagen1"), globerName: "testing3", globerPosition: "position3", globerEmail: "email3", globerStatus: #imageLiteral(resourceName: "off")),
                GloberCellStruct(globerPhoto: #imageLiteral(resourceName: "imagen1"), globerName: "testing4", globerPosition: "position4", globerEmail: "email4", globerStatus: #imageLiteral(resourceName: "off")),
            ]
            self.globersTable.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
        */
        
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension Globers: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension Globers: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globerCellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("GlobersCell", owner: self, options: nil)?.first as! GlobersCell
        cell.globerPhoto?.image = globerCellData[indexPath.row].globerPhoto
        cell.globerName?.text = globerCellData[indexPath.row].globerName
        cell.globerPosition?.text = globerCellData[indexPath.row].globerPosition
        cell.globerEmail?.text = globerCellData[indexPath.row].globerEmail
        cell.globerStatus?.image = globerCellData[indexPath.row].globerStatus
        return cell
    }
    
    
}



