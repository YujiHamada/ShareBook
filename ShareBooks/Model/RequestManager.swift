//
//  RequestManager.swift
//  ShareBooks
//
//  Created by 濱田裕史 on 2019/09/11.
//  Copyright © 2019 濱田裕史. All rights reserved.
//

import Foundation
import Foundation
import Alamofire
import FirebaseAuth

struct RequestManager {
    static let shared = RequestManager()
    private init() {}
    
    func request<T:Codable>(api: Api, parameters: Parameters? = nil, completion: @escaping (Swift.Result<T, Error>) -> Void) {
        let currentUser = Auth.auth().currentUser
        if let currentUser = currentUser {
            currentUser.getIDTokenForcingRefresh(true) { idToken, error in
                if let error = error {
                    print(error)
                    return;
                }
                let headers: HTTPHeaders = [
                    "Authorization": idToken ?? ""
                ]
                self.request(api: api,parameters: parameters, headers: headers, completion: completion)
            }
        } else {
            self.request(api: api,parameters: parameters, headers: nil, completion: completion)
        }
    }
    
    private func request<T:Codable>(api: Api, parameters: Parameters? = nil, headers: HTTPHeaders?, completion: @escaping (Swift.Result<T, Error>) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(api.url(), method: .get, parameters: parameters, headers: headers).responseJSON { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let error = response.error {
                completion(.failure(error))
                return
            }
            
            let responseDictionay: [String : Any] = response.result.value as! [String : Any]
            let responseStatus = self.getStatus(obj: responseDictionay["status"]!)
            if responseStatus.isSuccess() {
                let jsonData = try! JSONSerialization.data(withJSONObject: responseDictionay[api.parameterKey()]!, options: .prettyPrinted)
                let reqJSONStr = String(data: jsonData, encoding: .utf8)
                let data = reqJSONStr?.data(using: .utf8)
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let decoder: JSONDecoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(formatter)
                let object = try! decoder.decode(T.self, from: data!)
                completion(.success(object))
            } else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : responseDictionay["status"] as? String ?? "エラーが発生しました"])
                completion(.failure(error))
            }
        }
    }
    
    func request(api: Api, parameters: Parameters? = nil, completion: @escaping (Swift.Result<Dictionary<String, Any>, Error>) -> Void) {
        let currentUser = Auth.auth().currentUser
        if let currentUser = currentUser {
            currentUser.getIDTokenForcingRefresh(true) { idToken, error in
                if let error = error {
                    print(error)
                    return;
                }
                let headers: HTTPHeaders = [
                    "Authorization": idToken ?? ""
                ]
                self.requestDictionary(api: api,parameters: parameters, headers: headers, completion: completion)
            }
        } else {
            self.requestDictionary(api: api,parameters: parameters, headers: nil, completion: completion)
        }
    }
    
    private func requestDictionary(api: Api, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Swift.Result<Dictionary<String, Any>, Error>) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(api.url(), method: .get, parameters: parameters, headers: headers).responseJSON { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let error = response.error {
                completion(.failure(error))
                return
            }
            
            let responseDictionay: [String : Any] = response.result.value as! [String : Any]
            let responseStatus = self.getStatus(obj: responseDictionay["status"]!)
            if responseStatus.isSuccess() {
                completion(.success(responseDictionay))
            } else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : responseDictionay["status"] as? String ?? "エラーが発生しました"])
                completion(.failure(error))
            }
        }
    }
    
    func requestStatus(api: Api, parameters: Parameters? = nil, completion: @escaping (Swift.Result<Bool, Error>) -> Void) {
        let currentUser = Auth.auth().currentUser
        if let currentUser = currentUser {
            currentUser.getIDTokenForcingRefresh(true) { idToken, error in
                if let error = error {
                    print(error)
                    return;
                }
                let headers: HTTPHeaders = [
                    "Authorization": idToken ?? ""
                ]
                self.requestStatus(api: api,parameters: parameters, headers: headers, completion: completion)
            }
        } else {
            self.requestStatus(api: api,parameters: parameters, headers: nil, completion: completion)
        }
    }
    
    private func requestStatus(api: Api, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, completion: @escaping (Swift.Result<Bool, Error>) -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(api.url(), method: .get, parameters: parameters, headers: headers).responseJSON { response in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if let error = response.error {
                completion(.failure(error))
                return
            }
            
            let responseDictionay: [String : Any] = response.result.value as! [String : Any]
            let responseStatus = self.getStatus(obj: responseDictionay["status"]!)
            if responseStatus.isSuccess() {
                completion(.success(true))
            } else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : responseStatus.errorMessage ?? "エラーが発生しました"])
                completion(.failure(error))
            }
        }
    }
    
    private func getStatus(obj: Any) -> ResponseStatus{
        let jsonData = try! JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
        let reqJSONStr = String(data: jsonData, encoding: .utf8)
        let data = reqJSONStr?.data(using: .utf8)
        let jsonDecoder = JSONDecoder()
        let responseStatus = try! jsonDecoder.decode(ResponseStatus.self, from: data!)
        return responseStatus
    }
}
