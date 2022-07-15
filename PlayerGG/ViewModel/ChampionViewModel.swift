//
//  ChampionViewModel.swift
//  PlayerGG
//
//  Created by Daniel Sanchez Peraza on 13/07/22.
//

import Foundation

final class ChampionViewModel {
    weak var view: ChampionsViewProtocol?
    let services = ChampionServices()
    func loadDataChampions() {
        services.getChampion {[weak self] champs in
           self?.view?.loadChampions(for: champs)
            
        }
    }
    func getIcoinChampionURL(icon : String, completion : @escaping ()->()){
        services.getIcoinChampionURL(typeimage: .icon, icon: icon) {[weak self] img in
            self?.view?.getIconChampion(for: img)
            completion()
        }
    }
    
}

