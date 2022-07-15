//
//  ChampionProtocols.swift
//  PlayerGG
//
//  Created by Daniel Sanchez Peraza on 13/07/22.
//

import Foundation
protocol ChampionsViewProtocol : AnyObject{
    func loadChampions(for championsObj : ChampionsResponseModel?)
    func getIconChampion(for imgURL : URL?)

}
protocol ChampionDetailViewProtocol : AnyObject{
    func loadChampion(for champ : ChampionModel)
}
protocol IconChampionProtocol : AnyObject {
}
