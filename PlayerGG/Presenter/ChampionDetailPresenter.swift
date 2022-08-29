//
//  ChampionDetailPresenter.swift
//  PlayerGG
//
//  Created by Daniel Sanchez Peraza on 28/08/22.
//

import Foundation

class ChampionDetailPresenter {
    weak var delegate : ChampionDetailVMProtocol?
    let services = ChampionServices()
    
    func loadDataChampion(name: String) {
        services.getChampion(name: name) { [weak self] champ in
            self?.delegate?.loadChampion(for: champ)
        }
    }
    func getIconPath(typeimage :TypeImage, icon :String) -> String {
        var endpoint = ""
        switch typeimage {
        case .icon:
            endpoint = "http://ddragon.leagueoflegends.com/cdn/12.5.1/img/champion/\(icon).png"
        case .full:
            endpoint = "http://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(icon).jpg"
        case .portrait:
            endpoint = "http://ddragon.leagueoflegends.com/cdn/img/champion/loading/\(icon).jpg"
        }
        return endpoint
    }
}
