//
//  BusScheduleEmptyState.swift
//  BusSchedule
//
//  Created by Tianyu Li on 8/18/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import UIKit

class BusScheduleEmptyState: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(yOrigin: Double, emptyImageName: String, emptyText : String){
        self.init(frame: CGRect(x: 0, y: yOrigin, width: Double(screen_width), height: Double(screen_height)-yOrigin))
        self.createUI(emptyImageName: emptyImageName, emptyText: emptyText)
        self.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI(emptyImageName: String, emptyText : String){
        let emptyImage = UIImageView(frame: CGRect(x: self.frame.width/2 - 50, y: self.frame.height/2-150, width: 100, height: 100))
        emptyImage.image = UIImage(named: emptyImageName)
        //emptyImage.backgroundColor = UIColor.blue
        self.addSubview(emptyImage)
        
        let emptyLabel = UILabel(frame: CGRect(x: 0, y: Double(emptyImage.frame.origin.y + emptyImage.frame.height+20), width: Double(screen_width), height: 40))
        emptyLabel.text = emptyText
        emptyLabel.font = UIFont(name: "Avenir-Book", size: 15)
        emptyLabel.textColor = UIColor(white: 141.0/255, alpha: 1.0)
        emptyLabel.textAlignment = .center
        self.addSubview(emptyLabel)
        
        
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
