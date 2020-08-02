//
//  NewHomeViewController.swift
//  Test
//
//  Created by Ahmad Sameh on 12/10/19.
//  Copyright © 2019 Ahmad Sameh. All rights reserved.
//

import UIKit
import Firebase

class NewHomeViewController: UIViewController {

    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var PlateNumberLabel: UILabel!
    @IBOutlet weak var PhoneNumberLabel: UILabel!
    @IBOutlet weak var FinesCountLabel: UILabel!
    @IBOutlet weak var FinesTotalLabel: UILabel!
    @IBOutlet weak var reportedStolen : UILabel!
    @IBOutlet weak var reportedStolenTime : UILabel!
    
    var name : String = ""
    var email = String()
    var phoneNumber = String()
    var PlateNumber = String()
    var finesCount = String()
    var finesTotal = String()
    var locationsArray = [String]()
    
   
    
    

    func setInfoInViews(){
        updateInCityValues()
        
        NameLabel.text = "\(CurrentUser.instance.currentUserInfo.firstName) \(CurrentUser.instance.currentUserInfo.lastName)"
        EmailLabel.text = CurrentUser.instance.currentUserInfo.email
        PhoneNumberLabel.text = CurrentUser.instance.currentUserInfo.phoneNumber
        PlateNumberLabel.text = CurrentUser.instance.currentUserInfo.plateNumber
        FinesCountLabel.text = "\(CurrentUser.instance.currentUserInfo.outSideCityFinesCount + CurrentUser.instance.currentUserInfo.inSideCityFinesCount)"
        let total = (CurrentUser.instance.currentUserInfo.outSideCityFinesCount + CurrentUser.instance.currentUserInfo.inSideCityFinesCount)*150
        FinesTotalLabel.text = "\(total) EGP"
        reportedStolen.text = "\(CurrentUser.instance.currentUserInfo.reportedStolen)"
        
 
    }
    
    
    func getUserInfo(){
        
        updateInCityValues()
        
                CustomFirebaseServices.cfs.db.collection("Users").document(Auth.auth().currentUser?.uid ?? "nil").addSnapshotListener { (data, error) in
        
                    if error != nil{
                        print("\(String(describing: error?.localizedDescription))")
                    }else{
        
                        CurrentUser.instance.currentUserInfo =
                            User(
                                 firstName:data?.get("First_Name") as! String ,
                                 lastName: data?.get("Last_Name") as! String,
                                                    email: data?.get("Email") as! String,
                                                    phoneNumber: data?.get("Phone_Number") as! String,
                                                    plateNumber: data?.get("Plate_Number") as! String,
                                                    reportedStolen: data?.get("stolen") as! Bool,
                                                    reportedStolenTime: data?.get("stolen_time") as! String,
                                                    outSideCityFinesCount: Int(truncating: data?.get("fines_count") as! NSNumber),
                                                    outSideCityFinesLocations: (data?.get("fines_location_array") as! [String]) ,
                                                    outSideCityFinesTimes: data?.get("fines_time") as! [String],
                                                    inSideCityFinesCount: RealTimeDatabase.rtdb.finesCount,
                                                    insideCityFinesLocations: RealTimeDatabase.rtdb.locationsArray,
                                                    inSideCityFinesTimes: RealTimeDatabase.rtdb.timesArray )
                        
                                                    self.setInfoInViews()
                                                    self.updateInCityValues()
        
                    }
        
                }
        
        
        
        
    }
    
    func updateInCityValues(){
        RealTimeDatabase.rtdb.getInCityFinesCount()
        RealTimeDatabase.rtdb.getInCityLocationsArray()
        RealTimeDatabase.rtdb.getInCityTimesArray()
        RealTimeDatabase.rtdb.getInCityFinesCount()
        
        
        
        
        
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getUserInfo()
        print("View Will Appear")
        self.getInsideCityFines()
        
        print(CurrentUser.instance.currentUserInfo.insideCityFinesLocations)
        print(CurrentUser.instance.currentUserInfo.firstName)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo()
        print(CurrentUser.instance.currentUserInfo)
        print(CurrentUser.instance.currentUserInfo.insideCityFinesLocations)
        print("inside city fines count \(CurrentUser.instance.currentUserInfo.inSideCityFinesCount)")

    }
    
    
    func getInsideCityFines(){
        
        let myRef = Database.database().reference()
        
        myRef.child("users").child(CurrentUser.instance.UID!).child("fines_location").observe(.value) { (data) in
            
            let snapshotValue = data.value as! [String]
            self.locationsArray = snapshotValue
//            CurrentUser.instance.currentUserInfo.insideCityFinesLocations = self.locationsArray
//            CurrentUser.instance.currentUserInfo.inSideCityFinesCount = snapshotValue.count
            print("Locations array \n \(self.locationsArray)")


        }
        
        
    }
    
    
    
    //Btn Actions
    @IBAction func EditInfoBtnAction(_ sender: Any) {
        
        RealTimeDatabase.rtdb.getInCityTimesArray()
        RealTimeDatabase.rtdb.getInCityLocationsArray()
        
    }
    
    
    @IBAction func LogoutBtnAction(_ sender: Any) {

        CustomFirebaseServices.cfs.logOut { (completion) in
            if completion == true{
                self.dismiss(animated: true, completion: nil)
            }else{
                print("Error logging out")
            }
        }
    }
    
    
    @IBAction func FinesInfoBtnAction(_ sender: Any) {

        let finesVC = self.storyboard?.instantiateViewController(withIdentifier: "finesVC") as! OutSideCityFinesTable
        finesVC.modalPresentationStyle = .fullScreen
        self.present(finesVC, animated: true, completion: nil)

    }
    
    
    @IBAction func reportStolenCarAction(_ sender: Any) {
        CustomFirebaseServices.cfs.reportStolenCar()
    }
    
    @IBAction func outSideFinesBtnAction(_ sender: Any) {
        
        let finesVC = self.storyboard?.instantiateViewController(withIdentifier: "outSideFinesInfoVC") as! inSideCityTableViewController
        finesVC.modalPresentationStyle = .fullScreen
        self.present(finesVC, animated: true, completion: nil)
        
        
//        RealTimeDatabase.rtdb.setArray()
//        RealTimeDatabase.rtdb.getInCityLocationsArray()
//        RealTimeDatabase.rtdb.getInCityTimesArray()
        
        
        
    }
    
    
    
}
