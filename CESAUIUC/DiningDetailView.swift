//
//  DiningDetailView.swift
//  CESAUIUC
//
//  Created by Tianyu Li on 11/27/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import UIKit

let dishCellHeight = 45

class DiningDetailView: UIView, UITableViewDelegate, UITableViewDataSource {
    var menuArray : Array<Dictionary<String, Any>>!
    
    convenience init(data : Dictionary<String, Any>) {
        self.init(frame: CGRect(x: 0, y: 0, width: cardViewWidth, height: cardViewHeight))
        
        menuArray = data["dish"] as! Array<Dictionary<String, Any>>
        
        let menuTableView = UITableView(frame: CGRect(x: 0, y: 0, width: cardViewWidth, height: cardViewHeight), style: .plain)
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.separatorStyle = .none
        menuTableView.layer.cornerRadius = 7.0
        menuTableView.contentInset = UIEdgeInsetsMake(90, 0, 0, 0)
        self.addSubview(menuTableView)
        
        let title = UILabel(frame: CGRect(x: 30, y: 30, width: 200, height: 30))
        title.text = data["name"] as! String
        title.font = UIFont(name: "Avenir-Roman", size: 20)
        title.textColor = UIColor(white: 155/255, alpha: 1.0)
        self.addSubview(title)
        
        
        
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DiningDetailViewCell(style: .default, reuseIdentifier: "Cell")
        let cellDic = menuArray[indexPath.row]
        cell.createCell(dishInfo: cellDic)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(dishCellHeight)
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
