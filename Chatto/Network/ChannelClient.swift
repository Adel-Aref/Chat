//
//  ChannelClient.swift
//  Chatto
//
//  Created by User on 2/18/20.
//  Copyright © 2020 Adel. All rights reserved.
//

import Foundation
import Firebase

protocol ChannelClientProtocol {
    typealias JSONTaskCompletionHandler = (RequestResult<Decodable, RequestError>) -> Void

    func observeChannels(with nodeName: String, completion: @escaping (RequestResult<Decodable, RequestError>) -> Void)
}
class ChannelClient :ChannelClientProtocol {
    let databaselRef = Database.database().reference()
    
    var array : [[String :String]] = [[:]]
    
  
    func observeChannels(with nodeName: String, completion: @escaping (RequestResult<Decodable, RequestError>) -> Void) {
        self.array.removeAll()
        
        databaselRef.child(nodeName).observe(.childAdded) {[weak self] (snapshot) in
            guard let dictionary = snapshot.value as? [String :
                String] else {
                completion(.failure(.authorizationError))
                return
            }
            self?.array.append(dictionary)
            let data = try! JSONSerialization.data(withJSONObject: self?.array , options: [])
            self?.decodeJsonResponse(decodingType: [Channel].self, jsonObject: data) { (channels) in
                completion(channels)
            }
       
        }
           
    }
    /// decode repsonse 
    func decodeJsonResponse<T: Decodable>(decodingType:T.Type,jsonObject: Data, completion: @escaping JSONTaskCompletionHandler){
        DispatchQueue.main.async {
            do {
                let genericModel = try JSONDecoder().decode(decodingType, from: jsonObject)
                completion(.success(genericModel))
            } catch {
                completion(.failure(.jsonConversionFailure))
            }
        }
    }
    
    
}





