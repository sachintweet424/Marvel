
import Foundation
import UIKit
import CryptoKit


enum Constants : String{
    case publicKey
    case privateKey
}

//MARK: Set Shadow of View
func setCellCardShadow(view : UIView){
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 0.0 ,height:0.0)
    view.layer.shadowOpacity = 0.4
    view.layer.shadowRadius = 3.0
    view.layer.masksToBounds = false
    
}
//MARK: Genrate hash from Cryptokit
func md5Hash(_ source: String) -> String {
    let digest = Insecure.MD5.hash(data: source.data(using: .utf8) ?? Data())
    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
}

//MARK: Get Keys from Info Plist file
func getPublicPrivateKeys() -> [String:String] {
    if let path = Bundle.main.path(forResource:"Marvel", ofType: "plist") {
        let plist = NSDictionary(contentsOfFile: path) ?? ["":""]
        let publicKey = plist[Constants.publicKey.rawValue] as! String
        let privateKey = plist[Constants.privateKey.rawValue] as! String
         let dict = [Constants.publicKey.rawValue:publicKey,Constants.privateKey.rawValue:privateKey]
        return dict

    }
    return ["":""]

}

//MARK: Image View Class for Caching the image and downloading
class CustomImageView: UIImageView {
    let imageCache = NSCache<NSString, AnyObject>()
    var imageURLString: String?

    func downloadImageFrom(urlString: String, imageMode: UIView.ContentMode) {
        guard let url = URL(string: urlString) else { return }
        downloadImageFrom(url: url, imageMode: imageMode)
    }

    func downloadImageFrom(url: URL, imageMode: UIView.ContentMode) {
        contentMode = imageMode
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                    self.imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
                    self.image = imageToCache
                }
            }.resume()
        }
    }
}


//MARK: Show Alert On Screen
func showAlertView(title : String,messsage: String)  {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let alertController = UIAlertController(title: title, message: messsage, preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
    }
    alertController.addAction(okAction)
    appDelegate.window?.rootViewController?.present(alertController, animated: true, completion: nil)
}
