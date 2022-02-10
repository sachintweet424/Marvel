//
//  ListVC.swift
//  OpenBankBySachinKishore
//
//  Created by Techugo on 09/02/22.
//

import UIKit

class CharacterListViewController: BaseViewController {

    @IBOutlet weak var listTableView: UITableView!
    var characterListViewModel = CharacterListViewModel()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.characterListViewModel.delegate = self
        self.listTableView.register(CharacterListTableViewCell.nib, forCellReuseIdentifier: CharacterListTableViewCell.indent)
        self.setActivityIndicator()
        self.characterListViewModel.getCharacterList()
    }
  
}

extension CharacterListViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characterListViewModel.characterModel?.data?.results?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterListTableViewCell.indent) as! CharacterListTableViewCell
        cell.bindData(model: self.characterListViewModel.characterModel?.data?.results?[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewControllerInstance = CharacterDetailViewController.instance()
        viewControllerInstance.detailViewModel = CharacterDetailViewModel.init(id: "\(self.characterListViewModel.characterModel?.data?.results?[indexPath.row].id ?? 0)")
        self.present(viewControllerInstance, animated: true, completion: nil)
    }
}

extension CharacterListViewController : characterListViewModelProtocols{
    func getListOfCharacters() {
        self.progressLoader?.removeFromSuperview()
        self.listTableView.reloadData()
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
 
