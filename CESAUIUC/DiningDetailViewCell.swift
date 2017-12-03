//
//  DiningDetailViewCell.swift
//  CESAUIUC
//
//  Created by Tianyu Li on 11/27/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import UIKit

class DiningDetailViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    func createCell(dishInfo : Dictionary<String, Any>){
        let dishName = UILabel(frame: CGRect(x: 60.0, y: 0.0, width: cardViewWidth/2+20, height: Double(dishCellHeight)))
        dishName.text = dishInfo["dishName"] as? String
        dishName.textColor = UIColor(white: 155/255, alpha: 1.0)
        dishName.font = UIFont(name: "Avenir-Roman", size: 12)
        self.contentView.addSubview(dishName)
        
        
        let icon = UIImageView(frame: CGRect(x: 30.0, y: Double(dishCellHeight/2)-11.0, width: 20.0, height: 20.0))
        let type = dishInfo["type"] as! String
        if type == "lunch"{
            icon.frame = CGRect(x: 30.0, y: Double(dishCellHeight/2)-9.0, width: 20.0, height: 20.0)
        }
        icon.image = UIImage(named: type)
        icon.alpha = 0.6
        self.contentView.addSubview(icon)
        
    }

}
