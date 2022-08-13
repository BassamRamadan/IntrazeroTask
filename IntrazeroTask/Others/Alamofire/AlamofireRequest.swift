

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper


class AlamofireRequests {
    class func getMethod(url: String ,_ info: [String : Any] = [:], headers: [String : String] , complition:  @escaping (_ error:Error? ,_ success: Bool ,_ data:Data)->Void){
        
        Alamofire.request(url, method: .get, parameters: info, encoding: URLEncoding.queryString, headers: headers).responseData { (response) in
            switch response.result
            {
            case .failure(let error):
                complition(error, false , Data())
            case .success(let value):
                complition(nil, true , value)
            }
        }
    }
}
