

import Foundation

var baseUrl = "https://gateway.marvel.com:443/v1/public/"

class APIClass {
    
    //MARK: Get Api Request Method
    func getList(url : String,completion:@escaping (_ jsonData:Data? , _ error:Error?, _ statuscode : Int? )->()){
        if InternetConnectCheckClass.isConnectedToNetwork(){
            let request = URLRequest(url: URL.init(string: url)!)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    guard let httpResponse = response as? HTTPURLResponse else{return}
                    if let error = error {
                        completion(nil,error,httpResponse.statusCode)
                        return
                    }
                    guard let responseData = data else {
                        return
                    }
                    if httpResponse.statusCode == 200{
                        completion(responseData,nil,httpResponse.statusCode)
                    }else{
                        completion(responseData,nil,httpResponse.statusCode)
                    }
                }
            }
            task.resume()
        }
        else{
          showAlertView(title: internetIssue, messsage: connectToInternet)
        }
    }

}

