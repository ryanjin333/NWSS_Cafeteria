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
    
    //Local Variables
    private static let ip = "10.0.0.33"
    private static let apachePortNumber = "80"
    //private static var counter = 1
    
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        
        var createCustomerParams = [String: String]()
        createCustomerParams["api_version"] = apiVersion
        createCustomerParams["customerId"] = "hfA3Sk3MJHT2RjGvZgZ2w1744nV2"
        //print("empheral key x \(APIClient.counter)")
        APIClient.counter += 1
        AF.request(URL(string: "http://\(APIClient.ip):\(APIClient.apachePortNumber)/StripeBackend/empheralkey.php")!, method: .post, parameters: createCustomerParams, encoding: URLEncoding.default, headers: [:]).responseData { (apiResponse) in
                    guard let data = apiResponse.data else { return }
                    guard let json = ((try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]) as [String : Any]??) else {
                        completion(nil, apiResponse.error)
                        return
                    }
                    completion(json, nil)
                }
    }
    
    class func createCustomer(email: String, name: String, customerId: String) {
            
        var customerDetailParams = [String: String]()
        customerDetailParams["email"] = email
        customerDetailParams["name"] = name
        customerDetailParams["customerId"] = customerId
            
            
        AF.request(URL(string: "http://\(APIClient.ip):\(APIClient.apachePortNumber)/StripeBackend/createcustomer.php")!, method: .post, parameters: customerDetailParams, encoding: URLEncoding.default, headers: nil).responseData { response in
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
    
    class func createPaymentIntent(amount: Double, currency: String, customerId: String, description: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        var paymentIntentParams = [String: Any]()
        paymentIntentParams["amount"] = amount 
        paymentIntentParams["currency"] = currency
        paymentIntentParams["customerId"] = customerId
        paymentIntentParams["description"] = description
        
            AF.request(URL(string: "http://\(APIClient.ip):\(APIClient.apachePortNumber)/StripeBackend/createpaymentintent.php")!, method: .post, parameters: paymentIntentParams, encoding: URLEncoding.default, headers: nil).responseData { (response) in
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
