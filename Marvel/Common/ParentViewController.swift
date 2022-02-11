

import UIKit
import AVFoundation

//This is the parent class of UIViewController.It has all common Funcationality
class ParentViewController: UIViewController {

    //MARK: Genrate hash from Cryptokit
    var progressLoader : UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Set Activity Indicator on Screen
    func setActivityIndicator() {
        progressLoader = ActivityProgressView.indicator(at: self.view.center)
        self.view.addSubview(progressLoader!)
        progressLoader?.startAnimating()
    }
    
    //MARK: Show Alert On Screen
    func showAlertView(title : String,messsage: String)  {
        let alertController = UIAlertController(title: title, message: messsage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

}
