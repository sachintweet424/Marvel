
import Foundation
import CryptoKit

protocol characterListViewModelProtocols : AnyObject{
    func getListOfCharacters()
    func getErrorFrom(err : String)
    func getErrorFromServer()
}
class ListViewModel {
    
    var characterModel : CharacterModel?
    weak var delegate : characterListViewModelProtocols?
    private var publicKey = getApiKeys()[Constants.publicKey.rawValue] ?? ""
    private var privateKey = getApiKeys()[Constants.privateKey.rawValue] ?? ""
    
    func getCharacterList(){
        let ts = String(Int(Date().timeIntervalSinceNow))
        let hash = md5Hash("\(ts)\(privateKey)\(publicKey)")
        let url = "\(baseUrl)characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
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

