//
//  SearchByRouteResultView.swift
//  BusSchedule
//
//  Created by Tianyu Li on 8/16/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import UIKit


protocol SearchByRouteResultDelegate {
    func updateSelection(address : String)
}

class SearchByRouteResultView: UIView{//, UITableViewDelegate, UITableViewDataSource {
    /*var resultTableView : UITableView!
    var resultArray : Array<GMSAutocompletePrediction> = []
    var delegate : SearchByRouteResultDelegate!
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(originX : Double, originY : Double){
        self.init(frame: CGRect(x: originX, y: originY, width: Double(screen_width)-originX*2, height: Double(screen_height) - originY))
        self.backgroundColor = UIColor.white
        self.layer.shadowColor = UIColor(white: 220.0/255, alpha: 1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowOpacity = 0.9
        
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI(){
        resultTableView = UITableView(frame: CGRect(x:0, y:0, width: self.frame.width, height: self.frame.height), style: .plain)
        resultTableView.backgroundColor = UIColor.white
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.register(SearchByRouteResultCell.classForCoder(), forCellReuseIdentifier: "Cell")
        resultTableView.separatorInset = .zero
        resultTableView.separatorColor = UIColor(white: 240.0/255, alpha: 1.0)
        resultTableView.contentInset = UIEdgeInsetsMake(0, 0, 300, 0)
        resultTableView.showsVerticalScrollIndicator = false
        self.addSubview(resultTableView)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SearchByRouteResultCell(style: .default, reuseIdentifier: "Cell")
        print(resultArray[indexPath.row].attributedFullText)
        cell.createCellUI(prediction: resultArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)
        self.delegate.updateSelection(address: (cell?.textLabel?.text)!)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
     
 */

}
