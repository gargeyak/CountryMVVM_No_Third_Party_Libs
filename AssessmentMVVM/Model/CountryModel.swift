//
//  CountryModel.swift
//  AssessmentMVVM
//
//  Created by Ady on 11/1/18.
//  Copyright © 2018 Ady. All rights reserved.
//

import Foundation

struct CountryModel: Codable {
    var Response: [Response]
}

struct Response: Codable {
    var Name: String
    var FlagPng: String
}
