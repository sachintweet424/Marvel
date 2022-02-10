
import Foundation
import UIKit

let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
let detailStoryBoard = UIStoryboard.init(name: "Detail", bundle: nil)

extension CharacterListViewController{
    class func instance()-> CharacterListViewController{
        return mainStoryboard.instantiateViewController(withIdentifier: "CharacterListViewController") as! CharacterListViewController
    }
    
    class func navigation()-> UINavigationController{
        return mainStoryboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
    }
}
extension CharacterDetailViewController{
    class func instance()-> CharacterDetailViewController{
        return detailStoryBoard.instantiateViewController(withIdentifier: "CharacterDetailViewController") as! CharacterDetailViewController
    }
    
}

