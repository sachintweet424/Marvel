//
//  CharacterListCell.swift
//  OpenBankBySachinKishore
//
//  Created by Techugo on 09/02/22.
//

import UIKit

class CharacterListTableViewCell: UITableViewCell {

    @IBOutlet weak var characterImageView: CustomImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
  
    
    static let nib = UINib.init(nibName: "CharacterListTableViewCell", bundle: nil)
    static let indent = "CharacterListTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    func bindData(model : ResultsModel?){
        guard let model = model else {
            return
        }
        if model.description ?? "" == ""{
            self.descriptionLabel.isHidden = true
        }else{
            self.descriptionLabel.isHidden = false
        }
        self.descriptionLabel.text = model.description
        self.titleLabel.text = model.name
        let urlString = (model.thumbnail?.path ?? "") + "." + (model.thumbnail?.extensionImage ?? "")
        self.characterImageView.downloadImageFrom(urlString: urlString, imageMode: .scaleAspectFill)
      
    }
    
}
