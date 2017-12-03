//
//  SearchByStopView.swift
//  BusSchedule
//
//  Created by Tianyu Li on 8/9/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import UIKit
import CoreLocation

protocol SearchByStopViewDelegate {
    func pushToStopDetail(stopName : String, stopId : String, stopPoints : Array<[String : Any]>)
}

let stopCellHeight = 74.0
class SearchByStopView: UIView, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    var stopTableView : UITableView!
    var stopArray : Array<Dictionary<String,Any>> = []
    var delegate : SearchByStopViewDelegate!
    var activity : UIActivityIndicatorView!
    var activityText : UILabel!
    var locationManager : CLLocationManager!
    var currentLocation : CLLocationCoordinate2D!
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(yOrigin : Double){
        self.init(frame: CGRect(x: 0, y: yOrigin, width: Double(screen_width), height: Double(screen_height)-yOrigin))
        
        
        self.backgroundColor = UIColor.blue
        self.createTable()
        
        self.getCurrentUserLocation()
        
        activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activity.center = CGPoint(x: self.center.x, y: CGFloat(screen_height/4))
        self.addSubview(activity)
        activity.startAnimating()
        
        activityText = UILabel(frame: CGRect(x: 0, y: activity.center.y+20, width: CGFloat(screen_width), height: 30))
        let language = UserDefaults.standard.object(forKey: "language") as! String
        if language == "chinese"{
            activityText.text = "正在获取你的当前位置"
        }else{
            activityText.text = "Getting your current location..."
        }
        
        activityText.textAlignment = .center
        activityText.textColor = UIColor.gray
        activityText.font = UIFont(name: "Avenir-Medium", size: 13)
        self.addSubview(activityText)
        
        
    }
    
    
   
    
    func loadData(coordinate : CLLocationCoordinate2D){
        activityText.text = "Loading nearby stops..."
        BusScheduleNetworkRequest.getStopBy(lat: coordinate.latitude, lon: coordinate.longitude) { (result) in
            
            if result.count == 0{
                let emptyState = BusScheduleEmptyState(yOrigin: 0,emptyImageName: "bus", emptyText: "Sorry! There is no stop nearby.")
                self.addSubview(emptyState)
            }else{
                self.stopArray = result
                self.createHint()
                self.createRefreshControl()
                self.stopTableView.reloadData()
                
            }
            self.activity.stopAnimating()
            self.activity.removeFromSuperview()
            self.activityText.removeFromSuperview()
        }

    }
    
    
    
    func createTable(){
        stopTableView = UITableView(frame: CGRect(x:0, y:0, width: CGFloat(screen_width), height: self.frame.height), style: .plain)
        stopTableView.delegate = self
        stopTableView.dataSource = self
        stopTableView.register(SearchByStopViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        stopTableView.separatorStyle = .none
        stopTableView.contentInset = UIEdgeInsetsMake(60, 0, 30, 0)
        stopTableView.showsVerticalScrollIndicator = false
        stopTableView.backgroundColor = UIColor.white
        self.addSubview(stopTableView)
        
        

    }
    
    
    func createRefreshControl(){
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.pullToRefreshEvent(sender:)), for: .valueChanged)
        refreshControl.bounds = CGRect(x: 0, y: 60, width: screen_height, height: 60)
        stopTableView.addSubview(refreshControl)
        stopTableView.sendSubview(toBack: refreshControl)

    }
    
    func createHint(){
        let headerView = UIView(frame: CGRect(x: 0, y: -60, width: screen_width, height: 60))
        headerView.backgroundColor = UIColor.white
        stopTableView.addSubview(headerView)
        
        let askingText = UILabel(frame: CGRect(x: 45, y: 10, width: screen_width, height: 60))
        askingText.textAlignment = .left
        askingText.backgroundColor = UIColor.clear
        askingText.textColor = UIColor.gray
        let language = UserDefaults.standard.object(forKey: "language") as! String
        if language == "chinese"{
            askingText.text = "公车站名"
        }else{
            askingText.text = "Stop Name"
        }
        
        askingText.font = UIFont(name: "Avenir-Medium", size: 13)
        headerView.addSubview(askingText)

        let changeBtn = UILabel(frame: CGRect(x: screen_width-120, y: 10, width: 80, height: 60))
        /*if iphone5{
            changeBtn.frame = CGRect(x: screen_width-100, y: 30, width: 80, height: 30)
        }*/
        changeBtn.textAlignment = .right
        
        if language == "chinese"{
            changeBtn.text = "距离"
        }else{
            changeBtn.text = "Distance"
        }
        
        changeBtn.backgroundColor = UIColor.clear
        changeBtn.textColor = UIColor.gray
        changeBtn.font = UIFont(name: "Avenir-Medium", size: 13)
        headerView.addSubview(changeBtn)
    }
    
    func pullToRefreshEvent(sender : UIRefreshControl){
        print("refresh")
        sender.attributedTitle = NSAttributedString(string: "Loading bus schedule...")
        BusScheduleNetworkRequest.getStopBy(lat: self.currentLocation.latitude, lon: self.currentLocation.longitude) { (result) in
            self.stopArray = result
            self.stopTableView.reloadData()
            sender.endRefreshing()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stopArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SearchByStopViewCell(style: .default, reuseIdentifier: "Cell")
        
        cell.createCard(stopName: self.stopArray[indexPath.row]["stop_name"] as! String, distance: self.stopArray[indexPath.row]["distance"] as! NSNumber)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(stopCellHeight)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        self.delegate.pushToStopDetail(stopName: self.stopArray[indexPath.row]["stop_name"] as! String, stopId: self.stopArray[indexPath.row]["stop_id"] as! String, stopPoints: self.stopArray[indexPath.row]["stop_points"] as! Array<[String : Any]>)

    }
    
    //MARK: Get current location
    //get user location
    func getCurrentUserLocation(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.requestAuthorization(locationManager: locationManager)
        }
        
    }
    
    
    //MARK: Location delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(locations.last!) { (placemarks : [CLPlacemark]?, error) in
            if let placemarks = placemarks{
                let placemark = placemarks[0]
                //let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: placemark.location!.coordinate, addressDictionary: placemark.addressDictionary as! [String : Any]))
                print("get location")
                //finish loading current place
                //let fake = CLLocationCoordinate2D(latitude: 40.107684, longitude: -88.218050)
                
                self.currentLocation = placemark.location?.coordinate
                self.loadData(coordinate: (placemark.location?.coordinate)!)
                
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
    
    func getReadableAddress(placemark : CLPlacemark)->String{
        return (placemark.addressDictionary!["FormattedAddressLines"] as! [String]).joined(separator: ", ")
    }
    
    func requestAuthorization(locationManager : CLLocationManager){
        if CLLocationManager.authorizationStatus() == .notDetermined{
            locationManager.requestWhenInUseAuthorization()
        }else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            
            locationManager.requestLocation()
            print("authorized")
            
            
        }else if CLLocationManager.authorizationStatus() == .denied{
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            locationManager.requestLocation()
        }
    }


    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
