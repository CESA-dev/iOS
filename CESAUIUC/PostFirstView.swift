//
//  PostFirstView.swift
//  CESAUIUC
//
//  Created by Tianyu Li on 2/12/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import UIKit
import Firebase

/*let postInfo = [["read" : true, "title":"Brand Promoters/Sales","detail":"OWL Communications Academy is a pioneering provider and explorer of public speaking training and leadership development coaching.","author":"WL Global Corp","location":"Wall Street, NY"],
                ["read" : true, "title":"大数据平台开发专家/架构师","detail":"OWL Communications Academy is a pioneering provider and explorer of public speaking training and leadership development coaching.","author":"蚂蚁金服","location":"杭州"],
                ["read" : false, "title":"图像搜索专家/高级专家","detail":"OWL Communications Academy is a pioneering provider and explorer of public speaking training and leadership development coaching.","author":"蚂蚁金服","location":"杭州"],
                ["read" : false, "title":"Data Analyst Intern","detail":"OWL Communications Academy is a pioneering provider and explorer of public speaking training and leadership development coaching.","author":"中国建筑","location":"Jersey City, NJ"]]*/


protocol postFirstViewDelegate {
    func pushBackToMainMenu()
    func pushToPostDetail(url : String)
}

class PostFirstView: UIView, UITableViewDelegate, UITableViewDataSource  {
    var postTableView : UITableView!
    var delegate : postFirstViewDelegate!
    var postInfo : Array<Any>!
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: screen_width, height: screen_height))
        
        self.backgroundColor = UIColor.white
        postInfo = []
        
        postTableView = UITableView(frame: CGRect(x: 0, y: 80, width: screen_width, height: screen_height-80), style: .plain)
        postTableView.delegate = self
        postTableView.dataSource = self
        postTableView.separatorStyle = .singleLine
        postTableView.separatorColor = UIColor(white: 200/255, alpha: 1.0)
        postTableView.register(PostFirstViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        postTableView.backgroundColor = UIColor.clear
        postTableView.showsVerticalScrollIndicator = false
        postTableView.contentInset = UIEdgeInsetsMake(10, 0, 80, 0)
        postTableView.separatorStyle = .none
        postTableView.alpha = 0.0
        self.addSubview(postTableView)
        
        
        
        let myBandView = UIView(frame: CGRect(x: 0, y: 0, width:screen_width,height: 80))
        myBandView.backgroundColor = blueDarkTheme
        /*myBandView.layer.shadowColor = UIColor(white: 155.0/255, alpha: 0.9).cgColor
        myBandView.layer.shadowOffset = CGSize(width: 0.5, height: 2.0)
        myBandView.layer.shadowOpacity = 0.9*/
        self.addSubview(myBandView)
        
        let functionTitle = UILabel(frame: CGRect(x: 0, y: 20, width: screen_width, height: 60))
        let language = UserDefaults.standard.object(forKey: "language") as! String
        if language == "chinese"{
            functionTitle.text = "找工作"
        }else{
            functionTitle.text = "Job Finder"
        }
        
        functionTitle.textColor = UIColor.white
        functionTitle.textAlignment = .center
        functionTitle.font = UIFont(name: "Avenir-Heavy", size: 19)
        myBandView.addSubview(functionTitle)
        
        
        let backBtn = UIButton(frame: CGRect(x: 0, y: 20, width: 60, height: 60))
        backBtn.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        backBtn.addTarget(self, action: #selector(PostFirstView.backToMainMenu), for: .touchUpInside)
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20)
        self.addSubview(backBtn)
        
        /// confirm Btn
        //        let confirmBtn = UIButton(frame: CGRect(x: screen_width-120, y: screen_height-80, width: 90, height: 50))
        //        confirmBtn.backgroundColor = UIColor(red: 115/255, green: 225/255, blue: 119/255, alpha: 1.0)
        //        confirmBtn.layer.cornerRadius = 25
        //        confirmBtn.setTitle("Confirm", for: .normal)
        //        confirmBtn.titleLabel?.textAlignment = .center
        //        confirmBtn.titleLabel?.textColor = UIColor.white
        //        confirmBtn.titleLabel?.font = UIFont(name: "Avenir-Light", size: 15)
        //        self.addSubview(confirmBtn)
        
        self.loadData()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postInfo.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PostFirstViewCell(style: .default, reuseIdentifier: "Cell")
        
        
        cell.initCellView(info: postInfo[indexPath.row] as! Dictionary<String,Any>)
        
        //full width for cell seperator
        cell.preservesSuperviewLayoutMargins = false
        //cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        
        
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = postInfo[indexPath.row] as! Dictionary<String,Any>
        print(cell["url"] ?? 0)
        self.delegate.pushToPostDetail(url: cell["url"] as! String)
        
        
    }
    
    
    
    
    
    func backToMainMenu(){
        
        self.delegate.pushBackToMainMenu()
        
    }
    
    
    func loadData(){
        print("Info Loading...")
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.center = CGPoint(x: screen_width/2, y: screen_height/2)
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    
        //download
        let ref = Database.database().reference(withPath: "jobFinder")
        ref.observe(.value, with:{ snapshot in
            let jobList = snapshot.value as! Array<Any>
            print(jobList)
            self.postInfo = jobList
            
            print("Done")
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            self.postTableView.reloadData()
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                self.postTableView.alpha = 1.0
                
            }) { (Bool) in
                
            }
        })

    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
