//
//  NewAnObjectController.swift
//  QQGo
//
//  Created by Ｗinston on 4/27/15.
//  Copyright (c) 2015 Ｗinston. All rights reserved.
//

import Foundation

import UIKit

class NewAnObjectController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    @IBOutlet weak var objectName: UITextField!
    @IBOutlet weak var objectAddr: UITextField!
    @IBOutlet weak var numberOfRoom: UITextField!
    @IBOutlet weak var numberOfLivingRoom: UITextField!
    @IBOutlet weak var numberOfRestroom: UITextField!
    @IBOutlet weak var numberOfBalcony: UITextField!
    @IBOutlet weak var NewAnObjectScrollView: UIScrollView!
    @IBOutlet weak var numberOfCarSpace: UITextField!
    @IBOutlet weak var discription: UITextField!
    @IBOutlet weak var yearsOfHouse: UITextField!
    @IBOutlet weak var sizeOfCarSpace: UITextField!
    @IBOutlet weak var ratioOfPublic: UITextField!
    @IBOutlet weak var sizeOfHouse: UITextField!
    @IBOutlet weak var housePrice: UITextField!
    @IBOutlet weak var serviceFee: UITextField!

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    var imageSelection1 : Boolean = 0
    var imageSelection2 : Boolean = 0
    var imageSelection3 : Boolean = 0
    
    var result: String = "0"

    
    @IBAction func selectButton1(sender: UIButton) {
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.imageSelection1 = 1
        self.presentViewController(myPickerController, animated: true, completion: nil)
    }
    
    @IBAction func selectButton2(sender: UIButton) {
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.imageSelection2 = 1

        self.presentViewController(myPickerController, animated: true, completion: nil)
    }
    
    @IBAction func selectButton3(sender: UIButton) {
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.imageSelection3 = 1

        self.presentViewController(myPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        if(self.imageSelection1 == 1){
            image1.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            self.imageSelection1 = 0
        }
        else if(self.imageSelection2 == 1){
            image2.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            self.imageSelection2 = 0

        }
        else if(self.imageSelection3 == 1){
            image3.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            self.imageSelection3 = 0

        }
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func saveButton(sender: UIButton) {
        
        let url:NSURL = NSURL(string: "http://104.131.156.66/Vertex/identityverify.php")!;
        let request = NSMutableURLRequest(URL: url);
        request.HTTPMethod = "POST";
        
        
        
        //let key : String = "vErTeXiSgOoD"+"sethNewObject "+name.text+gender+self.year+self.month+self.date+IDNumber+password+phone+self.countyID+self.zoneID+address
        let prePostString = "query=sethNewObject&v_authcode=&v_obj_name="+objectName.text+"&v_obj_addresspre="+objectAddr.text
        let prePostString2 = "&v_obj_address="+objectAddr.text+"&v_obj_room="+numberOfRoom.text+"&v_obj_hall="+numberOfLivingRoom.text+"&v_obj_bathroom="+numberOfRestroom.text+"& v_obj_balcony="+numberOfBalcony.text+"&v_obj_parking="+numberOfCarSpace.text;
        let prePostString3 = "&v_obj_levelg="+sizeOfHouse.text+"&v_obj_postratio="+ratioOfPublic.text+"&v_obj_parkg="+sizeOfCarSpace.text+"&v_obj_houseage="+yearsOfHouse.text+"&v_obj_remark="+discription.text+"&v_obj_price="+housePrice.text+"&v_obj_fees="+serviceFee.text;
        
        let postString : String = prePostString + prePostString2 + prePostString3;
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

        
        
        
        
        
        let taskForImage = NSURLSession.sharedSession().dataTaskWithRequest(request){
            data, response, error in
            if error != nil{
                println("error= \(error)")
                return
                
            }
            
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            //println("responseString= \(responseString)")
            
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData( data, options: .MutableContainers, error: &err) as? NSDictionary
            
        }
        task.resume()
        
    }
    
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NewAnObjectScrollView.userInteractionEnabled = true
        NewAnObjectScrollView.contentSize = CGSizeMake(400, 1200)
        
    }
}