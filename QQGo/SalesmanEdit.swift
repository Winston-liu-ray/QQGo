//
//  SalesmanEdit.swift
//  QQGo
//
//  Created by Ｗinston on 5/2/15.
//  Copyright (c) 2015 Ｗinston. All rights reserved.
//

import Foundation
import UIKit

class SalesmanEdit : UIViewController{
    
    
    @IBOutlet weak var exprEdit: UITextField!
    @IBOutlet weak var SalesmanEdit: UIScrollView!
  
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        SalesmanEdit.userInteractionEnabled = true
        SalesmanEdit.contentSize = CGSizeMake(600, 1500)
       
        
    }
}