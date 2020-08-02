//
//  RealTimeDatabase.swift
//  Test
//
//  Created by Ahmad Sameh on 6/11/20.
//  Copyright © 2020 Ahmad Sameh. All rights reserved.
//

import Foundation
import Firebase

class RealTimeDatabase {
    static let rtdb = RealTimeDatabase()
    let myRef = Database.database().reference()
    
    var timesArray = [String]()
    var locationsArray = [String]()
    var finesCount : Int = 0
    
    
    func setArray(){
        
        myRef.child("users").child(CurrentUser.instance.UID!).child("test").setValue(["1","2","3"])

        
    }
    
    
    
    func getInCityLocationsArray(){
        
        myRef.child("users").child(CurrentUser.instance.UID!).child("fines_location").observe(.value) { (data) in
            
            
            let snapshotValue = data.value as! [String]
            self.locationsArray = snapshotValue
            CurrentUser.instance.currentUserInfo.insideCityFinesLocations = self.locationsArray
            CurrentUser.instance.currentUserInfo.inSideCityFinesCount = snapshotValue.count
            print("Locations array \n \(self.locationsArray)")


        }
        
        
    }
    
    func deleteFine(updatedTimesArray : [String] , updatedLocationsArray : [String]){

        print("Updated Times array \n \(updatedTimesArray)")
        print("Updated Locations array \n \(updatedLocationsArray)")
        myRef.child("users").child(CurrentUser.instance.UID!).child("fines_location").setValue(updatedLocationsArray)
        myRef.child("users").child(CurrentUser.instance.UID!).child("fines_time").setValue(updatedTimesArray)
        
    }
    
    
    
    func getInCityFinesCount(){
        
        myRef.child("users").child(CurrentUser.instance.UID!).child("fines_count").observe(.value) { (data) in
            
            self.finesCount = data.value as! Int
            CurrentUser.instance.currentUserInfo.outSideCityFinesCount = self.finesCount
           
            

            
            
        }
    }
    
    func getInCityTimesArray(){
        
        myRef.child("users").child(CurrentUser.instance.UID!).child("fines_time").observe(.value, with: { (data) in
            
            
            let snapshotValue = data.value as! [String]
            self.timesArray = snapshotValue
            CurrentUser.instance.currentUserInfo.inSideCityFinesCount = snapshotValue.count
            CurrentUser.instance.currentUserInfo.inSideCityFinesTimes = self.timesArray
            print("Times array \n \(self.timesArray)")
            

        }) { (error) in
            print("error loading from realtime database \(error)")
        }

    }
    
    
    
    
}
