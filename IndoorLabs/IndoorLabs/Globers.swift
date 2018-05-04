//
//  Globers.swift
//  IndoorLabs
//
//  Created by Ruben Garcia on 3/05/18.
//  Copyright © 2018 Ruben Garcia. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        globerCellData = [
            GloberCellStruct(globerPhoto: #imageLiteral(resourceName: "imagen1"), globerName: "testing1", globerPosition: "position1", globerEmail: "email1", globerStatus: #imageLiteral(resourceName: "on")),
            GloberCellStruct(globerPhoto: #imageLiteral(resourceName: "imagen1"), globerName: "testing2", globerPosition: "position2", globerEmail: "email2", globerStatus: #imageLiteral(resourceName: "on")),
            GloberCellStruct(globerPhoto: #imageLiteral(resourceName: "imagen1"), globerName: "testing3", globerPosition: "position3", globerEmail: "email3", globerStatus: #imageLiteral(resourceName: "off")),
            GloberCellStruct(globerPhoto: #imageLiteral(resourceName: "imagen1"), globerName: "testing4", globerPosition: "position4", globerEmail: "email4", globerStatus: #imageLiteral(resourceName: "off"))
        ]

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
        
//        let recipeResultCell = Bundle.main.loadNibNamed("RecipeResultsCell", owner: self, options: nil)?.first as! RecipeResultsCell
//        recipeResultCell.recipeImage.image = cellResultData[indexPath.row].recipeImage
//        recipeResultCell.recipeName.text = cellResultData[indexPath.row].recipeName
//        recipeResultCell.recipeCountry.text = cellResultData[indexPath.row].recipeCountry
//        return recipeResultCell
    }
    
    
}



