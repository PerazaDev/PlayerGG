//
//  ChampionViewModel.swift
//  PlayerGG
//
//  Created by Daniel Sanchez Peraza on 13/07/22.
//

import Foundation

final class ChampionPresenter {
    weak var listDelegate: ChampionsVMProtocol?
    weak var detailDelegate : ChampionDetailVMProtocol?
    let services = ChampionServices()
    func loadDataChampions() {
        services.getChampion {[weak self] champs in
           self?.listDelegate?.loadChampions(for: champs)
            
        }
    }
    func getIcoinChampionURL(icon : String, completion : @escaping ()->()){
        services.getIcoinChampionURL(typeimage: .icon, icon: icon) {[weak self] img in
            self?.listDelegate?.getIconChampion(for: img)
            completion()
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

