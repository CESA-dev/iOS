//
//  SearchByRouteView.swift
//  BusSchedule
//
//  Created by Tianyu Li on 8/8/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import UIKit



protocol SearchByRouteViewDelegate {
    func fadeBar()
    func showBar()
}

class SearchByRouteView: UIView, UITextFieldDelegate{//, SearchByRouteResultDelegate {
    /*var cardView : UIView!
    var delegate : SearchByRouteViewDelegate!
    var fromTextField : UITextField!
    var toTextField : UITextField!
    var searchBtn : UIButton!
    var cancelBtn : UIButton!
    var resultView : SearchByRouteResultView!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    convenience init(yOrigin : Double){
        self.init(frame: CGRect(x: 0, y: 0, width: Double(screen_width), height: Double(screen_height)))
        self.backgroundColor = UIColor.white
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI(){
        self.createCardView()
        
        searchBtn = UIButton(frame: CGRect(x: 25, y: Double(cardView.frame.origin.y + cardView.frame.height + 60), width: screen_width-50, height: 50))
        searchBtn.layer.cornerRadius = 3.0
        searchBtn.backgroundColor = orangeTheme
        searchBtn.setTitle("Search", for: .normal)
        searchBtn.setTitleColor(UIColor.white, for: .normal)
        searchBtn.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 16)
        self.addSubview(searchBtn)
        
        
        
        
    }
    
    
    func createCardView(){
        cardView = UIView(frame: CGRect(x: 25, y: barHeight + 60, width: screen_width-50, height: 180))
        cardView.backgroundColor = UIColor.white
        cardView.layer.shadowColor = UIColor(white: 220.0/255, alpha: 1.0).cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cardView.layer.shadowOpacity = 0.9
        self.addSubview(cardView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.startSearch))
        cardView.addGestureRecognizer(tapGesture)
        
        let lineWidth = Double(cardView.frame.width * 0.55)
        let line = UIView(frame: CGRect(x: (Double(cardView.frame.width)-lineWidth)/2, y: Double(cardView.frame.height/2), width: lineWidth, height: 1))
        line.backgroundColor = UIColor(white: 200.0/255, alpha: 1.0)
        cardView.addSubview(line)
        
        
        let fromDot = UIView(frame: CGRect(x: Double(line.frame.origin.x/2-3), y: Double(line.frame.origin.y - 20 - 3), width: 6, height: 6))
        fromDot.layer.cornerRadius = 3
        fromDot.layer.borderColor = UIColor(white: 200.0/255, alpha: 1.0).cgColor
        fromDot.layer.borderWidth = 1.0
        fromDot.backgroundColor = UIColor.clear
        cardView.addSubview(fromDot)
        
        let toDot = UIView(frame: CGRect(x: Double(line.frame.origin.x/2-3), y: Double(line.frame.origin.y + 20 - 3+5), width: 6, height: 6))
        toDot.layer.cornerRadius = 3
        toDot.backgroundColor = UIColor(white: 200.0/255, alpha: 1.0)
        cardView.addSubview(toDot)
        
        fromTextField = UITextField(frame: CGRect(x: Double(line.frame.origin.x+10), y: Double(line.frame.origin.y-40), width: lineWidth, height: 40))
        fromTextField.placeholder = "From"
        fromTextField.font = UIFont(name: "Avenir-Roman", size: 18)
        fromTextField.textColor = orangeTheme
        fromTextField.isUserInteractionEnabled = false
        fromTextField.delegate = self
        fromTextField.returnKeyType = .search
        cardView.addSubview(fromTextField)
        
        toTextField = UITextField(frame: CGRect(x: Double(line.frame.origin.x+10), y: Double(line.frame.origin.y+5), width: lineWidth, height: 40))
        toTextField.placeholder = "Destination"
        toTextField.font = UIFont(name: "Avenir-Roman", size: 18)
        toTextField.textColor = orangeTheme
        toTextField.isUserInteractionEnabled = false
        toTextField.delegate = self
        toTextField.returnKeyType = .search
        cardView.addSubview(toTextField)
    }
    
    func createCancelBtn(){
        cancelBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        cancelBtn.backgroundColor = UIColor.blue
        cancelBtn.addTarget(self, action: #selector(self.cancelBtnPress), for: .touchUpInside)
        self.cardView.addSubview(cancelBtn)
    }
    
    func createResult(){
        resultView = SearchByRouteResultView(originX: Double(self.cardView.frame.origin.x), originY: Double(self.cardView.frame.origin.y * 2 + self.cardView.frame.height))
        resultView.delegate = self
        self.addSubview(resultView)
        resultView.alpha = 0.0
        resultView.isUserInteractionEnabled = false
    }
    
    
    func startSearch(){
        self.delegate.fadeBar()

        UIView.animate(withDuration: 0.4, animations: {
            self.cardView.frame = CGRect(x: 25, y: 30, width: screen_width-50, height: 180)
            self.searchBtn.alpha = 0.0
        }) { (finish) in
            self.createResult()
            self.createCancelBtn()
            self.fromTextField.isUserInteractionEnabled = true
            self.toTextField.isUserInteractionEnabled = true
            self.fromTextField.becomeFirstResponder()
        }
    }
    
    
    func cancelBtnPress(){
        self.fromTextField.resignFirstResponder()
        self.toTextField.resignFirstResponder()
        self.fromTextField.isUserInteractionEnabled = false
        self.toTextField.isUserInteractionEnabled = false
        self.cancelBtn.removeFromSuperview()
        self.resultView.removeFromSuperview()
        UIView.animate(withDuration: 0.4, animations: {
            self.cardView.frame = CGRect(x: 25, y: barHeight + 60, width: screen_width-50, height: 180)
            self.searchBtn.alpha = 1.0
        }) { (finish) in
            self.delegate.showBar()
        }
    }
    
    //MARK: delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("start")
        self.resultView.resultArray = []
        self.resultView.resultTableView.reloadData()
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField.text?.characters.count)! < 1{
            resultView.alpha = 0.0
            resultView.isUserInteractionEnabled = false
        }else{
            //print("change")
            resultView.alpha = 1.0
            resultView.isUserInteractionEnabled = true
            
            let bottomRight = CLLocationCoordinate2D(latitude: 40.025363, longitude: -88.153610)
            let topLeft = CLLocationCoordinate2D(latitude: 40.167708, longitude: -88.330078)
            let searchBounds = GMSCoordinateBounds(coordinate: topLeft, coordinate: bottomRight)
            let filter = GMSAutocompleteFilter()
            filter.type = .noFilter
            GMSPlacesClient.shared().autocompleteQuery(textField.text!, bounds: searchBounds, filter: filter) { (result, error) in
                //print(result ?? [])
                self.resultView.resultArray = result!
                self.resultView.resultTableView.reloadData()
            }

        }
        
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("search direction")
        BusScheduleNetworkRequest.getDirectionByStops(from: self.fromTextField.text!, to: self.toTextField.text!) { (result) in
        }
        
        return true
    }
    
    
    func updateSelection(address : String) {
        self.resultView.resultArray = []
        self.resultView.resultTableView.reloadData()

        if self.fromTextField.isFirstResponder{
            self.fromTextField.text = address
        }else{
            self.toTextField.text = address
        }
    }
    /*func creatViews(){
        let searchTextField = UITextField(frame: CGRect(x: 10, y: 20, width: screen_width-20, height: 30))
        searchTextField.delegate = self
        searchTextField.borderStyle = .bezel
        self.addSubview(searchTextField)
        
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("change")
        return true
    }
    
    
    
    
    
    func searchText(text : String) -> Array<Any>{
        let urlStr = "https://www.cumtd.com/autocomplete/stops/v1.0/json/search?query=\(text)"
        if let url = URL(string: urlStr){
            let resultData = try? Data(contentsOf: url as URL)
            
            if let da = resultData{
                let resultDic = try? JSONSerialization.jsonObject(with: da, options: .allowFragments)
                if let result = resultDic{
                    
                    return result as! Array<Any>
                }
            }
        }
        
        return []
    }*/
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
 */

}
