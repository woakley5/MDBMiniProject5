//
//  AlamofireClient.swift
//  MDBSocials
//
//  Created by Will Oakley on 3/12/18.
//  Copyright © 2018 Will Oakley. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON

class AlamofireClient {
    
    static func getPosts() -> Promise<[Post]> {
        return Promise { fufill, error in
            Alamofire.request("https://mdb-socials.herokuapp.com/posts").responseJSON { response in
                if let response = response.result.value {
                    let json = JSON(response)
                    //print(dataJSON)
                    var postArray: [Post] = []
                    for e in json {
                        if let result = e.1.dictionaryObject {
                            if let post = Post(JSON: result){
                                postArray.append(post)
                            }
                        }
                    }
                    fufill(postArray)
                }
            }
        }
    }
    
    static func getUserWithId(id: String) -> Promise<UserModel> {
        return Promise { fulfill, error in
            Alamofire.request("https://mdb-socials.herokuapp.com/user/\(id)").responseJSON { response in
                if let response = response.result.value {
                    let json = JSON(response)
                    if let result = json.dictionaryObject {
                        if let user = UserModel(JSON: result){
                            fulfill(user)
                        }
                    }
                }
            }
        }
    }
}
