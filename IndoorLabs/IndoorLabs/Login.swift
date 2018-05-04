//
//  Login.swift
//  IndoorLabs
//
//  Created by Ruben Garcia on 3/05/18.
//  Copyright © 2018 Ruben Garcia. All rights reserved.
//

import UIKit

class Login: UIViewController {

    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appTitle.text = "Globant Indoor"
        appTitle.textAlignment = .center
        appTitle.textColor = UIColor(rgb: 0x118F83)
        appTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 28.0)!
        
        loginBtn.setTitle("Login with Google", for: .normal)
        loginBtn.setTitleColor(UIColor(rgb: 0xF3F3F4), for: .normal)
        loginBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 17.0)!
        loginBtn.backgroundColor = UIColor(rgb: 0x118F83)
    }


    @IBAction func loginBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "loginToTabBar", sender: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
