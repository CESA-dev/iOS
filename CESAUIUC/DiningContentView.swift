//
//  DiningContentView.swift
//  CESAUIUC
//
//  Created by Tianyu Li on 11/26/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import UIKit
import QuartzCore

class DiningContentView: UIView, UIGestureRecognizerDelegate {
    var imgView : UIImageView!
    var backgroundView : UIView!
    var menuView : UIView!
    private var back : Bool = false
    convenience init(restaurant : Dictionary<String,Any>, originX : Double) {
        self.init(frame: CGRect(x: originX, y: cardViewOriginY-20, width: cardViewWidth, height: cardViewHeight))
        if checkIphoneX(){
            self.frame = CGRect(x: originX, y: cardViewOriginY, width: cardViewWidth, height: cardViewHeight)
        }
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = 7.0
        
        
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: cardViewWidth, height: cardViewHeight))
        backgroundView.backgroundColor = UIColor.clear
        //backgroundView.layer.cornerRadius = 7.0
        //backgroundView.clipsToBounds = true
        //backgroundView.layer.borderColor = UIColor.blue.cgColor
        //backgroundView.layer.borderWidth = 0.3;
        
        backgroundView.layer.shadowColor = UIColor(white: 100.0/255, alpha: 1.0).cgColor
        backgroundView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        backgroundView.layer.shadowOpacity = 0.9
        backgroundView.layer.shadowRadius = 7.0
        //backgroundView.clipsToBounds = true
        //backgroundView.layer.masksToBounds = true
        self.addSubview(backgroundView)
        
        
        imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: cardViewWidth, height: cardViewHeight))
        //imgView.image = UIImage(named: restaurant["image"] as! String)
        imgView.image = #imageLiteral(resourceName: "nanjingbistro")
        let imageData : Data
        do{
            imageData = try Data.init(contentsOf: URL(string: restaurant["image"] as! String)!)
            imgView.image = UIImage(data: imageData)
        }catch{
            
        }
        
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 7.0
        backgroundView.addSubview(imgView)
        
        let mask = UIView(frame: imgView.frame)
        mask.backgroundColor = UIColor(white: 74.0/255, alpha: 1.0)
        mask.alpha = 0.8
        mask.layer.cornerRadius = 7.0
        backgroundView.addSubview(mask)
        
        
        
        
        let restName = UILabel(frame: CGRect(x: 0, y: self.frame.height/2 - 50, width: self.frame.width, height: 40))
        
        restName.text = restaurant["name"] as! String
        restName.backgroundColor = UIColor.clear
        restName.textAlignment = .center
        restName.textColor = UIColor.white
        restName.font = UIFont(name: "Avenir-Medium", size: 29)
        backgroundView.addSubview(restName)
        
        let type = UILabel(frame: CGRect(x: 0, y: Double(restName.frame.origin.y + restName.frame.height - 5), width: Double(self.frame.width), height: 30))
        type.text = restaurant["restType"] as! String
        type.textAlignment = .center
        type.textColor = UIColor(white: 200.0/255, alpha: 1.0)
        type.font = UIFont(name: "Avenir-Roman", size: 14)
        backgroundView.addSubview(type)
        
        
        menuView = DiningDetailView(data:restaurant)
        menuView.layer.masksToBounds = false

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    func flipCard(){
        
        
        
        if (back == false){
            UIView.transition(from: backgroundView, to: menuView, duration: 0.5, options: .transitionFlipFromLeft) { (bool) in
                self.back = true
          
                self.menuView.layer.shadowColor = UIColor(white: 210.0/255, alpha: 1.0).cgColor
                self.menuView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
                self.menuView.layer.shadowOpacity = 0.7
                self.menuView.layer.shadowRadius = 7.0
        
            }
        }else{
            UIView.transition(from: menuView, to: backgroundView, duration: 0.5, options: .transitionFlipFromLeft) { (bool) in
                self.back = false
                
                self.backgroundView.layer.shadowColor = UIColor(white: 100.0/255, alpha: 1.0).cgColor
                self.backgroundView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
                self.backgroundView.layer.shadowOpacity = 0.9
                self.backgroundView.layer.shadowRadius = 7.0

            }
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
