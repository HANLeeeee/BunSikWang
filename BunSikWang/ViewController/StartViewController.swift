//
//  StartViewController.swift
//  BunSikWang
//
//  Created by 하늘이 on 2022/07/24.
//

import UIKit

class ViewControllerStart: UIViewController {

    @IBOutlet weak var textFieldID: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnStartAction(_ sender: Any) {
        print(textFieldID.text!)
        if textFieldID.text?.isEmpty ?? true {
            let alert = UIAlertController(title: "아이디를 입력하세요", message: "Please enter your ID", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "확인", style: .default)
            
            alert.addAction(confirm)
            present(alert, animated: true)
            
        } else {
            UserDefaults.standard.setValue(textFieldID.text!, forKey: "userID")
            
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true)
        }
    }
}
