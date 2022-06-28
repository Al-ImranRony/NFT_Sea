//
//  API_Handler.swift
//  NFTSea
//
//  Created by iRny - Bitmorpher 4 on 6/27/22.
//

import Foundation
import UIKit
import SwiftyJSON

struct Arguments {
    var arg1 = ""
    var arg2 = ""
    var arg3 = ""
}

struct ResponseStruct {
    var Result: String = ""
    var Timestamp: Int = 0
    var Data = Any.self
    var Raw: String = ""
    var Response = ""
    var Error = ""
}

class APIHandler: NSObject {
    private var apiURL = ""
    private var apiKey = ""
    
    private var available = false
    public var args = Arguments()
    public var responseObj = ResponseStruct()
    
    
    init(apiURL: String, apiKey: String) {
        self.apiURL = apiURL
        self.apiKey = apiKey
    }
    
    
    public func getRequestCall() -> ResponseStruct {
        let apiUrl = apiURL
        let url = URL(string: apiUrl)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                self.responseObj.Error = error.localizedDescription
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Error ! Status: \(response)")
                self.responseObj.Response = String(describing: response)
                return
            }
            
            if let data = data {
                do {
                    let jsonData = try? JSON(data: data)
                    print("Dataj: \(jsonData?.arrayValue)")
//                    DispatchQueue.main.async {
//                        if let dataDictionary = jsonData {
//                            self.responseObj.Data = dataDictionary["DATA"] as! Any.Protocol
//                            self.responseObj.Result = dataDictionary["RESULT"] as! String
//                            self.responseObj.Timestamp = dataDictionary["TIMESTAMP"] as! Int
//                            self.responseObj.Raw = String(data: data, encoding: .utf8)!
//                        }
//                    }
                } catch {
                    print("error occured.", error.localizedDescription)
                }
            }
        }
        task.resume()
        
        return responseObj
    }
}
