//
//  CurrencyModel.swift
//  HomeStay
//
//  Created by Sunil Kumar on 28/12/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import Foundation
struct LanguageModel: Codable {
    let code: Int?
    let data: LanguageData?
    let message: String?
}
struct  LanguageData: Codable{
    
    let language_list: [LanguageList]?
}
struct LanguageList: Codable {
    let lang_code: String?
    let name: String?
}

struct CurrencylistModel: Codable {
    
    let code: Int?
    let data: CurrencyData?
    let message: String?
}
struct  CurrencyData: Codable{
    
    let currency_list: [CurrencyNameList]?
}
struct CurrencyNameList: Codable {
    let currency_type: String?
    let currency_symbols: String?
}
