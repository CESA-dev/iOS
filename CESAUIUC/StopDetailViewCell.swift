//
//  StopDetailViewCell.swift
//  BusSchedule
//
//  Created by Tianyu Li on 8/10/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import UIKit

class StopDetailViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func createCard(headSignName : String, direction : String, time : Int){
        let cardView = UIView(frame: CGRect(x: 25.0, y: 7.0, width: Double(screen_width-50), height: 97-14))
        cardView.backgroundColor = UIColor.white
        cardView.layer.shadowColor = UIColor(white: 220.0/255, alpha: 1.0).cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cardView.layer.shadowOpacity = 0.9
        
        self.contentView.addSubview(cardView)
        
        let busNameLabel = UILabel(frame: CGRect(x: 20, y: 0, width: cardView.frame.width/3 * 2, height: cardView.frame.height/3 * 2 + 5))
        busNameLabel.textColor = brownDarkTheme
        busNameLabel.text = headSignName
        busNameLabel.font = UIFont(name: "Avenir-Medium", size: 15)
        cardView.addSubview(busNameLabel)
        
        
        let directionLabel = UILabel(frame: CGRect(x: 20, y: busNameLabel.frame.height-20, width: cardView.frame.width/3*2, height: cardView.frame.height-busNameLabel.frame.height))
        directionLabel.text = "Heading \(direction)"
        directionLabel.textAlignment = .left
        directionLabel.font = UIFont(name: "Avenir-Roman", size: 12)
        directionLabel.textColor = UIColor(white: 160.0/255, alpha: 1.0)
        cardView.addSubview(directionLabel)
        
        let timeLabel = UILabel(frame: CGRect(x: cardView.frame.width/3 * 2 + 40, y: cardView.frame.height/2 - 15, width: 50, height: 30))
        timeLabel.layer.cornerRadius = 5.0
        timeLabel.backgroundColor = orangeTheme
        timeLabel.text = "\(time) mins"
        if time <= 1{
            timeLabel.text = "\(time) min"
        }
        timeLabel.textColor = UIColor.white
        timeLabel.textAlignment = .center
        timeLabel.font = UIFont(name: "Avenir-Medium", size: 10)
        timeLabel.clipsToBounds = true
        cardView.addSubview(timeLabel)
        
    }

}
