//
//  busScheduleView.swift
//  BusSchedule
//
//  Created by Tianyu Li on 8/1/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import UIKit

//let screen_width = UIScreen.main.bounds.width
//let screen_height = UIScreen.main.bounds.height
let barHeight = 80.0
let stopTagOriginX = screen_width/4 - screen_width*0.16
let routeTagOriginX = screen_width/4 * 3 - screen_width*0.16

protocol BusScheduleViewDelegate {
    func presentStopDetail(stopName : String, stopId : String, stopPoints : Array<[String : Any]>)
    func pushBackToMainMenu()
}


class BusScheduleView: UIView, UITextFieldDelegate, SearchByStopViewDelegate, SearchByRouteViewDelegate {
    var selectionTag : String = "stop"
    var selectionTagView : UIView!
    var routeBtn : UIButton!
    var stopBtn : UIButton!
    var routeView : SearchByRouteView!
    var stopView : SearchByStopView!
    var delegate : BusScheduleViewDelegate!
    var barView : UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: screen_width, height: screen_height))
        
        
        self.finishLoadingCurrentLocation()
        
    }
    
    func finishLoadingCurrentLocation(){
        self.createUI()
        self.createSelectionHeaderBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: UI
    private func createSelectionHeaderBar(){
        
        barView = UIView(frame: CGRect(x: 0, y: 0, width: screen_width, height: barHeight))
        barView.backgroundColor = brownTheme
        /*barView.layer.shadowColor = UIColor(white: 155.0/255, alpha: 0.9).cgColor
        barView.layer.shadowOffset = CGSize(width: 0.5, height: 2.0)
        barView.layer.shadowOpacity = 0.9*/
        self.addSubview(barView)
        
        let backBtn = UIButton(frame: CGRect(x: 0, y: 20, width: 60, height: 60))
        //backBtn.backgroundColor = UIColor.blue
        backBtn.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        backBtn.addTarget(self, action: #selector(self.backBtnPress), for: .touchUpInside)
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(18, 18, 18, 18)
        self.addSubview(backBtn)
        
        let refreshCurrentLocation = UIButton(frame: CGRect(x: screen_width-60, y: 20, width: 60, height: 60))
        refreshCurrentLocation.backgroundColor = UIColor.clear
        refreshCurrentLocation.addTarget(self, action: #selector(self.refreshCurrentLocationBtnPress), for: .touchUpInside)
        refreshCurrentLocation.setImage(#imageLiteral(resourceName: "location"), for: .normal)
        refreshCurrentLocation.imageEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20)
        self.addSubview(refreshCurrentLocation)
        
        let functionTitle = UILabel(frame: CGRect(x: 0, y: 20, width: screen_width, height: 60))
        let language = UserDefaults.standard.object(forKey: "language") as! String
        if language == "chinese"{
            functionTitle.text = "车站查询"
        }else{
            functionTitle.text = "Bus Schedule"
        }
        
        functionTitle.textColor = UIColor.white
        functionTitle.textAlignment = .center
        functionTitle.font = UIFont(name: "Avenir-Heavy", size: 19)
        barView.addSubview(functionTitle)

        //self.createSelectionView(headerBar: barView)
        
    }
    
    
    private func createSelectionView(headerBar : UIView){
        stopBtn = UIButton(frame: CGRect(x: 0, y: headerBar.frame.height/2+20, width: CGFloat(screen_width/2), height: headerBar.frame.height/2-20))
        stopBtn.backgroundColor = UIColor.clear
        stopBtn.setTitle("Stop Info", for: .normal)
        stopBtn.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 14)
        stopBtn.setTitleColor(UIColor.white, for: .normal)
        stopBtn.addTarget(self, action: #selector(BusScheduleView.selectionAction), for: .touchUpInside)
        stopBtn.isEnabled = false
        headerBar.addSubview(stopBtn)
        
        routeBtn = UIButton(frame: CGRect(x: CGFloat(screen_width/2), y: headerBar.frame.height/2+20, width: CGFloat(screen_width/2), height: headerBar.frame.height/2-20))
        routeBtn.backgroundColor = UIColor.clear
        routeBtn.setTitle("Find Route", for: .normal)
        routeBtn.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 14)
        routeBtn.setTitleColor(UIColor.white, for: .normal)
        routeBtn.addTarget(self, action: #selector(BusScheduleView.selectionAction), for: .touchUpInside)
        routeBtn.isEnabled = true
        headerBar.addSubview(routeBtn)
        
        selectionTagView = UIView(frame: CGRect(x: stopTagOriginX, y: Double(headerBar.frame.height-3), width: screen_width*0.32, height: 3))
        selectionTagView.backgroundColor = UIColor.white
        headerBar.addSubview(selectionTagView)
        
        
    }
    
    
    private func createUI(){
        stopView = SearchByStopView(yOrigin: Double(barHeight))
        stopView.delegate = self
        self.addSubview(stopView)
        
        /*routeView = SearchByRouteView(yOrigin : Double(barHeight))
        routeView.delegate = self
        self.addSubview(routeView)
        self.sendSubview(toBack: routeView)*/
    }
    
    
    //MARK: Action
    
    func selectionAction(){
        if selectionTag == "route"{
            stopBtn.isEnabled = false
            routeBtn.isEnabled = true
            self.sendSubview(toBack: routeView)
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 4.0, options: .curveEaseOut, animations: {
                self.selectionTagView.frame = CGRect(x:stopTagOriginX, y: barHeight-3, width: screen_width*0.32, height: 3)
            }, completion: { (Bool) in
                self.selectionTag = "stop"
            })
        }else{
            stopBtn.isEnabled = true
            routeBtn.isEnabled = false
            self.sendSubview(toBack: stopView)
            
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 4.0, options: .curveEaseOut, animations: {
                self.selectionTagView.frame = CGRect(x:routeTagOriginX, y: barHeight-3, width: screen_width*0.32, height: 3)
            }, completion: { (Bool) in
                self.selectionTag = "route"
            })
        }
    }
    
    func pushToStopDetail(stopName : String, stopId : String, stopPoints : Array<[String : Any]>) {
        self.delegate.presentStopDetail(stopName: stopName, stopId: stopId, stopPoints: stopPoints)
    }
    
    func fadeBar() {
        self.bringSubview(toFront: self.routeView)
        UIView.animate(withDuration: 0.4, animations: {
            self.barView.alpha = 0.0
        }) { (finish) in
            
        }
        
        
    }
    
    func showBar() {
        self.insertSubview(self.routeView, aboveSubview: self.stopView)
        UIView.animate(withDuration: 0.3, animations: {
            self.barView.alpha = 1.0
        }) { (finish) in
            
        }
    }
    
    func backBtnPress(){
        self.delegate.pushBackToMainMenu()
    }
    
    
    func refreshCurrentLocationBtnPress(){
        if stopView != nil{
            self.stopView.removeFromSuperview()
        }
        stopView = SearchByStopView(yOrigin: Double(barHeight))
        stopView.delegate = self
        self.addSubview(stopView)
        self.sendSubview(toBack: self.stopView)
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
