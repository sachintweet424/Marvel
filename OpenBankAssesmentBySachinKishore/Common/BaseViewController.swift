//
//  BaseViewController.swift
//  OpenBankBySachinKishore
//
//  Created by Techugo on 10/02/22.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showAlertView(title : String,messsage: String)  {
        let alertController = UIAlertController(title: title, message: messsage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
