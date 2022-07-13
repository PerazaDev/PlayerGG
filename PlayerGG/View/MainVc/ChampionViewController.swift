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
    var icons : [String] = []
    var champions : [ChampionModel] = [] {didSet { DispatchQueue.main.async {
        self.championsTV.reloadData()
        
    }
        
    }}
    var resultSearchController = UISearchController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData ()
    }

    func setupView(){
        self.title = "Campeones"
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass")?.withTintColor(.gray, renderingMode: .alwaysOriginal), style: .done, target: self, action: #selector(didSearch))
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
        //se hace la peticion de la lista de champions y se recibe mediante un closure
        ChampionViewModel.shared.getChampion { champs in
            DispatchQueue.main.async {
                self.championsTV.refreshControl?.endRefreshing()
            }
            if let champsList = champs, !(champsList.data.isEmpty) {
                self.champions = champsList.data.values.reversed()
                self.champions.sort { champ1, champ2 in
                    champ1.name<champ2.name
                }
            }
            else{
                self.championsTV.setEmptyMessage("Sin datos")
            }
        }
    }
}
extension ChampionViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.champions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //validamos que haya una celda con el identifier y asi la reutilizamos
        guard let cell = championsTV.dequeueReusableCell(withIdentifier: "championCustomCell", for: indexPath) as? ChampionTableViewCell else{
            return UITableViewCell()
            
        }
        ChampionViewModel.shared.getIcoinChampionURL(typeimage: .icon, icon: self.champions[indexPath.row].id) { img in
            cell.configureCell(name: self.champions[indexPath.row].name, icon: img)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChampionDetailViewController()
        vc.championId = self.champions[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension ChampionViewController : UISearchBarDelegate, UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //self.navigationItem.searchController = nil
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !resultSearchController.isActive {
            resultSearchController.isActive = true
            resultSearchController.searchBar.becomeFirstResponder()
        }
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
    
    
    
}
