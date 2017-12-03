//
//  LaundryFirstView.swift
//  CESAUIUC
//
//  Created by Tianyu Li on 10/24/16.
//  Copyright © 2016 Tianyu Li. All rights reserved.
//

import UIKit


protocol laundryFirstViewDelegate {
    func dismissFirstView()
    func pushToLaundryDetail(indexRow : Int)
}

let residentHallList = ["1107 West Green", "300 South Goodwin", "Allen", "Barton-Lundgren", "Bousfield Rm 103","Busey-Evans","Daniels North","Daniels South","FAR: Oglesby","FAR: Trelease","Hopkins","ISR: Townsend","ISR: Wardall","LAR: Leonard","LAR: Shelden","Nugent","Nugent Rm 126","Orchard Downs North","Orchard Downs South","PAR: Babcock","PAR: Blaisdell","PAR: Carr","PAR: Saunders","Scott","Sherman Short","Sherman Tall","Snyder","TVD: Taft","TVD: Van Doren","Wassaja Room 1109","Weston"]



class LaundryFirstView: UIView, UITableViewDelegate, UITableViewDataSource {
    var nameTableView : UITableView!
    var selectedResidentIndex : Int!
    var delegate : laundryFirstViewDelegate!
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: screen_width, height: screen_height))
        
        self.backgroundColor = UIColor.white
        self.selectedResidentIndex = nil
        
        nameTableView = UITableView(frame: CGRect(x: 30, y: 60, width: screen_width-60, height: screen_height-60), style: .plain)
        nameTableView.delegate = self
        nameTableView.dataSource = self
        nameTableView.separatorStyle = .none
        
        nameTableView.backgroundColor = UIColor.clear
        nameTableView.showsVerticalScrollIndicator = false
        nameTableView.contentInset = UIEdgeInsetsMake(0, 0, 80, 0)
        self.addSubview(nameTableView)
        
        
        
        let myBandView = UIView(frame: CGRect(x: 0, y: 0, width:screen_width,height: 80))
        myBandView.backgroundColor = greenTheme
        /*myBandView.layer.shadowColor = UIColor(white: 155.0/255, alpha: 0.9).cgColor
        myBandView.layer.shadowOffset = CGSize(width: 0.5, height: 2.0)
        myBandView.layer.shadowOpacity = 0.9*/
        self.addSubview(myBandView)
        
        let functionTitle = UILabel(frame: CGRect(x: 0, y: 20, width: screen_width, height: 60))
        let language = UserDefaults.standard.object(forKey: "language") as! String
        if language == "chinese"{
            functionTitle.text = "洗衣房"
        }else{
            functionTitle.text = "Laundry"
        }
        
        functionTitle.textColor = UIColor.white
        functionTitle.textAlignment = .center
        functionTitle.font = UIFont(name: "Avenir-Heavy", size: 19)
        myBandView.addSubview(functionTitle)
        
        
        let backBtn = UIButton(frame: CGRect(x: 0, y: 20, width: 60, height: 60))
        backBtn.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
        backBtn.addTarget(self, action: #selector(LaundryFirstView.backToDetail), for: .touchUpInside)
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20)
        self.addSubview(backBtn)
        

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return residentHallList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = residentHallList[indexPath.row]
        cell.textLabel?.textColor = UIColor(white: 155/255, alpha: 1.0)
        cell.textLabel?.font = UIFont(name: "Avenir-Medium", size: 18)
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 20, width: screen_width, height: 80))
        headerView.backgroundColor = UIColor.white
        let askingText = UILabel(frame: CGRect(x: 20, y: 20, width: screen_width, height: 80))
        askingText.textAlignment = .left
        askingText.textColor = UIColor(white: 155/255, alpha: 0.5)
        let language = UserDefaults.standard.object(forKey: "language") as! String
        if language == "chinese"{
            askingText.text = "你所在的宿舍是?"
        }else{
            askingText.text = "Where do you live?"
        }
        
        askingText.font = UIFont(name: "Avenir-Medium", size: 15)
        headerView.addSubview(askingText)
        
        
        return headerView
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        
        self.delegate.pushToLaundryDetail(indexRow: indexPath.row)
        
        
        
        
    }
    
    
    
    func backToDetail(){
        
        
        self.delegate.dismissFirstView()
        

        
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
