//
//  ShowResearchViewController.swift
//  COOking app
//
//  Created by 井上げんき on 2020/12/04.
//

import UIKit
import  NCMB
import KRProgressHUD
import Kingfisher

class ShowResearchViewController: UIViewController,UITextFieldDelegate {
    
    var posts = [Post]()

    @IBOutlet weak var SaveCodeTextfield: UITextField!
    
    @IBOutlet weak var codeTextfield: UITextField!
    
    @IBOutlet weak  var peopleTextfield: UITextField!
    
    @IBOutlet var recipeTextfield: UITextField!
    
    @IBOutlet var recipe2Textfield: UITextField!
   
    @IBOutlet var CookImageview: UIImageView!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        SaveCodeTextfield.delegate = self
        codeTextfield.delegate = self
        peopleTextfield.delegate = self
        recipeTextfield.delegate = self
        recipe2Textfield.delegate = self
    
    
        self.SaveCodeTextfield.keyboardType = UIKeyboardType.numberPad
        self.codeTextfield.keyboardType = UIKeyboardType.numberPad
        self.peopleTextfield.keyboardType = UIKeyboardType.numberPad
        
        
    }
    

  

}
