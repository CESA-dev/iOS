//
//  StopDetailViewController.swift
//  BusSchedule
//
//  Created by Tianyu Li on 8/10/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class StopDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    var stopName : String!
    var stopId : String!
    var busTableView : UITableView!
    var busArray : Array<[String : Any]> = []
    var stopPointsArray : Array<[String : Any]> = []
    var refreshExist = false
    var emptyState : BusScheduleEmptyState!
    
    var targetDirectionCoordinate : CLLocationCoordinate2D!
    var targetStopName : String!
    var targetStopPointId : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.targetStopPointId = self.stopId
        self.createUI()
        
        
        self.loadData()
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(){
        if emptyState != nil{
            emptyState.removeFromSuperview()
        }
        self.busArray = []
        self.busTableView.reloadData()
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activity.center = CGPoint(x: self.view.center.x, y: CGFloat(screen_height/4))
        self.view.addSubview(activity)
        activity.startAnimating()
        BusScheduleNetworkRequest.getDepartureByStop(stopId: self.targetStopPointId) { (result) in
            print(result)
            if result.count == 0{
                self.emptyState = BusScheduleEmptyState(yOrigin: 250, emptyImageName: "bus", emptyText: "Sorry! There is no bus coming up.")
                self.emptyState.frame = CGRect(x: 0, y: self.emptyState.frame.origin.y, width: self.emptyState.frame.width, height: CGFloat(screen_height)-self.emptyState.frame.origin.y)
                self.view.addSubview(self.emptyState)
            }else{
                self.busArray = result
                if !self.refreshExist{
                    self.createRefreshControl()
                }
                
            }
            self.busTableView.reloadData()
            activity.removeFromSuperview()
        }
    }
    
    
    
    
    func createMap(){
        let mapView = MKMapView(frame: CGRect(x: 20, y: 100, width: screen_width-40, height: 250-100))
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: self.stopPointsArray[0]["stop_lat"] as! CLLocationDegrees, longitude: self.stopPointsArray[0]["stop_lon"] as! CLLocationDegrees)
        mapView.isZoomEnabled = true
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.showsBuildings = true
        mapView.layer.cornerRadius = 8
        self.view.addSubview(mapView)
        
        let regionRadius : CLLocationDistance = 100
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(mapView.centerCoordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: false)
        
        self.showAnnotationForAllStops(mapView: mapView)
    }
    
    
    func createUI(){
        self.createMap()
        
        
        busTableView = UITableView(frame: CGRect(x:0, y:260, width: CGFloat(screen_width), height: self.view.frame.height-260), style: .plain)
        busTableView.delegate = self
        busTableView.dataSource = self
        busTableView.register(StopDetailViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        busTableView.separatorStyle = .none
        busTableView.contentInset = UIEdgeInsetsMake(30, 0, 30, 0)
        busTableView.showsVerticalScrollIndicator = false
        
        self.view.addSubview(busTableView)
        
        
        let myBandView = UIView(frame: CGRect(x: 0, y: 0, width:screen_width,height: 80))
        myBandView.backgroundColor = brownTheme
        /*myBandView.layer.shadowColor = UIColor(white: 155.0/255, alpha: 0.9).cgColor
        myBandView.layer.shadowOffset = CGSize(width: 0.5, height: 2.0)
        myBandView.layer.shadowOpacity = 0.9*/
        self.view.addSubview(myBandView)
        
        let functionTitle = UILabel(frame: CGRect(x: 0, y: 20, width: screen_width, height: 60))
        functionTitle.text = self.stopName
        functionTitle.textColor = UIColor.white
        functionTitle.textAlignment = .center
        functionTitle.font = UIFont(name: "Avenir-Heavy", size: 18)
        myBandView.addSubview(functionTitle)
        
        
        
        let backBtn = UIButton(frame: CGRect(x: 0, y: 20, width: 60, height: 60))
        backBtn.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        //backBtn.backgroundColor = UIColor.blue
        backBtn.addTarget(self, action: #selector(self.backToMainMenu), for: .touchUpInside)
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(18, 18, 18, 18)
        self.view.addSubview(backBtn)
        
        
        
        let direction = UIButton(frame: CGRect(x: screen_width-60, y: 20, width: 60, height: 60))
        direction.backgroundColor = UIColor.blue
        direction.setTitle("Dir", for: .normal)
        direction.setTitleColor(UIColor.white, for: .normal)
        direction.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 16)
        direction.addTarget(self, action: #selector(self.showDirectionInMap), for: .touchUpInside)
        //self.view.addSubview(direction)
        
        
        
        
    }
    
    func createRefreshControl(){
        
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.pullToRefreshEvent(sender:)), for: .valueChanged)
        refreshControl.bounds = CGRect(x: 0, y: 40, width: screen_height, height: 60)
        busTableView.addSubview(refreshControl)
        busTableView.sendSubview(toBack: refreshControl)
        refreshExist = true
        
    }
    
    func pullToRefreshEvent(sender : UIRefreshControl){
        print("refresh")
        BusScheduleNetworkRequest.getDepartureByStop(stopId: self.targetStopPointId) { (result) in
            self.busArray = result
            self.busTableView.reloadData()
            sender.endRefreshing()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.busArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = StopDetailViewCell(style: .default, reuseIdentifier: "Cell")
        
        let headSignName = self.busArray[indexPath.row]["headsign"] as! String
        let trip = self.busArray[indexPath.row]["trip"] as! [String : Any]
        let direction = trip["trip_headsign"] as! String
        let time = self.busArray[indexPath.row]["expected_mins"] as! Int
        
        cell.createCard(headSignName: headSignName, direction: direction, time: time)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 97
    }
    
    func backToMainMenu(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAnnotationForAllStops(mapView : MKMapView){
        var i = 0
        for _ in self.stopPointsArray{
            let annotation = StopAnnotation(stopName: self.stopPointsArray[i]["stop_name"] as! String, stopId: self.stopPointsArray[i]["stop_id"] as! String, coordinate: CLLocationCoordinate2D(latitude: self.stopPointsArray[i]["stop_lat"] as! CLLocationDegrees, longitude: self.stopPointsArray[i]["stop_lon"] as! CLLocationDegrees))
            i = i + 1
            mapView.addAnnotation(annotation)
        }
        
    }
    
    
    
    
    func showDirectionInMap(){
        let latitude: CLLocationDegrees = self.targetDirectionCoordinate.latitude
        let longitude: CLLocationDegrees = self.targetDirectionCoordinate.longitude
        
        let regionDistance:CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.targetStopName
        mapItem.openInMaps(launchOptions: options)
        
        
    }
    
    //MARK: Mapview delegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? StopAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -10, y: 0)
                
                
                let goBtn = UIButton(type: .custom)
                goBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
                goBtn.backgroundColor = brownDarkTheme
                goBtn.setTitle("Go", for: .normal)
                goBtn.setTitleColor(UIColor.white, for: .normal)
                goBtn.layer.cornerRadius = 8.0
                goBtn.addTarget(self, action: #selector(self.showDirectionInMap), for: .touchUpInside)
                view.rightCalloutAccessoryView = goBtn
            }
            return view
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("select")
        let annotation = view.annotation as? StopAnnotation
        self.targetDirectionCoordinate = annotation?.coordinate
        self.targetStopName = annotation?.title
        self.targetStopPointId = annotation?.stopId
        
        loadData()
        
        
        
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
