//
//  CountryViewModel.swift
//  AssessmentMVVM
//
//  Created by Ady on 11/1/18.
//  Copyright © 2018 Ady. All rights reserved.
//

import Foundation

class CountryViewModel {
    
    var countryArr: [Response] = []
    
    
    func getDataFromApi(completion: @escaping (Error?) -> ()) {
        
        NetworkHandler.sharedInstance.fetchDataFromApi { [unowned self] (responseArr, error) in
            
            if error == nil {
                self.countryArr = responseArr
                completion(nil)
            }else{
                completion(error)
            }
        }
    }
}

