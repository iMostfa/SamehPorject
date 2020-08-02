//
//  NewHomeViewController.swift
//  Test
//
//  Created by Ahmad Sameh on 12/10/19.
//  Copyright © 2019 Ahmad Sameh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class FinesViewModel: ObservableObject {

  @Published private(set) public var users: [FirebaseUser] = []

    
    var name : String = ""
    var email = String()
    var phoneNumber = String()
    var PlateNumber = String()
    var finesCount = String()
    var finesTotal = String()
    var locationsArray = [String]()
    private var db = Firestore.firestore()



    

    func setInfoInViews(){
        updateInCityValues()

    }


  func addMore() {
    self.users = [
      .init(phoneNumber: "434434", firstName: "Sameh", lastName: "Ahmad", plateNumber: "01093541099", email: "almme111almme111almme111almme111almme111almme111@gmasil.com", isStolen: false, stolenTime: "9:00Pm", finesTime: ["ededed","deed"], finesLocations: ["fedede","ededed"], finesCount: "10"),
      .init(phoneNumber: "3223323", firstName: "Sameh", lastName: "Ahmad", plateNumber: "01093541099", email: "almme111@gmasil.com", isStolen: false, stolenTime: "9:00Pm", finesTime: ["ededed","deed"], finesLocations: ["fedede","ededed"], finesCount: "10"),
      .init(phoneNumber: "01093541099", firstName: "Sameh", lastName: "Ahmad", plateNumber: "01093541099", email: "almme111@gmasil.com", isStolen: false, stolenTime: "9:00Pm", finesTime: ["ededed","deed"], finesLocations: ["fedede","ededed"], finesCount: "10"),
      .init(phoneNumber: "20209430934", firstName: "Sameh", lastName: "Ahmad", plateNumber: "01093541099", email: "almme111@gmasil.com", isStolen: false, stolenTime: "9:00Pm", finesTime: ["ededed","deed"], finesLocations: ["fedede","ededed"], finesCount: "10"),
      .init(phoneNumber: "333", firstName: "Sameh", lastName: "Ahmad", plateNumber: "01093541099", email: "almme111@gmasil.com", isStolen: false, stolenTime: "9:00Pm", finesTime: ["ededed","deed"], finesLocations: ["fedede","ededed"], finesCount: "10"),
      .init(phoneNumber: "232323", firstName: "Sameh", lastName: "Ahmad", plateNumber: "01093541099", email: "almme111@gmasil.com", isStolen: false, stolenTime: "9:00Pm", finesTime: ["ededed","deed"], finesLocations: ["fedede","ededed"], finesCount: "10"),


    ]
  }
    
    
    func fetchFines(){
        
        updateInCityValues()
        
                db.collection("Users").addSnapshotListener { [weak self]  (users, error) in


                  for user in users?.documents ?? [] {
                    let userDict = user.data()
                    guard
                      let phoneNumber    = userDict["Phone_Number"] as? String,
                      let firstName      =  userDict["First_Name"] as? String,
                      let lastName       = userDict["Last_Name"] as? String,
                      let plateNumber    = userDict["Plate_Number"] as? String,
                      let email          = userDict["Email"] as? String,
                      let isStolen       =  userDict["stolen"] as? Bool,
                      let stolenTime     = userDict["stolen_time"] as? String,
                      let finesTime      = userDict["fines_time"] as? [String],
                      let finesLocations = userDict["fines_location_array"] as? [String],
                      let finesCount     = userDict["fines_count"] as? String

                      else {
                        print(userDict["Phone_Number"])

                        print("data isn't completed!") ; return }



                          let firebaseUser = FirebaseUser(phoneNumber: phoneNumber,
                                                              firstName: firstName,
                                                              lastName: lastName,
                                                              plateNumber: plateNumber,
                                                              email: email,
                                                              isStolen: isStolen,
                                                              stolenTime: stolenTime,
                                                              finesTime: finesTime,
                                                              finesLocations: finesLocations,
                                                              finesCount: finesCount)
                    self?.users.append(firebaseUser)

                  }





                }
        
        
        
        
    }
    
    func updateInCityValues(){
//        RealTimeDatabase.rtdb.getInCityFinesCount()
//        RealTimeDatabase.rtdb.getInCityLocationsArray()
//        RealTimeDatabase.rtdb.getInCityTimesArray()
//        RealTimeDatabase.rtdb.getInCityFinesCount()
//        
//        
        

    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        self.getUserInfo()
//        print("View Will Appear")
//        self.getInsideCityFines()
//
//
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        getUserInfo()
//        print(CurrentUser.instance.currentUserInfo)
//        print(CurrentUser.instance.currentUserInfo.insideCityFinesLocations)
//        print("inside city fines count \(CurrentUser.instance.currentUserInfo.inSideCityFinesCount)")
//
//    }
//
//
//    func getInsideCityFines(){
//
//        let myRef = Database.database().reference()
//
//        myRef.child("users").child(CurrentUser.instance.UID!).child("fines_location").observe(.value) { (data) in
//
//            let snapshotValue = data.value as! [String]
//            self.locationsArray = snapshotValue
////            CurrentUser.instance.currentUserInfo.insideCityFinesLocations = self.locationsArray
////            CurrentUser.instance.currentUserInfo.inSideCityFinesCount = snapshotValue.count
//            print("Locations array \n \(self.locationsArray)")
//
//
//        }
//
//
//    }
//
    
//
//    //Btn Actions
//    @IBAction func EditInfoBtnAction(_ sender: Any) {
//
//        RealTimeDatabase.rtdb.getInCityTimesArray()
//        RealTimeDatabase.rtdb.getInCityLocationsArray()
//
//    }
//
////
//    @IBAction func LogoutBtnAction(_ sender: Any) {
//
//        CustomFirebaseServices.cfs.logOut { (completion) in
//            if completion == true{
//                self.dismiss(animated: true, completion: nil)
//            }else{
//                print("Error logging out")
//            }
//        }
//    }
//
//
//    @IBAction func FinesInfoBtnAction(_ sender: Any) {
//
//        let finesVC = self.storyboard?.instantiateViewController(withIdentifier: "finesVC") as! OutSideCityFinesTable
//        finesVC.modalPresentationStyle = .fullScreen
//        self.present(finesVC, animated: true, completion: nil)
//
//    }
//
//
//    @IBAction func reportStolenCarAction(_ sender: Any) {
//        CustomFirebaseServices.cfs.reportStolenCar()
//    }
//
//    @IBAction func outSideFinesBtnAction(_ sender: Any) {
//
//        let finesVC = self.storyboard?.instantiateViewController(withIdentifier: "outSideFinesInfoVC") as! inSideCityTableViewController
//        finesVC.modalPresentationStyle = .fullScreen
//        self.present(finesVC, animated: true, completion: nil)
//
//
////        RealTimeDatabase.rtdb.setArray()
////        RealTimeDatabase.rtdb.getInCityLocationsArray()
////        RealTimeDatabase.rtdb.getInCityTimesArray()
//
//
//
//    }
//
    
    
}


struct FirebaseUser: Identifiable {

  var id: String {
    return phoneNumber
  }

  let phoneNumber : String
  let firstName : String
  let lastName : String
  let plateNumber : String
  let email : String
  let isStolen : Bool
  let stolenTime : String
  let finesTime : [String]
  let finesLocations : [String]
  let finesCount : String


}



var gloablUser: FirebaseUser =     .init(phoneNumber: "232323", firstName: "Sameh", lastName: "Ahmad", plateNumber: "01093541099", email: "almme111@gmasil.com", isStolen: false, stolenTime: "9:00Pm", finesTime: ["ededed","deed"], finesLocations: ["fedede","ededed"], finesCount: "10")
