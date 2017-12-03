//
//  CESAMainMenuView.swift
//  CESAUIUC
//
//  Created by Tianyu Li on 10/23/16.
//  Copyright © 2016 Tianyu Li. All rights reserved.
//

import UIKit


protocol mainMenuViewDelegate {
    func pushFunctionPage(identifier : String)
    func showChangeLanguagePage()
}


let screen_width = Double(UIScreen.main.bounds.size.width)
let screen_height = Double(UIScreen.main.bounds.size.height)
let orangeTheme = UIColor(red: 255/255, green: 174/255, blue: 79/255, alpha: 1.0)
let greenTheme = UIColor(red: 163/255, green: 216/255, blue: 212/255, alpha: 1.0)
let greenDarkTheme = UIColor(red: 121/255, green: 171/255, blue: 167/255, alpha: 1.0)
let brownTheme = UIColor(red: 220/255, green: 202/255, blue: 198/255, alpha: 1.0)
let brownDarkTheme = UIColor(red: 183/255, green: 158/255, blue: 153/255, alpha: 1.0)
let orangePinkTheme = UIColor(red: 247/255, green: 204/255, blue: 187/255, alpha: 1.0)
let orangePinkDarkTheme = UIColor(red: 209/255, green: 164/255, blue: 146/255, alpha: 1.0)
let blueTheme = UIColor(red: 193/255, green: 228/255, blue: 252/255, alpha: 1.0)
let blueDarkTheme = UIColor(red: 145/255, green: 177/255, blue: 199/255, alpha: 1.0)
let purpleTheme = UIColor(red: 226/255, green: 211/255, blue: 234/255, alpha: 1.0)
let purpleDarkTheme = UIColor(red: 165/255, green: 153/255, blue: 172/255, alpha: 1.0)


func checkIphoneX() -> Bool{
    if UIScreen.main.nativeBounds.height == 2436{
        return true
    }
    return false
}



let functionMenu = [["functionName" : "Restaurant",
                     "functionIcon" : "dining",
                     "functionIdentifier" : "dining",
                     "functionDescrip" : "Menu recommendation",
                     "functionColor" : orangePinkTheme,
                     "functionDetailColor" : orangePinkDarkTheme],
                    ["functionName" : "Find a Job",
                     "functionIcon" : "job",
                     "functionIdentifier" : "post",
                     "functionDescrip" : "A great place for finding jobs",
                     "functionColor" : blueTheme,
                     "functionDetailColor" : blueDarkTheme],
                    ["functionName" : "Laundry",
                     "functionIcon" : "laundry",
                     "functionIdentifier" : "laundryDetail",
                     "functionDescrip" : "Laundry device usage",
                     "functionColor" : greenTheme,
                     "functionDetailColor" : greenDarkTheme],
                    ["functionName" : "Transportation",
                     "functionIcon" : "bus",
                     "functionIdentifier" : "bus",
                     "functionDescrip" : "Check MTD bus departure time",
                     "functionColor" : brownTheme,
                     "functionDetailColor" : brownDarkTheme],
                    
                    ["functionName" : "EWS",
                     "functionIcon" : "ews",
                     "functionIdentifier" : "ews",
                     "functionDescrip" : "EWS Status",
                     "functionColor" : purpleTheme,
                     "functionDetailColor" : purpleDarkTheme],
                   /* ["functionName" : "Job Finder",
                     "functionIcon" : "ews",
                     "functionIdentifier" : "job",
                     "functionDescrip" : "Looking for job"],*/]


let functionMenuCH = [["functionName" : "菜单推荐",
                     "functionIcon" : "dining",
                     "functionIdentifier" : "dining",
                     "functionDescrip" : "您的点菜小助手",
                     "functionColor" : orangePinkTheme,
                     "functionDetailColor" : orangePinkDarkTheme],
                    ["functionName" : "找工作",
                     "functionIcon" : "job",
                     "functionIdentifier" : "post",
                     "functionDescrip" : "每周更新的招聘信息",
                     "functionColor" : blueTheme,
                     "functionDetailColor" : blueDarkTheme],
                    ["functionName" : "洗衣房",
                     "functionIcon" : "laundry",
                     "functionIdentifier" : "laundryDetail",
                     "functionDescrip" : "查看学校宿舍的洗衣机使用情况",
                     "functionColor" : greenTheme,
                     "functionDetailColor" : greenDarkTheme],
                    ["functionName" : "公交时刻表",
                     "functionIcon" : "bus",
                     "functionIdentifier" : "bus",
                     "functionDescrip" : "查看下一辆车还有多久到",
                     "functionColor" : brownTheme,
                     "functionDetailColor" : brownDarkTheme],
                    
                    ["functionName" : "EWS",
                     "functionIcon" : "ews",
                     "functionIdentifier" : "ews",
                     "functionDescrip" : "帮你查EWS有没有空位",
                     "functionColor" : purpleTheme,
                     "functionDetailColor" : purpleDarkTheme],
                    /* ["functionName" : "Job Finder",
     "functionIcon" : "ews",
     "functionIdentifier" : "job",
     "functionDescrip" : "Looking for job"],*/]




class CESAMainMenuView: UIView, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    var menuTableView : UITableView!
    var delegate : mainMenuViewDelegate!
    var schoolLogo: UIButton!
    var logoTitle : UILabel!
    let defaultOffset : CGFloat = -130
    var functionMenuArray : Array<Dictionary<String,Any>>!
    var changeLang : UIButton!
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: screen_width, height: screen_height))
        self.backgroundColor = UIColor(white: 255.0/255, alpha: 1.0)//orangeTheme
        self.layer.cornerRadius = 3
        self.clipsToBounds = true
        //self.fadeCreate()
        
        let language = UserDefaults.standard.object(forKey: "language") as! String
        if language == "chinese"{
            functionMenuArray = functionMenuCH
        }else{
            functionMenuArray = functionMenu
        }
        
        self.createMainUI()
        
        
        
        
    }
    
    
    func createMainUI(){
        schoolLogo = UIButton(frame: CGRect(x: screen_width/2 - 60, y: 0, width: 120, height: 120))
        if checkIphoneX(){
            schoolLogo.frame = CGRect(x: screen_width/2 - 60, y: 20, width: 120, height: 120)
        }
        schoolLogo.setImage(#imageLiteral(resourceName: "unicorn"), for: .normal)
        schoolLogo.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        schoolLogo.alpha = 0.6
        schoolLogo.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        self.addSubview(schoolLogo)
        
        
        
        
        logoTitle = UILabel(frame: CGRect(x: screen_width/2 - 50, y: Double(schoolLogo.frame.height)-20, width: 100, height: 30))
        logoTitle.text = "Uni-Corn"
        logoTitle.font = UIFont(name: "Avenir-Heavy", size: 11)
        logoTitle.textColor = UIColor(white: 220/255, alpha: 1.0)
        logoTitle.textAlignment = .center
        logoTitle.alpha = 0.0
        self.addSubview(logoTitle)
        
        UIView.animate(withDuration: 0.3/1.0, delay: 1.0, options: .curveEaseOut, animations: {
            self.schoolLogo.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
        }) { (Bool) in
            UIView.animate(withDuration: 0.3/1.5, animations: {
                self.schoolLogo.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
            }) { (Bool) in
                
                UIView.animate(withDuration: 0.3/2, animations: {
                    self.schoolLogo.transform = CGAffineTransform.identity
                }) { (Bool) in
                    
                    if checkIphoneX(){
                        self.logoTitle.frame = CGRect(x: screen_width/2 - 50, y: 120, width: 100, height: 30)
                    }else{
                        self.logoTitle.frame = CGRect(x: screen_width/2 - 50, y: Double(self.schoolLogo.frame.height)-20, width: 100, height: 30)
                    }
                    UIView.animate(withDuration: 0.5, animations: {
                        self.logoTitle.alpha = 1.0
                        if checkIphoneX(){
                            self.logoTitle.frame = CGRect(x: screen_width/2 - 50, y: 120-30+20, width: 100, height: 30)
                        }else{
                            self.logoTitle.frame = CGRect(x: screen_width/2 - 50, y: Double(self.schoolLogo.frame.height)-30, width: 100, height: 30)
                        }
                        
                    })
                    
                    
                    self.menuTableView = UITableView(frame: CGRect(x: 0, y: 0, width: screen_width, height: screen_height), style: .plain)
                    self.menuTableView.delegate = self
                    self.menuTableView.dataSource = self
                    self.menuTableView.register(CESAMainMenuTableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
                    self.menuTableView.separatorStyle = .none
                    self.menuTableView.backgroundColor = UIColor.clear
                    self.menuTableView.showsVerticalScrollIndicator = false
                    self.menuTableView.contentInset = UIEdgeInsetsMake(110, 0, 0, 0)
                    
                    self.addSubview(self.menuTableView)
                    
                    
                    self.changeLang = UIButton(frame: self.schoolLogo.frame)
                    self.changeLang.addTarget(self, action: #selector(self.changeLanguage), for: .touchUpInside)
                    self.addSubview(self.changeLang)
                    
                    
                    
                }
                
            }
        }
        
        
        
        
        let madeTitle = UILabel(frame: CGRect(x: screen_width/2 - 50, y: screen_height-35, width: 100, height: 30))
        madeTitle.text = "Made by CESA"
        madeTitle.font = UIFont(name: "Avenir-Medium", size: 11)
        madeTitle.textColor = UIColor(white: 220/255, alpha: 1.0)
        madeTitle.textAlignment = .center
        self.addSubview(madeTitle)
        
        
        if checkIphoneX(){
            madeTitle.frame = CGRect(x: screen_width/2 - 50, y: screen_height-45, width: 100, height: 30)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return functionMenuArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CESAMainMenuTableViewCell(style: .default, reuseIdentifier: "Cell")
        
        //cell.textLabel?.text = functionMenu[indexPath.row]
        
        cell.initCardView(function:functionMenuArray[indexPath.row], index : indexPath.row)
        
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        

        ///////这里要改成每个view有一个viewcontroller！！！！！！！！！！！！！
        print(functionMenuArray[indexPath.row]["functionIdentifier"]!)
        self.delegate.pushFunctionPage(identifier: functionMenuArray[indexPath.row]["functionIdentifier"]! as! String)
        

        
        
    }
    
    
    
    func fadeCreate(){
        let topOrange : UIColor = UIColor(red: 244/255, green: 173/255, blue: 97/255, alpha: 1.0)
        let bottomRed : UIColor = UIColor(red: 235/255, green: 100/255, blue: 95/255, alpha: 1.0)
        
        let fadeBottom = UIView(frame: CGRect(x: 0, y: 0, width: screen_width, height: screen_height))
        fadeBottom.backgroundColor = topOrange
        fadeBottom.isUserInteractionEnabled = false
        fadeBottom.layer.cornerRadius = 4.0
        self.addSubview(fadeBottom)
        
        
        
        
        
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.frame = fadeBottom.bounds
        gradientLayer.colors = [
            topOrange.cgColor,
            bottomRed.cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0);
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0);
        // Use the gradient layer as the mask
        fadeBottom.layer.mask = gradientLayer;
        
    }
    
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        
        
        
        
        let offsetY = scrollView.contentOffset.y
        print(offsetY)
        
        
        
        
        
        
        
        if offsetY > defaultOffset{
            let diff = offsetY - defaultOffset
            schoolLogo.alpha = 1-((1/100)*diff)-0.4
            logoTitle.alpha = 1-((1/100)*diff)
            if self.changeLang != nil{
                self.changeLang.isEnabled = false
            }
            
        }else if offsetY > (defaultOffset+100){
            schoolLogo.alpha = 0.0
            logoTitle.alpha = 0.0
        }else{
            schoolLogo.alpha = 0.6
            logoTitle.alpha = 1.0
            if self.changeLang != nil{
                self.changeLang.isEnabled = true
            }
        }
    }
    
    
    func changeLanguage(){
        self.delegate.showChangeLanguagePage()
        self.removeFromSuperview()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
