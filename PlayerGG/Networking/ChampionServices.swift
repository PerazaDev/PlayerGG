//
//  ChampionServices.swift
//  PlayerGG
//
//  Created by Daniel Sanchez Peraza on 21/03/22.
//

import Foundation
import UIKit

final class ChampionServices {
    static let shared = ChampionServices()
   
    //funcion para traer los campeones en general
    func getChampion(completion : @escaping (_ champs:ChampionsResponseModel?)->()){
        let urlsession = URLSession.shared
        
        let url = URL(string:"http://ddragon.leagueoflegends.com/cdn/12.5.1/data/es_MX/champion.json")
        urlsession.dataTask(with:url!) { data, response, error in
            
            //print("Data \(String(data: data!, encoding: .utf8) ?? "")")
            if let data = data {
                guard let champResponse = try? JSONDecoder().decode(ChampionsResponseModel.self, from: data)else{
                    return completion(nil)
                }
                completion(champResponse)
            }else{
                completion(nil)
            }
            
            
        }.resume()
    }
    
    //funcion para obtener un campeon en especifico
    func getChampion(name : String, success : @escaping (_ champ:ChampionModel)->()){
        let urlsession = URLSession.shared
        
        let url = URL(string:"http://ddragon.leagueoflegends.com/cdn/12.5.1/data/es_MX/champion/\(name).json")
        urlsession.dataTask(with:url!) { data, response, error in
            guard let champResponse = try? JSONDecoder().decode(ChampionsResponseModel.self, from: data!)else{
                return
            }
            success(champResponse.data.first!.value)
            
        }.resume()
    }
    
    
    //funcion para obtener un tipo de imagen
    func getIcoinChampion(typeimage :TypeImage, icon :String, completion : @escaping (_ img :UIImage?)->()) {
        print("logoo \(icon)")
        let urlsession = URLSession.shared
        var endpoint = ""
        switch typeimage {
        case .icon:
            endpoint = "http://ddragon.leagueoflegends.com/cdn/12.5.1/img/champion/\(icon).png"
        case .full:
            endpoint = "http://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(icon).jpg"
        case .portrait:
            endpoint = "http://ddragon.leagueoflegends.com/cdn/img/champion/loading/\(icon).jpg"
        }
        guard let url = URL(string: endpoint) else{return completion(nil)}
        urlsession.dataTask(with: url) { data, response, error in
            guard let icon = UIImage(data: data!)else{return completion(nil)}
            completion(icon)
        }.resume()
        
    }
    func getIcoinChampionURL(typeimage :TypeImage, icon :String, completion : @escaping (_ img :URL?)->()) {
        var endpoint = ""
        switch typeimage {
        case .icon:
            endpoint = "http://ddragon.leagueoflegends.com/cdn/12.5.1/img/champion/\(icon).png"
        case .full:
            endpoint = "http://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(icon).jpg"
        case .portrait:
            endpoint = "http://ddragon.leagueoflegends.com/cdn/img/champion/loading/\(icon).jpg"
        }
        guard let url = URL(string: endpoint) else{return completion(nil)}
        return completion(url)
        
    }
}

enum TypeImage {
    case icon
    case full
    case portrait
}
