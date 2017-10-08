//
//  StopAnnotation.swift
//  CESAUIUC
//
//  Created by Tianyu Li on 8/21/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class StopAnnotation: NSObject, MKAnnotation {
    let title : String?
    let stopName : String
    let stopId : String
    let coordinate : CLLocationCoordinate2D
    
    init(stopName : String, stopId : String, coordinate : CLLocationCoordinate2D) {
        self.title = stopName
        self.stopName = stopName
        self.stopId = stopId
        self.coordinate = coordinate
        super.init()
        
        
        
        
    }
    
}
