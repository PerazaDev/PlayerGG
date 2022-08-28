//
//  ChampionViewController.swift
//  PlayerGG
//
//  Created by Daniel Sanchez Peraza on 02/07/22.
//

import UIKit

class ChampionViewController: UIViewController {
    //MARK: IBOulets
    @IBOutlet weak var championsTV: UITableView!{
        didSet {
            self.championsTV.register(UINib(nibName:"\(ChampionTableViewCell.self)",bundle: nil), forCellReuseIdentifier: "championCustomCell")
            self.championsTV.delegate = self
            self.championsTV.dataSource = self
            self.championsTV.refreshControl = UIRefreshControl()
            self.championsTV.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        }
    }
    //MARK: Variables
    var iconCurrent : URL?
    var champions : [ChampionModel] = [] {didSet { DispatchQueue.main.async {
        self.championsTV.reloadData()
            }
        }
    }
    var filteredChampions : [ChampionModel] = [] {didSet { DispatchQueue.main.async {
        self.championsTV.reloadData()
            }
        }
    }
    var resultSearchController = UISearchController()
    let presenter = ChampionPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.listDelegate = self
        fetchData ()
    }

    func setupView(){
        self.title = "Campeones"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.hidesSearchBarWhenScrolling = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setSearchController()
   
        
    }
    
    private func setSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Buscar"
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        navigationItem.searchController = searchController
        resultSearchController = searchController
        searchController.searchBar.delegate = self

    }
    @objc func didPullToRefresh() {
        self.championsTV.refreshControl?.beginRefreshing()
        fetchData()
    }
    @objc func didSearch(){
        setSearchController()
    }
    func fetchData () {
        presenter.loadDataChampions()
    }
}
extension ChampionViewController : ChampionsVMProtocol {
    func getIconChampion(for imgURL: URL?) {
            self.iconCurrent = imgURL
    }
    
    func loadChampions(for championsObj: ChampionsResponseModel?) {
        DispatchQueue.main.async {
            self.championsTV.refreshControl?.endRefreshing()
        }
        if let champsList = championsObj, !(champsList.data.isEmpty) {
            self.champions = champsList.data.values.reversed()
            self.champions.sort { champ1, champ2 in
                champ1.name<champ2.name
            }
        }
        else{
            DispatchQueue.main.async {
                self.championsTV.setEmptyMessage("Sin datos")
            }
        }
    }
}

extension ChampionViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultSearchController.isActive {
            return self.filteredChampions.count
        }
        return self.champions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //validamos que haya una celda con el identifier y asi la reutilizamos
        guard let cell = championsTV.dequeueReusableCell(withIdentifier: "championCustomCell", for: indexPath) as? ChampionTableViewCell else{
            return UITableViewCell()
        }
        if resultSearchController.isActive {
             let url = URL(string: presenter.getIconPath(typeimage: .icon, icon: self.filteredChampions[indexPath.row].id))
            cell.configureCell(name: self.filteredChampions[indexPath.row].name, icon: url)

            
        }else{
            let url = URL(string: presenter.getIconPath(typeimage: .icon, icon: self.champions[indexPath.row].id))
           cell.configureCell(name: self.champions[indexPath.row].name, icon: url)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if resultSearchController.isActive {
            let vc = ChampionDetailViewController()
            vc.championId = self.filteredChampions[indexPath.row].id
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = ChampionDetailViewController()
            vc.championId = self.champions[indexPath.row].id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension ChampionViewController : UISearchBarDelegate, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else{return}
        filteredChampions = champions.filter({ champ in
            return champ.name.lowercased().contains(text.lowercased())
        })

    }
    
    
    
}
