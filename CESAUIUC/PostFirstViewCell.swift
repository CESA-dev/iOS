//
//  PostFirstViewCellTableViewCell.swift
//  CESAUIUC
//
//  Created by Tianyu Li on 2/12/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import UIKit

class PostFirstViewCell : UITableViewCell {

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

    
    func initCellView(info : [String:Any]){
//        let readDot = UIView(frame: CGRect(x: 25-5, y: 27, width: 10, height: 10))
//        readDot.backgroundColor = orangeTheme
//        readDot.layer.cornerRadius = 5
//        let readOrNot : Bool = info["read"]
//        if (readOrNot){
//            self.addSubview(readDot)
//        }
        
        let cardView = UIView(frame: CGRect(x: 15.0, y: 7.0, width: Double(screen_width-30), height: 120-14))
        cardView.backgroundColor = UIColor.white
        cardView.layer.shadowColor = UIColor(white: 220.0/255, alpha: 1.0).cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cardView.layer.shadowOpacity = 0.9
        
        self.contentView.addSubview(cardView)
        
        let postTitle = UITextView(frame: CGRect(x: 30, y: 7, width: cardView.frame.width-100, height: 53))
        postTitle.text = info["title"] as! String?
        postTitle.textColor = UIColor(white: 101/255, alpha: 1.0)
        postTitle.font = UIFont(name: "Avenir-Medium", size: 17)
        postTitle.isEditable = false
        postTitle.isSelectable = false
        //postTitle.isScrollEnabled = false
        postTitle.showsVerticalScrollIndicator = false
        cardView.addSubview(postTitle)
        
        /*let postDetail = UILabel(frame: CGRect(x: 30, y: 38, width: self.contentView.frame.width-70, height: 25))
        postDetail.text = info["detail"] as! String?
        postDetail.textColor = UIColor(white: 84/255, alpha: 1.0)
        postDetail.font = UIFont(name: "Avenir-Book", size: 12)
        cardView.addSubview(postDetail)*/
        
        let authorLabel = UILabel(frame: CGRect(x: 30, y: Double(cardView.frame.height - 35), width: 100, height: 20))
        authorLabel.backgroundColor = UIColor(red: 239/255, green: 88/255, blue: 106/255, alpha: 1.0)
        authorLabel.text = info["companyName"] as! String?
        authorLabel.textColor = UIColor.white
        authorLabel.textAlignment = .center
        authorLabel.font = UIFont(name: "Avenir-Heavy", size: 11)
        authorLabel.layer.cornerRadius = 2.0
        authorLabel.clipsToBounds = true
        let fitSize = authorLabel.text?.size(attributes: [NSFontAttributeName: authorLabel.font]) ?? .zero
        authorLabel.frame = CGRect(x: 33.0, y: Double(cardView.frame.height - 35), width: Double(fitSize.width) + 20.0, height: 20.0)
        cardView.addSubview(authorLabel)
        
        
        let dayLabel = UILabel(frame: CGRect(x: Double(cardView.frame.width)-50-50-10, y: Double(authorLabel.frame.origin.y), width: 80, height: 20))
        dayLabel.textAlignment = .right
        dayLabel.text = info["location"] as! String?
        dayLabel.textColor = UIColor(white: 155/255, alpha: 1.0)
        dayLabel.font = UIFont(name: "Avenir-Book", size: 10)
        cardView.addSubview(dayLabel)

    }

    
    
}
