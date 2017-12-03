
//
//  DiningRandomView.swift
//  CESAUIUC
//
//  Created by Tianyu Li on 11/28/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import UIKit

class DiningRandomView: UIView {
    convenience init(randomResult : Dictionary<String,Any>) {
        self.init(frame: CGRect(x: 0, y: 0, width: screen_width, height: screen_height))
        self.backgroundColor = UIColor.black
        self.alpha = 0.9
        
        
        let diningContent = DiningContentView(restaurant: randomResult, originX: initialGap)
        self.addSubview(diningContent)
        
        
        
        
        
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
