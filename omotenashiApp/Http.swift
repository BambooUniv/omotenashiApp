//
//  Http.swift
//  omotenashiApp
//
//  Http通信を管理するクラス
//

import Foundation
import UIKit

class Http {
    
    // URLと辞書型配列からNSMutableURLRequestを作成する関数
    class func createPostRequest(url: String, params: Dictionary <String, String>) -> NSMutableURLRequest {
        let url = NSURL(string: url)
        let req = NSMutableURLRequest(URL: url!)
        req.HTTPMethod = "POST"
        req.HTTPBody = generateQueryStringFromDictionary(params).dataUsingEncoding(NSUTF8StringEncoding)
        
        return req
    }
    
    
    // 辞書型からhttpBodyを作成する関数
    class func generateQueryStringFromDictionary(params: Dictionary <String, String>) -> String {
        let pairs = NSMutableArray()
        
        for (key, value) in params {
            pairs.addObject("\(key)=\(value)")
        }
        
        let queryString = pairs.componentsJoinedByString("&")
        return queryString
    }
}
