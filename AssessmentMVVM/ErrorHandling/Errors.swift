//
//  Errors.swift
//  AssessmentMVVM
//
//  Created by Ady on 11/1/18.
//  Copyright © 2018 Ady. All rights reserved.
//

import Foundation

enum Errors: Error {
    
    case incorrectUrl
    case parseError
    case fetchError
    
    var localizedDescription: String {
        
        switch self {
        case .incorrectUrl:
            return "Incorrect Url"
        case .parseError:
            return "Unable to get response"
        case .fetchError:
            return "Error fetching data from Api"
        }
    }
}
