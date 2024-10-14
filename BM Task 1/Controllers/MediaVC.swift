//
//  MediaVC.swift
//  BM Task 1
//
//  Created by Apple on 23/07/2024.
//

import UIKit
import SDWebImage
import Alamofire

class MediaVC: UIViewController {

    @IBOutlet weak var mediaTaleView: UITableView!
    
    @IBOutlet weak var searchTxtField: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var searchBtn: UIButton!
    var user: User!
    
    var apiResult = [TVShowsResponse]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaultsManager.shared().isLoggedIn = true
        setupTableView()
        setupSpinner()
        fetchShows(search: "default")
        
        
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(rightButtonTapped))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        searchBtn.addTarget(self, action: #selector(searchButton), for: .touchUpInside)
        
        searchBtn.layer.cornerRadius =  searchBtn.frame.width/2
        searchBtn.layer.masksToBounds = true
  
    }
     @objc func rightButtonTapped() {
         navigateToProfileScreen()
    }
    @objc func searchButton() {
        
        guard let searchText = searchTxtField.text, !searchText.isEmpty else {
            showALert(title: "Please", message: "enter your key word search")
            return
        }
        fetchShows(search: searchText)
        
    }
    private func navigateToProfileScreen() {
        let sb = UIStoryboard(name: StoryBoards.main, bundle: nil)
        let profVC = sb.instantiateViewController(withIdentifier: VCs.profile) as! ProfileVC
        profVC.user = user
        self.navigationController?.pushViewController(profVC, animated: true)
        }
    private func setupTableView() {
        mediaTaleView.delegate = self
        mediaTaleView.dataSource = self
        mediaTaleView.separatorStyle = .none
        mediaTaleView.register(UINib(nibName: Cells.mediaCell, bundle: nil), forCellReuseIdentifier: Cells.mediaCell)
    }
    
    
    private func setupSpinner(){
        spinner.center =  view.center
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
    }
    private func fetchShows(search: String) {
        spinner.startAnimating()
        ApiManager.getShows(search: searchTxtField.text!) { [weak self] error, tvShowArr in
            guard let self = self else {return}
            self.spinner.stopAnimating()
            if let tvShowArr = tvShowArr {
                self.apiResult = tvShowArr
                print("API Result: \(self.apiResult)")
                self.mediaTaleView.reloadData()
            } else {
                print("Error fetching TV shows: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
   
    
}
extension MediaVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = mediaTaleView.dequeueReusableCell(withIdentifier: Cells.mediaCell, for: indexPath) as? MediaCell else {
            return UITableViewCell()
        }
        let media = apiResult[indexPath.row]
        cell.configureCell(media: media)
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //mediaTaleView.deselectRow(at: indexPath, animated: false)
        let media = apiResult[indexPath.row]
        if let officialSite = media.show.officialSite, let url = URL(string: officialSite) {
            UIApplication.shared.open(url)
        } else {
            showALert(title: "no site", message: "Official website not available")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
