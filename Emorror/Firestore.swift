//
//  Firestore.swift
//  Test
//
//  Created by Ahmad Sameh on 4/30/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import Foundation
import Firebase
class CustomFirebaseServices {
    
    static let cfs = CustomFirebaseServices()
    
    let db = Firestore.firestore()
    
    
    func logOut(completion : @escaping (_ complete : Bool) -> Void){

                do
                {
                    try Auth.auth().signOut()
                    completion(true)
                    print("logged out successfully")

                }
                catch let error as NSError
                {
                    print (error.localizedDescription)
                    completion(false)
                }
        
        
    }
    
    func reportStolenCar(){
        
        db.collection("Users").document(Auth.auth().currentUser!.uid).updateData(["stolen" : true]) { (error) in
            if error == nil{
                print("reported stolen")
                
                self.db.collection("Users").document(Auth.auth().currentUser!.uid).updateData(["stolen_time" : Date().description]) { (error) in
                    if error == nil {
                       print("reported stolen time")
                    }else{
                       print("time update error")
                    }
                }
                
                
                
            }else{
                print("\(error!.localizedDescription)")

            }
        }

        
    }
    
   
    
    func signUp(enteredEmail : String, enteredPassword : String , firstName : String , lastName : String , plateNumber : String, phoneNumber : String, finesLocations : [String] , finesTime : [String], completion : @escaping (_ complete : Bool)-> Void){
        

        
        Auth.auth().createUser(withEmail: enteredEmail, password: enteredPassword) { (authResult, authError) in
            if authError != nil{
                
                print("error in firebase signup function")
            }else{
                
                self.db.collection("Users").document((authResult?.user.uid)!).setData(["First_Name":firstName ,
                                                                                  "Last_Name":lastName ,
                                                                                  "Email":enteredEmail,
                                                                                  "Phone_Number":phoneNumber,
                                                                                  "Plate_Number":plateNumber,
                                                                                  "UID":authResult?.user.uid,
                                                                                  "fines_location_array":finesTime,
                                                                                  "fines_time":finesLocations,
                                                                                  "fines_count":0],
                                                                                 merge: true){
                                                                                    (error) in
                                                                                    
                                                                                    if error != nil {
                                                                                        // Show error message
                                                                                        print("error creating user , please try again.")
                                                                                    }
                                                                                    
                }
  
            }
           
        }

        completion(true)
    }
    





}
