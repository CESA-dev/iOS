//
//  RestView.swift
//  CESAUIUC
//
//  Created by Tianyu Li on 11/23/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import UIKit

protocol RestViewDelegate {
    func pushBackToMain()
}



var cardViewWidth = Double(0.70 * screen_width)
    

let cardViewHeight = Double(cardViewWidth*1.5)
let cardViewOriginY = screen_height/2 - (cardViewHeight)/2
let initialGap = Double(0.15 * screen_width)
let gap = Double(20)
let movingDistanceFactor = (cardViewWidth + gap)/screen_width

class RestView: UIView, UIScrollViewDelegate {
    var gestureScrollView : UIScrollView!
    var contentScrollView : UIScrollView!
    var infoScrollView : UIScrollView!
    var delegate : RestViewDelegate!
    var currentOffset : CGFloat = 0.0
    var lastOffset : CGFloat = 0.0
    var currentPage : Int = 0
    var cardViewArray : Array<DiningContentView>!
    var numberOfCard = 0.0
    var allData : Array<Dictionary<String,Any>>!
    var lastRandom : Int = 0
    init(data : Array<Dictionary<String,Any>>) {
        super.init(frame: CGRect(x: 0, y: 0, width: screen_width, height: screen_height))
        print("rest")
        numberOfCard = Double(data.count)
        cardViewArray = []
        allData = data
        
        
        gestureScrollView = UIScrollView(frame: CGRect(x: 0, y: cardViewOriginY, width: Double(self.frame.width), height: Double(self.frame.height)-cardViewOriginY))
        gestureScrollView.contentSize = CGSize(width: screen_width*numberOfCard, height: screen_height)
        
        gestureScrollView.isPagingEnabled = true
        gestureScrollView.showsHorizontalScrollIndicator = false
        gestureScrollView.showsVerticalScrollIndicator = false
        gestureScrollView.delegate = self
        self.addSubview(gestureScrollView)
        
        
        contentScrollView = UIScrollView(frame: self.frame)
        contentScrollView.contentSize = CGSize(width: initialGap + (numberOfCard*cardViewWidth) + ((numberOfCard-1) * gap), height: screen_height)
        contentScrollView.isUserInteractionEnabled = false
        
        contentScrollView.showsVerticalScrollIndicator = false
        contentScrollView.showsHorizontalScrollIndicator = false
        
        self.addSubview(contentScrollView)
        
        
        
        
        
        
        infoScrollView = UIScrollView(frame: CGRect(x: 0, y: cardViewOriginY + cardViewHeight, width: screen_width, height: screen_height-cardViewOriginY-cardViewHeight))
        infoScrollView.contentSize = CGSize(width: screen_width*numberOfCard, height: Double(infoScrollView.frame.height))
        infoScrollView.isUserInteractionEnabled = false
        infoScrollView.showsVerticalScrollIndicator = false
        infoScrollView.showsHorizontalScrollIndicator = false
        
        self.addSubview(infoScrollView)
        
        
        loadViewToContent(data: data)
        
        let title = UILabel(frame: CGRect(x: initialGap, y: 60, width: 200, height: 40))
        let language = UserDefaults.standard.object(forKey: "language") as! String
        if language == "chinese"{
            title.text = "菜单推荐"
        }else{
            title.text = "Restaurant"
        }
        
        title.textColor = UIColor(white: 120.0/255, alpha: 1.0)
        title.font = UIFont(name: "Avenir-Medium", size: 28)
        self.addSubview(title)
        
        
        let randomBtn = UIButton(frame: CGRect(x: screen_width-100, y: 60, width: 70, height: 45))
        randomBtn.addTarget(self, action: #selector(self.randomlyGenerateChoice), for: .touchUpInside)
        self.addSubview(randomBtn)
        
        let randomLabel = UILabel(frame: CGRect(x: 0, y: randomBtn.frame.height/2-14, width: 70, height: 25))
        
        if language == "chinese"{
            randomLabel.text = "选择困难"
        }else{
            randomLabel.text = "Random"
        }
        
        randomLabel.textColor = orangePinkDarkTheme
        randomLabel.textAlignment = .center
        randomLabel.layer.cornerRadius = 3.0
        randomLabel.font = UIFont(name: "PingFangTC-Regular", size: 10)
        randomLabel.layer.borderColor = orangePinkDarkTheme.cgColor
        randomLabel.layer.borderWidth = 1
        randomBtn.addSubview(randomLabel)
        

        
        let backBtn = UIButton(frame: CGRect(x: 10, y: 57, width: 45, height: 45))
        backBtn.setImage(#imageLiteral(resourceName: "newBack"), for: .normal)
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13)
        backBtn.addTarget(self, action: #selector(self.backToMain), for: .touchUpInside)
        self.addSubview(backBtn)
        
        if !checkIphoneX(){
            title.frame = CGRect(x: initialGap, y: 25, width: 200, height: 40)
            backBtn.frame = CGRect(x: 7, y: 22.5, width: 45, height: 45)
            randomBtn.frame = CGRect(x: screen_width-100, y: 23, width: 70, height: 45)
        }
   
        let addressBtn = UIButton(frame: CGRect(x: screen_width/4, y: (cardViewOriginY+cardViewHeight) + (screen_height-(cardViewOriginY+cardViewHeight))/2 - 20, width: screen_width/2, height: 30))
        addressBtn.backgroundColor = UIColor.clear
        addressBtn.addTarget(self, action: #selector(self.showAddressInMap), for: .touchUpInside)
        self.addSubview(addressBtn)
        
  
        self.createResponseCard()
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ScrollView Delegate
    func loadViewToContent(data : Array<Dictionary<String,Any>>){
        for i in 0...Int(numberOfCard-1) {
            
            let contentView = DiningContentView(restaurant: data[i], originX: initialGap + gap * Double(i) + cardViewWidth * Double(i))
            self.contentScrollView.addSubview(contentView)
            
            cardViewArray.append(contentView)
            
            
            let infoView = DiningInfoView(restaurant: data[i],originX: screen_width * Double(i))
            self.infoScrollView.addSubview(infoView)
            
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView == gestureScrollView){
            let offY = CGFloat(0)
            let offX = scrollView.contentOffset.x * CGFloat(movingDistanceFactor)
            contentScrollView.setContentOffset(CGPoint(x:offX,y:offY), animated: false)
            infoScrollView.setContentOffset(CGPoint(x:scrollView.contentOffset.x, y: 0), animated: false)
        }
    }
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView == gestureScrollView){
            currentPage = Int(scrollView.contentOffset.x/CGFloat(screen_width))
            print(currentPage)
        }
    }
    
    
    
    
    
    
    //MARK: button
    func backToMain(){
        
        self.delegate.pushBackToMain()
    }
    
    func showAddressInMap(){
        
        let targetLocation = allData[self.currentPage]
        let targetAddress = targetLocation["addressURL"] as! String
        let urlString = "http://maps.apple.com/?q=" + targetAddress
        
        let adddressUrl = URL(string: urlString)
        UIApplication.shared.openURL(adddressUrl!)
    }
    
    
    func randomlyGenerateChoice(){
        var ramdomNumber = arc4random() % UInt32(numberOfCard)
        while ramdomNumber == lastRandom {
            ramdomNumber = arc4random() % UInt32(numberOfCard)
        }
        print(ramdomNumber)
        
        self.gestureScrollView.setContentOffset(CGPoint(x:Double(ramdomNumber) * screen_width,y:0), animated: true)
        lastRandom = Int(ramdomNumber)
        currentPage = Int(ramdomNumber)
    }
    
    
    //MARK: UI
    
    func createResponseCard(){
        let tapResponse = UITapGestureRecognizer(target: self, action: #selector(self.responseBtnPress(recognizer:)))
        self.gestureScrollView.addGestureRecognizer(tapResponse)
    }
    
    func responseBtnPress(recognizer: UITapGestureRecognizer){
        print("press")

        let tapLocation = recognizer.location(in: self)
        
        if ((tapLocation.y > CGFloat(cardViewOriginY)) && (tapLocation.y < CGFloat(cardViewOriginY + cardViewHeight))){
            let currentCard = cardViewArray[currentPage]
            currentCard.flipCard()
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
