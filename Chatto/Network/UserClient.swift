//
//  RegisterationClient.swift
//  Chatto
//
//  Created by User on 2/17/20.
//  Copyright © 2020 Adel. All rights reserved.
//

import Foundation
import Firebase

protocol UserClientProtocol {
    typealias JSONTaskCompletionHandler = (RequestResult<Decodable, RequestError>) -> Void
    
    func makeRequest<T: Decodable>( with json: [String :String], decodingType:T.Type, completion: @escaping JSONTaskCompletionHandler)
    
    func registerNewUser(with dic :[String :String], completionHandler: @escaping JSONTaskCompletionHandler)
    func login(with email: String, and password: String, completion: @escaping (RequestResult<Decodable, RequestError>) -> Void)
    func signOut(completion : @escaping(RequestResult<Decodable,RequestError>)-> Void)
}

extension UserClientProtocol {
    typealias JSONTaskCompletionHandler = (RequestResult<Decodable, RequestError>) -> Void
    
    func makeRequest<T: Decodable>( with json: [String :String], decodingType:T.Type, completion: @escaping JSONTaskCompletionHandler){
        guard let email =  json["email"] else {
            return
        }
        guard let password =  json["password"]  else {
            return
        }
        guard let displayName =  json["displayName"] else {
            return
        }
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            guard user != nil else {
                completion(.failure(.connectionError))
                return
            }
            let newChannelRef = Database.database().reference().child("Users").child((Auth.auth().currentUser?.uid ?? ""))
            let channelItem  = [
                "displayName": displayName,
                "email":Auth.auth().currentUser?.email,
                "userId":Auth.auth().currentUser?.uid
            ]
            newChannelRef.setValue(channelItem)
            completion(.success(.none))
            //self.decodeJsonResponse(decodingType: decodingType, jsonObject:Data(user), completion: completion)
        })
    }
    //
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

class UserClient: UserClientProtocol{
    func signOut(completion: @escaping (RequestResult<Decodable, RequestError>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(.none))
        }
        catch{
            completion(.failure(.serverError))
        }
    }
    
    func registerNewUser(with dic :[String :String], completionHandler completion: @escaping (RequestResult<Decodable, RequestError>) -> Void) {
        makeRequest(with: dic, decodingType: User.self) { (result) in
            completion(result)
        }
    }
    func login(with email: String, and password: String, completion: @escaping (RequestResult<Decodable, RequestError>) -> Void){
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in

            guard user != nil else {
                completion(.failure(.serverError))
                return
            }
            completion(.success(.none))
           
           
        })
    }
}


