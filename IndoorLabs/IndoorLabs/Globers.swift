//
//  Globers.swift
//  IndoorLabs
//
//  Created by Ruben Garcia on 3/05/18.
//  Copyright © 2018 Ruben Garcia. All rights reserved.
//

import UIKit
import FirebaseDatabase
import CoreLocation

struct GloberCellStruct {
    var globerPhoto: UIImageView!
    var globerName: String!
    var globerPosition: String!
    var globerEmail: String!
    var globerStatus: UIImageView!
}

class Globers: UIViewController {

    @IBOutlet weak var globersTable: UITableView!
    var globerCellData = [GloberCellStruct]()
    var ref: DatabaseReference?
    var locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        ref = Database.database().reference()
        ref?.child("glober").observeSingleEvent(of: .value, with: { (snapshot) in
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? DataSnapshot {
                let value = rest.value as? NSDictionary
                let name = value?["name"] as? String ?? ""
                let position = value?["position"] as? String ?? ""
                let email = value?["email"] as? String ?? ""
                
                let photoGlober = UIImage(named: "imagen1")!
                let photo = UIImageView(image: photoGlober)
                
                let offImg = UIImage(named: "off.png")!
                let statusImg = UIImageView(image: offImg)
                
                self.globerCellData.append(GloberCellStruct(globerPhoto: photo, globerName: name, globerPosition: position, globerEmail: email, globerStatus: statusImg))
                self.globersTable.reloadData()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func rangeBeacons() {
        let uuid = UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!
        let major: CLBeaconMajorValue = 7213
        let minor: CLBeaconMinorValue = 47823
        let identifier = "a7ef71fe6de90f9c1fdf4eb301b65b2c"
        let region = CLBeaconRegion(proximityUUID: uuid, major: major, minor: minor, identifier: identifier)
        locationManager.startRangingBeacons(in: region)
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
        cell.globerPhoto?.image = globerCellData[indexPath.row].globerPhoto.image
        cell.globerName?.text = globerCellData[indexPath.row].globerName
        cell.globerPosition?.text = globerCellData[indexPath.row].globerPosition
        cell.globerEmail?.text = globerCellData[indexPath.row].globerEmail
        cell.globerStatus?.image = globerCellData[indexPath.row].globerStatus.image
        return cell
    }
}

extension Globers: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            rangeBeacons()
        }
    }
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        guard let discoveredBeaconProximity = beacons.first?.proximity else {
            print("couldn't find beacon!")
            ref?.child("glober").child("1").updateChildValues(["status": "off"])
            self.globersTable.reloadData()
            return
        }
        
        let beaconProximity: String = {
            switch discoveredBeaconProximity {
            case .immediate:
                print("detected by immediate")
                return "on"
            case .near:
                print("detected by near")
                return "on"
            case .far:
                print("detected by far")
                return "on"
            default:
                print("detected by default")
                return "off"
            }
        }()
        print(beaconProximity)
        ref?.child("glober").child("1").updateChildValues(["status": beaconProximity])
        
        ref?.child("glober").observeSingleEvent(of: .value, with: { (snapshot) in
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? DataSnapshot {
                for i in 0..<self.globerCellData.count {
                    let value = rest.value as? NSDictionary
                    let email = value?["email"] as? String ?? ""
                    if email == "ruben.garcia@globant.com" {
                        let value = rest.value as? NSDictionary
                        let name = value?["name"] as? String ?? ""
                        let position = value?["position"] as? String ?? ""
                        let photoGlober = UIImage(named: "imagen1")!
                        let photo = UIImageView(image: photoGlober)
                        
                        switch beaconProximity {
                            case "on":
                                let onImg = UIImage(named: "on.png")!
                                let statusImg = UIImageView(image: onImg)
                                self.globerCellData[i] = GloberCellStruct(globerPhoto: photo, globerName: name, globerPosition: position, globerEmail: email, globerStatus: statusImg)
                                self.globersTable.reloadData()
                            case "off":
                                let offImg = UIImage(named: "off.png")!
                                let statusImg = UIImageView(image: offImg)
                                self.globerCellData[i] = GloberCellStruct(globerPhoto: photo, globerName: name, globerPosition: position, globerEmail: email, globerStatus: statusImg)
                                self.globersTable.reloadData()
                            default:
                                let offImg = UIImage(named: "off.png")!
                                let statusImg = UIImageView(image: offImg)
                                self.globerCellData[i] = GloberCellStruct(globerPhoto: photo, globerName: name, globerPosition: position, globerEmail: email, globerStatus: statusImg)
                                self.globersTable.reloadData()
                        }
                        break
                    }
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

