

import Foundation
import CryptoKit

protocol CharacterDetailViewModelProtocol : AnyObject{
    func getListOfCharacters()
    func getErrorFrom(err : String)
    func getErrorFromServer()
}
class CharacterDetailViewModel {
    
    var characterModel : CharacterModel?
    weak var delegate : CharacterDetailViewModelProtocol?
    private var publicKey = getApiKeys()[Constants.publicKey.rawValue] ?? ""
    private var privateKey = getApiKeys()[Constants.privateKey.rawValue] ?? ""
    var charcterId : String?
    init(id : String) {
        self.charcterId = id
    }
    func getCharacterDetailsApi(){
        let ts = String(Int(Date().timeIntervalSinceNow))
        let hash = md5Hash("\(ts)\(privateKey)\(publicKey)")
        let url = "\(baseUrl)characters/\(self.charcterId ?? "")?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        APIClass.init().getList(url: url, completion: { jsonData, error, statuscode in
            if let error = error {
                self.delegate?.getErrorFrom(err: error.localizedDescription)
                return
            }
            if let statuscode = statuscode {
                if statuscode == 200{
                    let jsonDecoder = JSONDecoder()
                    self.characterModel = try? jsonDecoder.decode(CharacterModel.self, from: jsonData!)
                    self.delegate?.getListOfCharacters()
                }else{
                    self.delegate?.getErrorFromServer()
                }
            }
        })
    }
}

