//
//  APIClient.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-05.
//

import Foundation
import Alamofire
import Stripe

class APIClient: NSObject, STPCustomerEphemeralKeyProvider {
    
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        let parameters = ["api_version" : apiVersion]
                AF.request(URL(string: "http://10.0.0.33:8888/StripeBackend/empheralkey.php")!, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: [:]).responseData { (apiResponse) in
                    let data = apiResponse.data
                    guard let json = ((try? JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]) as [String : Any]??) else {
                        completion(nil, apiResponse.error)
                        return
                    }
                    completion(json, nil)
                }
    }
    
    class func createCustomer() {
            
            var customerDetailParams = [String : String]()
            customerDetailParams["email"] = "tes675t@gmail.com"
            customerDetailParams["phone"] = "8888888888"
            customerDetailParams["name"] = "test"
            
            AF.request(URL(string: "http://10.0.0.33:8888/StripeBackend/createcustomer.php")!, method: .post, parameters: customerDetailParams, encoding: URLEncoding.default, headers: nil).responseData { response in
                switch response.result {
                    case .success(_):
                        debugPrint(response.data!)
                        print()
                    case .failure(_):
                        debugPrint(response.error!)
                        debugPrint(response.debugDescription)
                    }
            }
        }
    
    class func createPaymentIntent(amount:Double,currency:String,customerId:String,completion:@escaping (Result<String, Error>)->Void) {
            //        createpaymentintent.php
            AF.request(URL(string: "http://10.0.0.33:8888/StripeBackend/createpaymentintent.php")!, method: .post, parameters: ["amount": amount,"currency": currency,"customerId": customerId], encoding: URLEncoding.default, headers: nil).responseData { (response) in
                switch response.result {
                    case .success(_):
                        let data = response.data
                        guard let json = ((try? JSONSerialization.jsonObject(with: data!, options: []) as? [String : String]) as [String : String]??) else {
                            completion(.failure(response.error!))
                            return
                        }
                            completion(.success(json!["clientSecret"]!))
                        
                    case .failure(_):
                        completion(.failure(response.error!))
                }
            }
        }
}
