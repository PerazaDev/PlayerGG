//
//  ChampionViewModel.swift
//  PlayerGG
//
//  Created by Daniel Sanchez Peraza on 13/07/22.
//

import Foundation

final class ChampionPresenter {
    weak var delegate: ChampionsVMProtocol?
    let services = ChampionServices()
    
    func loadDataChampions() {
        services.getChampions {[weak self] champs in
           self?.delegate?.loadChampions(for: champs)
            
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

