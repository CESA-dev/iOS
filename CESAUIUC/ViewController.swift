//
//  ViewController.swift
//  CESAUIUC
//
//  Created by Tianyu Li on 10/23/16.
//  Copyright © 2016 Tianyu Li. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase





class ViewController: UIViewController, mainMenuViewDelegate, CESALanguageViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        self.view.layer.cornerRadius = 3.0
        
        
        
        let launchBefore = UserDefaults.standard.bool(forKey: "launchBe")
        if launchBefore{
            print("not first launch")
            
            
            
            let mainMenu = CESAMainMenuView()
            mainMenu.delegate = self
            self.view.addSubview(mainMenu)
            
            
            
            
        }else{
            print("first launch")
            UserDefaults.standard.set(true, forKey: "launchBe")
            let languageView = CESALanguageView(frame: self.view.frame)
            languageView.delegate = self
            self.view.addSubview(languageView)
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func pushFunctionPage(identifier : String){
        
        if identifier == "foo"{
            return
        }
        
        let functionPage = self.storyboard?.instantiateViewController(withIdentifier: identifier)
        self.navigationController?.pushViewController(functionPage!, animated: true)
        
//        if row == 0{
//            let functionPage = self.storyboard?.instantiateViewController(withIdentifier: "laundry")
//            self.navigationController?.pushViewController(functionPage!, animated: true)
//        }else if row == 1{
//            let functionPage = self.storyboard?.instantiateViewController(withIdentifier: "post")
//            self.navigationController?.pushViewController(functionPage!, animated: true)
//        }else if row == 4{
//            let functionPage = self.storyboard?.instantiateViewController(withIdentifier: "ews")
//            self.navigationController?.pushViewController(functionPage!, animated: true)
//        }
        
    }
    
    
    func finishSelectingLanguage(){
        
        
        
        
        
        let mainMenu = CESAMainMenuView()
        mainMenu.delegate = self
        self.view.addSubview(mainMenu)
    }

    
    func showChangeLanguagePage(){
        let languageView = CESALanguageView(frame: self.view.frame)
        languageView.delegate = self
        self.view.addSubview(languageView)
    }
    
    
    
    
    


}






