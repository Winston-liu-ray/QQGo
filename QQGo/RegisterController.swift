//
//  registerController.swift
//  QQGo
//
//  Created by Ｗinston on 4/27/15.
//  Copyright (c) 2015 Ｗinston. All rights reserved.
//
let URL_PATH = "104.131.156.66"

import Foundation
import UIKit
import CoreActionSheetPicker


class RegisterController: UIViewController, UIPickerViewDelegate {
    
    var county : [String] = []
    var countyCode : [String] = []   // this is Counties_ID, need be fixed to two-dimo array
    var zoneName : [String] = []
    var result : String = "0"
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtIDNumber: UITextField!
    @IBOutlet weak var txtPasswordAgain: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    var birthdDate : String = "10"
    var gender : String = "1"  // 1 for male, 0 for female
    let imageOn = UIImage(named: "RadioButtonON")
    let imageDown = UIImage(named: "RadioButtonDOWN")
    var year : String = "0"
    var month : String = "0"
    var date : String = "0"
    var countyNumber : Int = 0
    var countyID : String = "0"
    var zoneID : String = "0"
    var Counties_Name : String = "0"
    var Zones_Name : String = "0"
    
    @IBOutlet var showBirthDate: UIButton!
    @IBOutlet var showTown: UIButton!
    @IBOutlet var showCounty: UIButton!
    @IBAction func birthDate(sender: UIButton) {
        
       var datePicker = ActionSheetDatePicker(title: "Date:", datePickerMode: UIDatePickerMode.Date, selectedDate: NSDate(), doneBlock: {
            picker, value, index in
            //var year : String = regionToMonitor["value"] as! String
            
           var formatter : NSDateFormatter = NSDateFormatter()
        
               formatter.dateFormat = "yyyy"
           let yearStr : String = formatter.stringForObjectValue(value)!
               formatter.dateFormat = "MM"
           let monthStr : String = formatter.stringForObjectValue(value)!
               formatter.dateFormat = "dd"
           let dateStr : String = formatter.stringForObjectValue(value)!
        
        
        
        
        
            var year : Int =  yearStr.toInt()!
            year = year - 1911
        
            if(year < 100){
              self.year = "0"+String(year)
            }
            else{
              self.year = String(year)
            }
        
            var month : Int =  monthStr.toInt()!
           /* var birthMonth :String = monthStr

            if(month < 10){
               birthMonth = "0" + birthMonth;
            }
            self.month = birthMonth;*/
        
            self.month = monthStr;
            var date : Int =  dateStr.toInt()!
            self.date = String(date)
        
        
            self.showBirthDate.setTitle(self.month+"/"+self.date+"/"+yearStr, forState: .Normal)

            println("date = \(self.date)")
            println("month = \(self.month)")
            println("year = \(self.year)")
           //println("value = \(value)")
           //println("index = \(index)")
           //println("picker = \(picker)")
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender.superview!.superview)
        
        let secondsInWeek: NSTimeInterval = 7 * 24 * 60 * 60;
        //datePicker.minimumDate = NSDate(timeInterval: -secondsInWeek, sinceDate: NSDate())
        //datePicker.maximumDate = NSDate(timeInterval: secondsInWeek, sinceDate: NSDate())
        datePicker.showActionSheetPicker()
        
    }
    @IBAction func male(sender: UIButton) {
        gender = "1"
        maleButton.setImage(imageOn, forState: UIControlState.Normal)
        femaleButton.setImage(imageDown, forState: UIControlState.Normal)
     
    }
    @IBAction func female(sender: UIButton) {
        gender = "2"
        maleButton.setImage(imageDown, forState: UIControlState.Normal)
        femaleButton.setImage(imageOn, forState: UIControlState.Normal)
        
    }
    @IBAction func countySelection(sender: UIButton) {
        ActionSheetStringPicker.showPickerWithTitle("請選擇縣市", rows: county, initialSelection: 1, doneBlock: {
            picker, value, index in
            self.countyNumber = value    // this is c[i]
           // println("value = \(value)")
           // println("index = \(index)")
           // println("index = \(self.countyCode[value])")
           // println("picker = \(picker)")
           // println(self.countyNumber)
            println(self.countyNumber)   // this is counties_ID
            self.showTown.setTitle("鄉鎮區", forState: .Normal)

            let path = NSBundle.mainBundle().pathForResource("areaNumber", ofType: "json")//or rtf for an rtf file
            self.zoneName.removeAll(keepCapacity: false)
            var text : NSString = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
            let data = text.dataUsingEncoding(NSUTF8StringEncoding)
            var json = NSJSONSerialization.JSONObjectWithData( data!, options: .MutableContainers, error: nil) as? NSDictionary
            if let parseJson = json{
                var Counties_Cnt = (parseJson["Counties_Cnt"] as? String)

            var json_c = (parseJson["c" + String(self.countyNumber)] as? NSDictionary)
                // println(json_c)

            if let parseJson_c = json_c {
                self.Counties_Name =  (parseJson_c["Counties_Name"] as? String)!
                var zones_Cnt = (parseJson_c["Zones_Cnt"] as? String)
                self.countyID = (parseJson_c["Counties_ID"] as? String)!
                   println(self.countyID)
                if zones_Cnt!.toInt()>0 {
                    
                    for var k = 0; k < zones_Cnt!.toInt() ; ++k {
                        var json_d = (parseJson_c["z" + String(k)] as? NSDictionary)
                        
                        if let parseJson_d = json_d {
                            var zone_Name = (parseJson_d["Zones_Name"] as? String)!
                            self.zoneName.append(zone_Name)
                            //  println(zoneName[i][k])
                            
                            
                            
                        }
                    }
                    
                    
                }
            }
                
            }
            self.showCounty.setTitle(self.Counties_Name, forState: .Normal)
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
    }
    @IBAction func townSelection(sender: UIButton) {
    
        ActionSheetStringPicker.showPickerWithTitle("請選擇鄉鎮區", rows: self.zoneName, initialSelection: 1, doneBlock: {
            picker, value, index in
            
            
            //self.countyNumber = value
            println("value = \(value)")
            //println("index = \(index)")
            // println("picker = \(picker)")
            //println(self.countyNumber)
            let path = NSBundle.mainBundle().pathForResource("areaNumber", ofType: "json")//or rtf for an rtf file
            var text : NSString = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
            let data = text.dataUsingEncoding(NSUTF8StringEncoding)
            var json = NSJSONSerialization.JSONObjectWithData( data!, options: .MutableContainers, error: nil) as? NSDictionary
            if let parseJson = json{
                var json_c = (parseJson["c" + String(self.countyNumber)] as? NSDictionary)
                // println(json_c)

                if let parseJson_c = json_c {
                    var json_d = (parseJson_c["z" + String(value)] as? NSDictionary)
                    if let parseJson_d = json_d{
                        self.zoneID = (parseJson_d["Zones_ID"] as? String)!
                        self.Zones_Name =  (parseJson_d["Zones_Name"] as? String)!

                       println(self.zoneID)
                    }

                }
                //println(self.countyCode)
                
            }
            self.showTown.setTitle(self.Zones_Name, forState: .Normal)
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
    }
    
    
    
    
    @IBAction func saveButton(sender: AnyObject) {
        let name = txtName.text
        let IDNumber = txtIDNumber.text
        let password = txtPassword.text
        let passwordAgain = txtPasswordAgain.text
        let phone = txtPhone.text
        let address = txtAddress.text
       
        if(name.isEmpty ){
            
            let alertController = UIAlertController(title: "錯誤", message:"姓名空白!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        return;
        }
        else if(IDNumber.isEmpty ){
            let alertController = UIAlertController(title: "錯誤", message:"身分證字號空白!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        return;

        }
        else if(password.isEmpty ){
            let alertController = UIAlertController(title: "錯誤", message:"密碼空白!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        return;
            
        }
        else if(passwordAgain.isEmpty ){
            let alertController = UIAlertController(title: "錯誤", message:"再次輸入密碼空白!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        return;
            
        }
        else if(phone.isEmpty  ){
            let alertController = UIAlertController(title: "錯誤", message:"手機號碼空白!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        return;
            
        }
        else if(address.isEmpty){
            let alertController = UIAlertController(title: "錯誤", message:"地址空白!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        return;
            
        }
        
        if(password != passwordAgain) {
            let alertController = UIAlertController(title: "錯誤", message:"密碼不一致!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        return;
        }
        let url:NSURL = NSURL(string: "http://104.131.156.66/Vertex/identityverify.php")!;
        let request = NSMutableURLRequest(URL: url);
        request.HTTPMethod = "POST";
        let key : String = "vErTeXiSgOoD"+"register"+name+gender+self.year+self.month+self.date+IDNumber+password+phone+self.countyID+self.zoneID+address
        let prePostString = "query=register&v_fullname="+name+"&v_sex="+gender+"&v_birthday="+self.year+self.month+self.date
        let postString = prePostString+"&v_idcardnum="+IDNumber+"&v_password="+password+"&v_phonenum="+phone+"&v_addresspre="+self.countyID+self.zoneID+"&v_address="+address+"&key="+key.md5();
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        println(postString);
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            data, response, error in
            if error != nil{
                println("error= \(error)")
                //return
            }
            
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("responseString= \(responseString)")
            
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData( data, options: .MutableContainers, error: &err) as? NSDictionary
            if let parseJson = json{
                self.result = (parseJson["Result"] as? String)!
            }
            let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                dispatch_async(dispatch_get_main_queue()) {
                    if(self.result == "0"){
                        let alertController = UIAlertController(title: "註冊失敗", message:"請檢查", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default,handler: nil))
                        self.presentViewController(alertController, animated: true, completion: nil)
                        return
                    }
                    else{
                        let check = self.storyboard!.instantiateViewControllerWithIdentifier("check") as! CheckRegister
                        self.presentViewController(check, animated: true, completion: nil)
                    }
                }
            }
            
        }
       task.resume()
        
    
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        maleButton.setImage(imageOn, forState: UIControlState.Normal)
        femaleButton.setImage(imageDown, forState: UIControlState.Normal)
        let path = NSBundle.mainBundle().pathForResource("areaNumber", ofType: "json")//or rtf for an rtf file
        
        var text : NSString = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
        let data = text.dataUsingEncoding(NSUTF8StringEncoding)
        var json = NSJSONSerialization.JSONObjectWithData( data!, options: .MutableContainers, error: nil) as? NSDictionary
      
        
        if let parseJson = json{
            var Counties_Cnt = (parseJson["Counties_Cnt"] as? String)
            //println(Counties_Cnt)

            if Counties_Cnt!.toInt()>0 {
                for var i = 0; i < Counties_Cnt!.toInt() ; ++i {
                    var json_c = (parseJson["c" + String(i)] as? NSDictionary)
                    if let parseJson_c = json_c {
                        var Counties_Name = (parseJson_c["Counties_Name"] as? String)
                        county.append(Counties_Name!)
                        var counties_Number =  (parseJson_c["Counties_ID"] as? String)
                        countyCode.append(counties_Number!)
                        //println(self.countyCode)

                     }
                 }
                
                
            }

        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldAutorotate() -> Bool {    // force app to rotate.
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }

    
    
    
}

