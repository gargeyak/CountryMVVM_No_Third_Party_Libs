//
//  NetworkHandler.swift
//  AssessmentMVVM
//
//  Created by Ady on 11/1/18.
//  Copyright © 2018 Ady. All rights reserved.
//

import Foundation

let apiUrl = "http://countryapi.gear.host/v1/Country/getCountries"

final class NetworkHandler {
    
    private init() {}
    static let sharedInstance = NetworkHandler()
    
    
    func fetchDataFromApi(completion: @escaping ([Response], Error?) -> ()) {
        
        guard let url = URL(string: apiUrl) else {
            completion([], Errors.incorrectUrl)
            return
        }
        
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                DispatchQueue.main.async {
                    if error != nil {
                        completion([], Errors.fetchError)
                    } else if let jsonData = data {
                        do{
                            let decodedData = try JSONDecoder().decode(CountryModel.self, from: jsonData)
                            completion(decodedData.Response, nil)
                            
                        } catch {
                            completion([], Errors.parseError)
                        }
                    }
                }
                }.resume()
        }
    }
}
