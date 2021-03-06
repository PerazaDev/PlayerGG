//
//  ChampionDetailViewController.swift
//  PlayerGG
//
//  Created by Daniel Sanchez Peraza on 02/07/22.
//

import UIKit

class ChampionDetailViewController: UIViewController {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var loreLb: UILabel!
    @IBOutlet weak var skinsCollectionView: UICollectionView! {didSet {
        skinsCollectionView.delegate = self
        skinsCollectionView.dataSource = self
        skinsCollectionView.register(UINib(nibName: "\(SkinsCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "skinsCustomCell")
    }}
    @IBOutlet weak var loreTitle: UILabel!
    @IBOutlet weak var splashImage: UIImageView!
    var championId = ""
    var championDetail : ChampionModel? = nil {didSet{
        DispatchQueue.main.async {
            self.skinsCollectionView.reloadData()
        }
    }}
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView ()

    }
    private func setupView (){
       // skinsCollectionView.delegate = self
       // skinsCollectionView.dataSource = self
        ChampionServices.shared.getChampion(name: championId) { champ in
            ChampionServices.shared.getIcoinChampion(typeimage: .full, icon: "\(self.championId)_0") { img in
                ChampionServices.shared.getIcoinChampion(typeimage: .portrait, icon: "\(self.championId)_0") { img2 in
                    DispatchQueue.main.async {
                        self.championDetail = champ
                        self.mainImage.image = img
                        self.splashImage.image = img2
                        self.nameLb.text = champ.name
                        self.loreTitle.text = champ.title
                        self.loreLb.text = champ.lore
                    }
                }
            }
        }
    }

}
extension ChampionDetailViewController :UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.championDetail?.skins?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = skinsCollectionView.dequeueReusableCell(withReuseIdentifier: "skinsCustomCell", for: indexPath) as? SkinsCollectionViewCell else{
            return UICollectionViewCell()
            
        }
        ChampionServices.shared.getIcoinChampionURL(typeimage: .portrait, icon: "\(self.championDetail?.id ?? "")_\(self.championDetail?.skins?[indexPath.row].num ?? 0)") { img in
            cell.configure(name: self.championDetail?.skins?[indexPath.row].name ?? "", skin: img)
        }
        /*ChampionViewModel.shared.getIcoinChampion(typeimage: .portrait, icon: "\(self.championDetail?.id ?? "")_\(self.championDetail?.skins?[indexPath.row].num ?? 0)") { img in
            cell.configure(name: self.championDetail?.skins?[indexPath.row].name ?? "", skin: img)
            
        }*/
        /*ChampionViewModel.shared.getIcoinChampion(typeimage: .icon, icon: self.champions[indexPath.row].id) { img in
            cell.configureCell(name: self.champions[indexPath.row].name, icon: img)
        }*/
        return cell
        
    }
    
    
}
