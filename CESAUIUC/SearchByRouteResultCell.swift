//
//  SearchByRouteResultCell.swift
//  BusSchedule
//
//  Created by Tianyu Li on 8/16/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import UIKit


class SearchByRouteResultCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /*func createCellUI(prediction : GMSAutocompletePrediction){
        //let searchPredictionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 44))
        //searchPredictionLabel.text = text
        //searchPredictionLabel.textColor = orangeTheme
        //self.contentView.addSubview(searchPredictionLabel)
        self.textLabel?.textColor = orangeTheme
        self.highLightText(label: self.textLabel!, prediction: prediction)
    }
    
    func highLightText(label : UILabel, prediction : GMSAutocompletePrediction){
        let regularFont = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        let boldFont = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        
        let bolded = prediction.attributedFullText.mutableCopy() as! NSMutableAttributedString
        bolded.enumerateAttribute(kGMSAutocompleteMatchAttribute, in: NSMakeRange(0, bolded.length), options: []) {
            (value, range: NSRange, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            let font = (value == nil) ? regularFont : boldFont
            bolded.addAttribute(NSFontAttributeName, value: font, range: range)
        }
        
        self.textLabel?.attributedText = bolded
    }
 
 */

}
