//
//  NewCommentViewController.swift
//  Diversidade
//
//  Created by Francisco José A. C. Souza on 05/05/16.
//  Copyright © 2016 Francisco José A. C. Souza. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewCommentViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var nameTextView: UITextField!
    @IBOutlet weak var commentTextView: UITextView!
    
    var centerId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onDoneTap(sender: AnyObject) {
        if commentTextView.text.isEmpty {
            let alert = UIAlertController(title: "Erro", message: "O campo comentário não pode ser vazio", preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: { (action) in
                alert.dismissViewControllerAnimated(true, completion: nil)
            })
            
            alert.addAction(okAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            self.sendCommentToServer()
        }
    }
    
    @IBAction func onCancelTap(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onTapMainView(sender: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        self.commentTextView.becomeFirstResponder()
        
        return false
    }
    
    func setupTextView() {
        commentTextView.layer.backgroundColor = UIColor.whiteColor().CGColor
        commentTextView.layer.borderColor = UIColor(red: 212/255, green: 212/255, blue: 212/255, alpha: 0.8).CGColor
        commentTextView.layer.borderWidth = 0.8
        commentTextView.layer.cornerRadius = 8.0
        commentTextView.layer.masksToBounds = true
    }
    
    func sendCommentToServer() {
        let postParams = [
            "name" : nameTextView.text!.isEmpty ? "Anônimo" : nameTextView.text!,
            "text" : commentTextView.text
        ]

        let requestUrl = UrlFormatter.urlForCommentPost(centerId)

        print(requestUrl)

        Alamofire.request(.POST, requestUrl, parameters: postParams, encoding: .JSON).responseJSON { (response) in
            switch response.result {
            case .Success:
                self.dismissViewControllerAnimated(true, completion: nil)
                
            case .Failure:
                let alert = UIAlertController(title: "Erro", message: "Erro de comunicação com o servidor. Verifique a conexão com a internet e tente mais tarde.", preferredStyle: .Alert)
                
                let okAction = UIAlertAction(title: "OK", style: .Default, handler: { (action) in
                    alert.dismissViewControllerAnimated(true, completion: nil)
                })
                
                alert.addAction(okAction)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
}
