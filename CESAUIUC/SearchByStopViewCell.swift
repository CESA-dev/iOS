//
//  SearchByStopViewCell.swift
//  BusSchedule
//
//  Created by Tianyu Li on 8/9/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import UIKit

class SearchByStopViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func createCard(stopName : String, distance : NSNumber){
        let cardView = UIView(frame: CGRect(x: 25.0, y: 7.0, width: Double(screen_width-50), height: stopCellHeight-14))
        cardView.backgroundColor = UIColor.white
        cardView.layer.shadowColor = UIColor(white: 220.0/255, alpha: 1.0).cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cardView.layer.shadowOpacity = 0.9
        
        self.contentView.addSubview(cardView)
        
        let stopNameLabel = UILabel(frame: CGRect(x: 20, y: 0, width: cardView.frame.width/3 * 2 - 20, height: cardView.frame.height))
        stopNameLabel.textColor = brownDarkTheme
        stopNameLabel.text = stopName
        stopNameLabel.font = UIFont(name: "Avenir-Medium", size: 15)
        cardView.addSubview(stopNameLabel)
        
        
        let stopDistanceLabel = UILabel(frame: CGRect(x: cardView.frame.width/3 * 2, y: 0, width: cardView.frame.width/3-20, height: cardView.frame.height))
        stopDistanceLabel.text = "\(distance.intValue) ft"
        stopDistanceLabel.textAlignment = .right
        stopDistanceLabel.font = UIFont(name: "Avenir-Medium", size: 12)
        stopDistanceLabel.textColor = UIColor(white: 160.0/255, alpha: 1.0)
        cardView.addSubview(stopDistanceLabel)
        
    }
    
    

}
