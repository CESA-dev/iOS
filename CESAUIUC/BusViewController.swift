//
//  BusViewController.swift
//  BusSchedule
//
//  Created by Tianyu Li on 8/5/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

let PlaceAPIKey = "f0cf6312d13b4089b849fd935c9fccd8"
let DirectionAPIKey = "AIzaSyBbaKQPlVF0BavP87Zl7MmsKZDmBtfrf98"
let MarkerAPIKey = "AIzaSyDoh7rpXAaYuts0bIu8YOIpvaBzZofpv0Y"
//let orangeTheme = UIColor(red: 255/255, green: 174/255, blue: 79/255, alpha: 1.0)


class BusViewController: UIViewController, BusScheduleViewDelegate {
    
    var busView : BusScheduleView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        busView = BusScheduleView()
        busView.delegate = self
        self.view.addSubview(busView)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        

    
    func presentStopDetail(stopName: String, stopId: String, stopPoints : Array<[String : Any]>) {
        let stopDetailVC = StopDetailViewController()
        stopDetailVC.stopName = stopName
        stopDetailVC.stopId = stopId
        stopDetailVC.stopPointsArray = stopPoints
        self.navigationController?.pushViewController(stopDetailVC, animated: true)
        
        
    }
    
    func pushBackToMainMenu() {
        _ = self.navigationController?.popToRootViewController(animated: true)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
