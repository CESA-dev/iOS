//
//  CESAMainMenuTableViewCell.swift
//  CESAUIUC
//
//  Created by Tianyu Li on 10/23/16.
//  Copyright © 2016 Tianyu Li. All rights reserved.
//

import UIKit

class CESAMainMenuTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCardView(function : [String:Any], index : Int){
        
        let cardView = UIView(frame: CGRect(x: 25, y: 13.5, width: screen_width-50, height: 85))
        cardView.backgroundColor = function["functionColor"] as? UIColor
        cardView.layer.cornerRadius = 5
        /*cardView.layer.shadowOffset = CGSize(width: 0.7, height: 0.3)
        cardView.layer.shadowColor = UIColor(white: 140/255, alpha: 1.0).cgColor
        cardView.layer.shadowOpacity = 0.50
        cardView.layer.shadowRadius = 3*/
        cardView.alpha = 0.0
        self.addSubview(cardView)
        
        UIView.animate(withDuration: 0.3, delay: 0.3*Double(index+1), options: .curveEaseOut, animations: {
            cardView.alpha = 1.0
            cardView.frame = CGRect(x: 25, y: 7.5, width: screen_width-50, height: 85)
        }) { (Bool) in
            
        }
        
        
        let functionIcon = UIImageView(frame: CGRect(x: 24, y: 25, width: 33, height: 33))
        functionIcon.backgroundColor = UIColor.clear
        functionIcon.image = UIImage(named: function["functionIcon"]! as! String)
        cardView.addSubview(functionIcon)
        
        let functionLabel = UILabel(frame: CGRect(x: 80, y: 22.5, width: 200, height: 20))
        functionLabel.text = function["functionName"]! as? String
        functionLabel.textColor = UIColor.white
        functionLabel.font = UIFont(name: "Avenir-Heavy", size: 16)
        cardView.addSubview(functionLabel)
        
        let functionDescrip = UILabel(frame: CGRect(x: 80, y: 42.5, width: 200, height: 20))
        functionDescrip.text = function["functionDescrip"]! as? String
        functionDescrip.textColor = function["functionDetailColor"] as? UIColor
        functionDescrip.font = UIFont(name: "Avenir-Medium", size: 12)
        cardView.addSubview(functionDescrip)
        
    }
    
    
    

}
