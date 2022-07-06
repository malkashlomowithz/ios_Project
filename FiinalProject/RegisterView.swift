//
//  ContentView.swift
//  FiinalProject
//
//  Created by Malky on 27/06/2022.
//

import SwiftUI

struct RegisterView: View  {
    
    @StateObject var userManager = UserManager()
    
    @State var firstname = ""
    @State var lastname = ""
    @State var username = ""
    @State var password = ""
    @State var validationError = ""
    
    func handlelogin(){
        if firstname != "" &&
            lastname != "" &&
            username != "" &&
            password != "" {
            
            userManager.registerUser(
                firstnam: firstname,
                lastName: lastname,
                userName: username,
                password: password)
            
        } else {
            validationError = "missing field"
        }
        
    }
    
    var errorMsg: String{
        if userManager.messageToUser != ""{
            return "Error: \(userManager.messageToUser)"
        }
        else if validationError != "" {
            return validationError
        } else {
            return ""
        }
    }
    
    struct SecureTextField: View {
        
        @Binding var text: String
        @State var isSecureField: Bool = true
        
        var body: some View {
            
            HStack {
                if isSecureField {
                    SecureField("Password", text: $text)
                } else {
                    TextField(text, text: $text)
                }
            }.overlay(alignment: .trailing) { Image (systemName: isSecureField ? "eye.slash" : "eye").onTapGesture {
                isSecureField.toggle()
                
            }
            }
            
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text("\(errorMsg)").foregroundColor(.red)
                Form {
                    Section(header: Text("Register").font(.title).fontWeight(.medium).bold()) {
                        TextField("First Name", text: $firstname)
                        
                        TextField("Last Name", text: $lastname)
                        
                        TextField("Username", text: $username)
                        
                        SecureTextField(text: $password)
                        
                        Button("Send") {
                            
                            handlelogin()
                            
                        }.foregroundColor(.blue)
                    }
                }
                NavigationLink(destination: CategorysView(productMnager: ProductsManager()),
                               isActive: $userManager.registered) {
                    
                }
                
            }
        }.onAppear {
            
             let token = UserDefaults.standard.string(forKey: "token")
                    if token != nil {
                userManager.registered = true
            
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
        
    }
}
