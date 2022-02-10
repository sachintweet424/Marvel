//
//  CharacterDetailVC.swift
//  OpenBankBySachinKishore
//
//  Created by Techugo on 10/02/22.
//

import UIKit

class CharacterDetailViewController: BaseViewController {

   
    @IBOutlet weak var marvelImageView: CustomImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var detailViewModel : CharacterDetailViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailViewModel?.delegate = self
        self.detailViewModel?.getCharacterDetailsApi()
    }
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
extension CharacterDetailViewController : CharacterDetailViewModelProtocol{
    func getListOfCharacters() {
        self.setData()
    }
    
    func getErrorFrom(err: String) {
        self.showAlertView(title: error, messsage: err)
    }
    
    func getErrorFromServer() {
        self.showAlertView(title: error, messsage: serverMsg)
    }
    
    
}
 

