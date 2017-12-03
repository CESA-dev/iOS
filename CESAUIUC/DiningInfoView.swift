//
//  DiningInfoView.swift
//  CESAUIUC
//
//  Created by Tianyu Li on 11/26/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import UIKit

class DiningInfoView: UIView {
    convenience init(restaurant : Dictionary<String,Any>, originX : Double) {
        self.init(frame: CGRect(x: originX, y: 0, width: screen_width, height: screen_height-(cardViewOriginY+cardViewHeight)))
        
        
        
        
        let time = UILabel(frame: CGRect(x: 0, y: self.frame.height/2 - 50, width: self.frame.width, height: 30))
        time.text = restaurant["time"] as! String
        time.textAlignment = .center
        time.textColor = UIColor(white: 150.0/255, alpha: 1.0)
        time.font = UIFont(name: "Avenir-Roman", size: 13)
        self.addSubview(time)
        
        let address = UIButton(frame: CGRect(x: screen_width/2-75, y: Double(self.frame.height/2-20), width: 150, height: 30.0))
        address.setTitle(restaurant["address"] as! String, for: .normal)
        address.setTitleColor(orangePinkTheme, for: .normal)
        address.titleLabel?.textAlignment = .center
        address.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 13)
        let fitSize = address.titleLabel?.text?.size(attributes: [NSFontAttributeName: address.titleLabel?.font]) ?? .zero
        
        address.layer.borderColor = orangePinkTheme.cgColor
        address.layer.borderWidth = 1.5
        address.layer.cornerRadius = 3.0
        
        address.frame = CGRect(x: screen_width/2-Double(fitSize.width*1.5)/2, y: Double(self.frame.height/2-20), width: Double(fitSize.width*1.5), height: 30.0)
        self.addSubview(address)
        
        
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
