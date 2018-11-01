//
//  NetworkHandler.swift
//  AssessmentMVVM
//
//  Created by Ady on 11/1/18.
//  Copyright © 2018 Ady. All rights reserved.
//

import Foundation

let apiUrl = "http://countryapi.gear.host/v1/Country/getCountries"

final class NetworkHandler: NSObject {
    
    private override init() {}
    static let sharedInstance = NetworkHandler()
    
    
    func fetchDataFromApi(completion: @escaping ([Response], Error?) -> ()) {
        
        guard let url = URL(string: apiUrl) else {
            completion([], Errors.incorrectUrl)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error == nil {
                
                do{
                    let decodedData = try JSONDecoder().decode(CountryModel.self, from: data!)
                    completion(decodedData.Response, nil)
                }catch{
                    completion([], Errors.parseError)
                }
            }else{
                completion([], Errors.fetchError)
            }
        }.resume()
    }
}
