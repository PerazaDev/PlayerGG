//
//  ChampionsResponseModel.swift
//  Lolsito
//
//  Created by Daniel Sanchez Peraza on 18/03/22.
//

import Foundation
struct ChampionsResponseModel :Decodable {
    let data : [String : ChampionModel]
}


struct ChampionModel :Decodable{
    let id : String
    let name :String
    let title :String
    let tags :[String]?
    let lore :String?
    let image : ChampionImageModel
    let skins : [ChampionSkinModel]?
     
    
}
struct ChampionImageModel :Decodable{
    let full : String
    let sprite : String
}
struct ChampionSkinModel :Decodable {
    let num : Int
    let name : String
}

