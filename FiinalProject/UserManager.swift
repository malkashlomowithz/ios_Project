//
//  UserManager.swift
//  FiinalProject
//
//  Created by Malky on 27/06/2022.
//

import SwiftUI

class UserManager: ObservableObject {
    
    

    @Published var registerToken = ""
    @Published var messageToUser = ""
    @Published var registered: Bool = false
        
    func registerUser(firstnam: String, lastName: String, userName: String, password: String) {
        
        print("huu")
        
            let body = [
                "firstname" : firstnam,
                "lastname" : lastName,
                "username" : userName,
                "password" : password
            ]
        print(body)
        let jsonBody = try? JSONSerialization.data(withJSONObject: body)

        let url = URL(string: "https://balink-ios-learning.herokuapp.com/api/v1/auth/register")!
        
        var request = URLRequest(url: url)

        request.httpMethod = "POST"

        request.httpBody = jsonBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error == nil {
                
                if let safeData = data {
                    
                    let decodeer = JSONDecoder()
                    
                    do{
                        let decodedRes = try decodeer.decode(User.self, from: safeData)
          
                            DispatchQueue.main.async {
                                
                                if let token = decodedRes.access_token {

                                    UserDefaults.standard.set(token, forKey: "token")
                                   
                                    self.messageToUser = "You are registerd successfully"
                                    self.registerToken = token
                                    self.registered = true
                                    print(self.registered)
                    } else {
                        
                        self.messageToUser = decodedRes.message ?? "Unknown error"
                        
                        print(self.messageToUser)
                    }
                            }
                        } catch {
                            
                            print("error", error)
                    }
                }
            }
        }
        task.resume()
    }
}
