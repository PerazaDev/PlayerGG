//
//  ChampionProtocols.swift
//  PlayerGG
//
//  Created by Daniel Sanchez Peraza on 13/07/22.
//

import Foundation
protocol ChampionsVMProtocol : AnyObject{
    func loadChampions(for championsObj : ChampionsResponseModel?)
    func getIconChampion(for imgURL : URL?)

}
protocol ChampionDetailVMProtocol : AnyObject{
    func loadChampion(for champ : ChampionModel)
    func getIconChampion(for imgURL : URL?)
}
protocol IconChampionProtocol : AnyObject {
}
