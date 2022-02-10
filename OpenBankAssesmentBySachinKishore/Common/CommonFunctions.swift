//
//  CommonFunctions.swift
//  OpenBankBySachinKishore
//
//  Created by Techugo on 09/02/22.
//

import Foundation
import UIKit
import CryptoKit


enum Constants : String{
    case publicKey
    case privateKey
}
func setCellCardShadow(view : UIView){
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 0.0 ,height:0.0)
    view.layer.shadowOpacity = 0.4
    view.layer.shadowRadius = 3.0
    view.layer.masksToBounds = false
    
}
func md5Hash(_ source: String) -> String {
    let digest = Insecure.MD5.hash(data: source.data(using: .utf8) ?? Data())
    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
}
func showLoader(){
   
}
func hideLoader(){
   
}
func getApiKeys() -> [String:String] {
    if let path = Bundle.main.path(forResource:"Marvel", ofType: "plist") {
        let plist = NSDictionary(contentsOfFile: path) ?? ["":""]
        let publicKey = plist[Constants.publicKey.rawValue] as! String
        let privateKey = plist[Constants.privateKey.rawValue] as! String
         let dict = [Constants.publicKey.rawValue:publicKey,Constants.privateKey.rawValue:privateKey]
        return dict

    }
    return ["":""]

}
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
