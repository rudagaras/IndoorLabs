//
//  GlobersCell.swift
//  IndoorLabs
//
//  Created by Ruben Garcia on 3/05/18.
//  Copyright © 2018 Ruben Garcia. All rights reserved.
//

import UIKit

class GlobersCell: UITableViewCell {

    @IBOutlet weak var globerPhoto: UIImageView!
    @IBOutlet weak var globerName: UILabel!
    @IBOutlet weak var globerPosition: UILabel!
    @IBOutlet weak var globerEmail: UILabel!
    @IBOutlet weak var globerStatus: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
