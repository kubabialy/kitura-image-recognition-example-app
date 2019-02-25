//
//  FileForm.swift
//  Application
//
//  Created by Kuba Bialy on 25/02/2019.
//

import Kitura
import KituraContracts

struct FileForm: Codable, QueryParams {
    let file: String
}
