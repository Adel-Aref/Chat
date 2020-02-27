//
//  MessageClient.swift
//  Chatto
//
//  Created by User on 2/20/20.
//  Copyright © 2020 Adel. All rights reserved.
//

import Foundation
import Firebase

protocol MessageClientProtocol {
    typealias JSONTaskCompletionHandler = (RequestResult<Decodable, RequestError>) -> Void

    func sendMessage(with message: [String:Any],and channelID :String , completion: @escaping (RequestResult<Decodable, RequestError>) -> Void)
    func getAllChatMessages(with nodeName: String,completion: @escaping (RequestResult<Decodable, RequestError>) -> Void) 


}
class MessageClient :MessageClientProtocol {
    let databaselRef = Database.database().reference()
    var array : [[String :String]] = [[:]]

    func sendMessage(with message: [String : Any],and channelID :String, completion: @escaping (RequestResult<Decodable, RequestError>) -> Void) {
        self.databaselRef.child("Channels").child(channelID).child("Messages").childByAutoId().setValue(message) { (error, dataRefence) in
            guard error != nil else {
                completion(.success(.none))
                return
            }
            completion(.failure(.connectionError))
        }
    }
    
    func getAllChatMessages(with nodeName: String,completion: @escaping (RequestResult<Decodable, RequestError>) -> Void) {
        self.array.removeAll()
        
        databaselRef.child("Channels").child(nodeName).observeSingleEvent(of: .value) {[weak self] (snapshot,error) in
            if snapshot.exists(){
                print("true rooms exist")
                self?.databaselRef.child("Channels").child(nodeName).child("Messages").observe(.childAdded) {[weak self] (snapshot,error) in
                  
                    guard let dictionary = snapshot.value as? [String :
                        String] else {
                            completion(.failure(.authorizationError))
                            return
                    }
                    self?.array.append(dictionary)
                    let data = try! JSONSerialization.data(withJSONObject: self?.array ?? [:] , options: [])
                    self?.decodeJsonResponse(decodingType: [Message].self, jsonObject: data) { (channels) in
                        completion(channels)
                    }
                }
            }
            else{
                print("false room doesn't exist")
                completion(.failure(.authorizationError))
            }
            
        }
    }
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



