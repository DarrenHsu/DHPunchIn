//
//  FeedManager.swift
//  DHPunchIn
//
//  Created by Darren Hsu on 08/05/2017.
//  Copyright © 2017 SKL. All rights reserved.
//

import UIKit
import AFNetworking

extension Data {
    public func length() -> Int {
        var value = [UInt8](repeating:0, count:self.count)
        self.copyBytes(to: &value, count: self.count)
        return value.count
    }
}

let DEFAULT_DNS: String = "http://788697ad.ngrok.io/"

class FeedManager: NSObject {

    private static var _manager: FeedManager?
    
    public static func sharedInstance() -> FeedManager {
        if _manager == nil {
            _manager = FeedManager()
            _manager?.resetDns()
        }
        return _manager!
    }
    
    public var Dns = DEFAULT_DNS
    private let configuration = URLSessionConfiguration.default
    
    public func resetDns() {
        let userDefault = UserDefaults.standard
        if userDefault.object(forKey: DNS_KEY) != nil {
            Dns = userDefault.object(forKey: DNS_KEY) as! String
        }
    }
    
    public func requestImage(_ urlStr: String, success: ((UIImage) -> ())?, failure: (() ->())?)  {
        let url = URL(string: urlStr)
        
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        
        doRequest(request) { (response, result, error) in
            if result != nil {
                success?(UIImage(data: result as! Data)!)
            }else {
                failure?()
            }
        }
    }
    
    public func requestUploadStaff(_ staff: Staff, success: (([Staff]?) -> ())?, failure: (() ->())?)  {
        let dict = staff.toDict();
        let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let url = URL(string: "\(Dns)/api/employees/\(staff.staffId!)")
        
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        doRequest(request) { (response, result, error) in
            if error == nil {
                success?(self.convertToStaffs(result))
            }else {
                failure?()
            }
        }
    }

    
    public func requestRemoveStaff(_ staff: Staff, success: ((Staff) -> ())?, failure: (() ->())?)  {
        let url = URL(string: "\(Dns)/api/employees/\(staff.staffId!)")
        
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        request.httpMethod = "DELETE"
        
        doRequest(request) { (response, result, error) in
            if self.checkResult(result) {
                success?(staff)
            }else {
                failure?()
            }
        }
    }

    
    public func requestStaff(_ staffId: String, success: ((Staff) -> ())?, failure: (() ->())?)  {
        let url = URL(string: "\(Dns)/api/employees/\(staffId)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)

        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        
        doRequest(request) { (response, result, error) in
            if error == nil {
                let s = self.convertToStaffs(result)
                if s.count > 0 {
                    success?(s.first!)
                }else {
                    failure?()
                }
            }else {
                failure?()
            }
        }
    }
    
    public func requestAddStaff(_ staff: Staff, success: ((Staff) -> ())?, failure: (() ->())?)  {
        let dict = staff.toDict();
        let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let url = URL(string: "\(Dns)/api/employees")
        
        var request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        doRequest(request) { (response, result, error) in
            if self.checkResult(result) {
                success?(staff)
            }else {
                failure?()
            }
        }
    }
    
    public func requestAllStaff(_ success: (([Staff]?) -> ())?, failure: (() ->())?)  {
        let url = URL(string: "\(Dns)/api/employees")
        
        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        
        doRequest(request) { (response, result, error) in
            if error == nil {
                success?(self.convertToStaffs(result))
            }else {
                failure?()
            }
        }
    }
    
    
    private func checkResult(_ data: Any?) -> Bool {
        do {
            let dict = try JSONSerialization.jsonObject(with: data as! Data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, String>
            let content = dict["Content"]
            if content == "success" {
                return true
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return false
    }
    
    private func convertToStaffs(_ result: Any?) -> [Staff] {
        if (result as! Data).length() == 0 {
            return []
        }
        
        let obj = self.convertToArray(data: result)
        let staffs = Staff.parse(x: obj)
        return staffs
    }
    
    private func convertToArray(data: Any?) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data as! Data, options: JSONSerialization.ReadingOptions.allowFragments)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    private func doRequest(_ request: URLRequest, handle: ((URLResponse, Any?, Error?) -> ())?) {
        let manager = AFURLSessionManager(sessionConfiguration: configuration)
        manager.responseSerializer = AFHTTPResponseSerializer()
        print("<------------------------------ request ------------------------------->")
        print("URL: \(request.url!)")
        print("METHOD: \(request.httpMethod!)")
        if request.httpBody != nil {
            print("BODY: \(String(data: request.httpBody!, encoding: .utf8)!)")
        }
        print("<------------------------------ request ------------------------------->")
        
        let dataTask = manager.dataTask(with: request) { (response, result, error) in
            print("<------------------------------ response ------------------------------>")
            print("URL: \(response.url!)")
            if error == nil {
                let res = response as! HTTPURLResponse
                print("STATUS CODE: \(res.statusCode)")
                print("MIME: \(res.mimeType!)")
                switch(res.mimeType!) {
                case "image/png":
                    print("CONTENT: Image Data")
                    break
                case "text/plain":
                    print("CONTENT: Empty")
                    break
                case "application/json":
                    print("CONTENT: \n \(String(data: result as! Data, encoding: .utf8)!)")
                default:
                    print("CONTENT: Other Content")
                    break
                }
            }else {
                print("ERROR: \(error!.localizedDescription)")
            }
            
            handle?(response, result, error)
            print("<------------------------------ response ------------------------------>")
        }
        
        dataTask.resume()
    }
}
