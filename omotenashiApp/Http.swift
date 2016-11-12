//
//  Http.swift
//  omotenashiApp
//
//  Http通信を管理するクラス
//

import Foundation
import UIKit

class Http {
    /*
    class func createPostRequest(url: String, params: Dictionary <String, String>) -> NSMutableURLRequest {
        
    }
    */
    
    
    
    // 辞書型からhttpBodyを作成する関数
    class func generateQueryStringFromDictionary(params: Dictionary <String, String>) -> String {
        let pairs = NSMutableArray()
        
        for (key, value) in params {
            pairs.addObject("\(key)=\(value)")
        }
        
        let queryString = pairs.componentsJoinedByString("&")
        print(queryString)
        return queryString
    }
}
