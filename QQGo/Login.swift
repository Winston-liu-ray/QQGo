//
//  ViewController.swift
//  QQGo
//
//  Created by Ｗinston on 4/21/15.
//  Copyright (c) 2015 Ｗinston. All rights reserved.
//

import UIKit

class Login: UIViewController {
    
    
    var result : String = "2"
    @IBOutlet weak var txtIDNumber: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBAction func loginButton(sender: AnyObject) {
        let IDNumber = txtIDNumber.text
        let Password = txtPassword.text
        
        
        
        let url:NSURL = NSURL(string: "http://104.131.156.66/Vertex/identityverify.php")!;
        let request = NSMutableURLRequest(URL: url);
        request.HTTPMethod = "POST";
        let key : String = "vErTeXiSgOoD"+"login"+IDNumber+Password
        let postString = "query=login&v_idcardnum="+IDNumber+"&v_password="+Password+"&key="+key.md5();
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        //println("key= \(key.md5())")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            data, response, error in
            if error != nil{
                println("error= \(error)")
                
                return

            }
            
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            //println("responseString= \(responseString)")
            
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData( data, options: .MutableContainers, error: &err) as? NSDictionary
            
            if let parseJson = json{
                self.result = (parseJson["Result"] as? String)!
                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                      dispatch_async(dispatch_get_global_queue(priority, 0)) {
                       dispatch_async(dispatch_get_main_queue()) {
                           self.present(self.result)
                       }
                      }
                println("responseString2= \(self.result)")
            }
       
        }
        task.resume()
        
        println("responseString3= \(self.result)")
        
    }
        func present(outcome :String){
        if(self.result == "0"){
            let alertController = UIAlertController(title: "登入失敗", message:"帳號或密碼錯誤", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        else if(self.result=="1"){
            let MainNavigation = self.storyboard!.instantiateViewControllerWithIdentifier("MainNavigation") as! UINavigationController
            presentViewController(MainNavigation, animated: true, completion: nil)
        }
        else if(self.result=="2"){
            let alertController = UIAlertController(title: "未連接網路", message:"請檢查網路狀態", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
      }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldAutorotate() -> Bool {    // force app not to rotate.
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }
}
extension String {
    func md5() -> String {
        var data = (self as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        let result = NSMutableData(length: Int(CC_MD5_DIGEST_LENGTH))
        let resultBytes = UnsafeMutablePointer<CUnsignedChar>(result!.mutableBytes)
        CC_MD5(data!.bytes, CC_LONG(data!.length), resultBytes)
        
        let buff = UnsafeBufferPointer<CUnsignedChar>(start: resultBytes, count: result!.length)
        let hash = NSMutableString()
        for i in buff {
            hash.appendFormat("%02x", i)
        }
        return hash as String
    }
}
