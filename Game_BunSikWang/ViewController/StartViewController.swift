//
//  StartViewController.swift
//  Game_BunSikWang
//
//  Created by 하늘이 on 2022/07/24.
//

import UIKit

class ViewControllerStart: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnStartAction(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
