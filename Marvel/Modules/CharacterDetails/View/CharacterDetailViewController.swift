//
//  CharacterDetailVC.swift
//  OpenBankBySachinKishore
//
//  Created by Techugo on 10/02/22.
//

import UIKit

class CharacterDetailViewController: ParentViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var marvelImageView: CustomImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: Variables
    var detailViewModel : CharacterDetailViewModel?
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailViewModel?.delegate = self
        self.setActivityIndicator()
        self.detailViewModel?.getCharacterDetailsApi()
    }
    
    //MARK: set Data from Api to Outlets
    func setData(){
        guard let resultsArray = detailViewModel?.characterModel?.data?.results else {
            return
        }
        if resultsArray.count > 0{
            self.descriptionLabel.text = resultsArray[0].description
            self.titleLabel.text = resultsArray[0].name
            let urlString = (resultsArray[0].thumbnail?.path ?? "") + "." + (resultsArray[0].thumbnail?.extensionImage ?? "")
            self.marvelImageView.downloadImageFrom(urlString: urlString, imageMode: .scaleToFill)
        }
    }
}

//MARK: Navigation Extension
extension CharacterDetailViewController{
    class func instance()-> CharacterDetailViewController{
        let detailStoryBoard = UIStoryboard.init(name: "Detail", bundle: nil)
        return detailStoryBoard.instantiateViewController(withIdentifier: "CharacterDetailViewController") as! CharacterDetailViewController
    }
    
}

//MARK: Use of CharacterDetailViewModelProtocol
extension CharacterDetailViewController : CharacterDetailViewModelProtocol{
    func getListOfCharacters() {
        self.progressLoader?.removeFromSuperview()
        self.setData()
    }
    
    func getErrorFrom(err: String) {
        self.progressLoader?.removeFromSuperview()
        self.showAlertView(title: error, messsage: err)
    }
    
    func getErrorFromServer() {
        self.progressLoader?.removeFromSuperview()
        self.showAlertView(title: error, messsage: serverMsg)
    }
}
 

