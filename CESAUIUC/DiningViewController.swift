//
//  DiningViewController.swift
//  CESAUIUC
//
//  Created by Tianyu Li on 3/5/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import UIKit
import FirebaseDatabase

protocol diningViewVCDelegate {
    func refreshDetail()
}

/*let dataArray = [["name":"Teamoji","image":"teamoji","restType": "Bakeries, Bubble Tea", "dish" : [["dishName" : "Cheese Float Green Tea", "type":"iceDrink"],
                                                    ["dishName" : "Signature Fruit Tea", "type":"iceDrink"],
                                                    ["dishName" : "Chip & Fish", "type":"snack"],
                                                    ["dishName" : "Shaked Iced Tea", "type":"iceDrink"],
                                                    ["dishName" : "Egg Waffle", "type":"dessert"]], "time" : "10 AM to Midnight", "address" : "617 E Green St", "addressURL":"teamoji"],
                 ["name":"Kung Fu Tea","image":"kungfuCha","restType": "Bubble Tea, Juice Bars", "dish" : [["dishName" : "Kung Fu Milk Tea", "type":"iceDrink"],
                                                    ["dishName" : "Taro Slush with Oreo", "type":"iceDrink"],
                                                    ["dishName" : "Oolong Milk Tea", "type":"iceDrink"],
                                                    ["dishName" : "Oreo Wow Milk", "type":"iceDrink"],
                                                    ["dishName" : "Poke Bowls", "type":"lunch"],
                                                    ["dishName" : "Sushi Burrito", "type":"lunch"]], "time" : "11 AM to Midnight", "address" : "707 S 6th St, Ste 107","addressURL":"kungfu+tea"]]*/


class DiningViewController: UIViewController, RestViewDelegate {
    var delegate : diningViewVCDelegate!
    var dataArray : Array<Dictionary<String,Any>>!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let diningListView = DiningListView()
        diningListView.delegate = self
        self.view.addSubview(diningListView)*/
        
        loadData()
        
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func pushToDiningDetail(indexRow: Int) {
        UserDefaults.standard.set(indexRow, forKey: "diningIndex")
        
        //refresh
        self.delegate.refreshDetail()
        
        self.dismiss(animated: true) {
            
            
        }
        
        
    }
    
    func dismissFirstView(){
        self.dismiss(animated: true) { 
            
            
        }
    }
    
    func pushBackToMain() {
        _ = self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    
    
    //MARK:network requesr
    func loadData(){
        print("Info Loading...")
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.center = CGPoint(x: screen_width/2, y: screen_height/2)
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        //download
        var ref = Database.database().reference(withPath: "dining")
        
        let language = UserDefaults.standard.object(forKey: "language") as! String
        if language == "chinese"{
            ref = Database.database().reference(withPath: "diningCH")
        }
        
        ref.observe(.value, with:{ snapshot in
            self.dataArray = snapshot.value as! Array<Dictionary<String,Any>>
            
            
            let restView = RestView(data : self.dataArray)
            restView.delegate = self
            restView.alpha = 0.0
            self.view.addSubview(restView)
            
            print("Done")
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                restView.alpha = 1.0
                
            }) { (Bool) in
                
            }
        })
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
