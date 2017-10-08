//
//  BusScheduleNetworkRequest.swift
//  BusSchedule
//
//  Created by Tianyu Li on 8/9/17.
//  Copyright © 2017 Tianyu Li. All rights reserved.
//

import Foundation



class BusScheduleNetworkRequest{
    
    static func getStopBy(lat : Double, lon : Double, completionHandler: @escaping (_ stops : Array<[String:Any]>)->Swift.Void){
        DispatchQueue.global(qos: .background).async {
            let urlStr = "https://developer.cumtd.com/api/v2.2/json/getstopsbylatlon?key=\(PlaceAPIKey)&lat=\(lat)&lon=\(lon)"
            if let url = URL(string: urlStr){
                let resultData = try? Data(contentsOf: url as URL)
                
                if let da = resultData{
                    let resultDic = try? JSONSerialization.jsonObject(with: da, options: .allowFragments)
                    if let result = resultDic as? [String : Any]{
                        DispatchQueue.main.async {
                            print(result["stops"]!)
                            let stopResult = result["stops"] as! Array<[String:Any]>
                            completionHandler(stopResult)
                            
                        }
                    }
                }
            }
        }
    }
    
    
    static func getDepartureByStop(stopId : String, completionHandler : @escaping (Array<[String:Any]>) -> Swift.Void){
        DispatchQueue.global(qos: .background).async {
            let urlStr = "https://developer.cumtd.com/api/v2.2/json/getdeparturesbystop?key=\(PlaceAPIKey)&stop_id=\(stopId)&pt=60"
            if let url = URL(string: urlStr){
                let resultData = try? Data(contentsOf: url as URL)
                
                if let da = resultData{
                    let resultDic = try? JSONSerialization.jsonObject(with: da, options: .allowFragments)
                    if let result = resultDic as? [String : Any]{
                        DispatchQueue.main.async {
                            //print(result["departures"]!)
                            let stopResult = result["departures"] as! Array<[String:Any]>
                            completionHandler(stopResult)
                            
                        }
                    }
                }
            }
        }
    }
    
    static func getDirectionByStops(from:String, to:String, completionHandler : @escaping (Array<[String : Any]>) -> Swift.Void){
        DispatchQueue.global(qos: .background).async {
            let fromText = from.replacingOccurrences(of: " ", with: "+")
            let toText = to.replacingOccurrences(of: " ", with: "+")
            let urlStr = "https://maps.googleapis.com/maps/api/directions/json?origin=\(fromText)&destination=\(toText)&mode=transit&key=\(DirectionAPIKey)"
            //print(urlStr)
            if let url = URL(string: urlStr){
                let resultData = try? Data(contentsOf: url as URL)
                
                if let da = resultData{
                    let resultDic = try? JSONSerialization.jsonObject(with: da, options: .allowFragments)
                    if let result = resultDic as? [String : Any]{
                        DispatchQueue.main.async {
                            let array = result["routes"] as! Array<Any>
                            let route = array[0] as! [String : Any]
                            let one = route["legs"] as! Array<Any>
                            let step = one[0] as! [String : Any]
                            //print(step["steps"]!)

                        }
                    }
                }
            }
        }
    }
    
    
    
    
}



