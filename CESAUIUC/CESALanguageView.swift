//
//  CESALanguageView.swift
//  CESAUIUC
//
//  Created by Tianyu Li on 11/29/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import UIKit

protocol CESALanguageViewDelegate {
    func finishSelectingLanguage()
}

class CESALanguageView: UIView {
    var delegate : CESALanguageViewDelegate!
    var chineseButton : UIButton!
    var englishButton : UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        chineseButton = UIButton(frame: CGRect(x: 0, y: 140, width: screen_width, height: 40))
        chineseButton.backgroundColor = UIColor.clear
        chineseButton.addTarget(self, action: #selector(self.selectChinese), for: .touchUpInside)
        chineseButton.setTitle("中文", for: .normal)
        chineseButton.setTitleColor(UIColor(white:150.0/255,alpha:1.0), for: .normal)
        chineseButton.setTitleColor(UIColor(white:150.0/255,alpha:1.0), for: .selected)
        chineseButton.alpha = 0.0
        chineseButton.titleLabel?.font = UIFont(name: "PingFangTC-Medium", size: 14)
        self.addSubview(chineseButton)
        
        englishButton = UIButton(frame: CGRect(x: 0, y: 190, width: screen_width, height: 40))
        englishButton.backgroundColor = UIColor.clear
        englishButton.addTarget(self, action: #selector(self.selectEnglish), for: .touchUpInside)
        englishButton.setTitle("English", for: .normal)
        englishButton.setTitleColor(UIColor(white:150.0/255,alpha:1.0), for: .normal)
        englishButton.setTitleColor(UIColor(white:150.0/255,alpha:1.0), for: .selected)
        englishButton.alpha = 0.0
        englishButton.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 14)
        self.addSubview(englishButton)
        
        
        
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseOut, animations: {
            self.chineseButton.alpha = 1.0
            self.chineseButton.frame = CGRect(x: 0, y: 120, width: screen_width, height: 40)
            
        }) { (finish) in
            
        }
        
        
        
        UIView.animate(withDuration: 0.3, delay: 0.4, options: .curveEaseOut, animations: {
            self.englishButton.alpha = 1.0
            self.englishButton.frame = CGRect(x: 0, y: 170, width: screen_width, height: 40)
        }) { (finish) in
            
        }
        
        
    }
    
    
    func selectChinese(){
        
        UIView.animate(withDuration: 0.3, animations: {
            self.chineseButton.alpha = 0.0
            self.chineseButton.frame = CGRect(x: 0, y: 100, width: screen_width, height: 40)
            
        }) { (finish) in
            
        }
        
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseOut, animations: {
            self.englishButton.alpha = 0.0
            self.englishButton.frame = CGRect(x: 0, y: 150, width: screen_width, height: 40)
        }) { (finish) in
            UserDefaults.standard.set("chinese", forKey: "language")
            self.delegate.finishSelectingLanguage()
            self.removeFromSuperview()
        }

        
    }
    
    
    func selectEnglish(){
        
        UIView.animate(withDuration: 0.3, animations: {
            self.chineseButton.alpha = 0.0
            
            self.chineseButton.frame = CGRect(x: 0, y: 100, width: screen_width, height: 40)
            
        }) { (finish) in
            
        }
        
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseOut, animations: {
            self.englishButton.alpha = 0.0
            self.englishButton.frame = CGRect(x: 0, y: 150, width: screen_width, height: 40)
        }) { (finish) in
            UserDefaults.standard.set("english", forKey: "language")
            self.delegate.finishSelectingLanguage()
            self.removeFromSuperview()
        }
        
        
        
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
