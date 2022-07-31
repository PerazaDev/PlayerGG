//
//  ChampionViewModel.swift
//  PlayerGG
//
//  Created by Daniel Sanchez Peraza on 13/07/22.
//

import Foundation

final class ChampionViewModel {
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
    
}

