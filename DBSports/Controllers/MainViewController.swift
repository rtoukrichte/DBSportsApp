//
//  MainViewController.swift
//  DBSports
//
//  Created by Rida TOUKRICHTE on 02/01/2024.
//

import UIKit
import SearchTextField

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mySearchTextField: SearchTextField!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var leaguesViewModel = LeaguesViewModel()
    var teamsViewModel   = TeamsViewModel()
    
    var teamsImages: [String] = []
    var filterItems: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(TeamCollectionViewCell.nib, forCellWithReuseIdentifier: TeamCollectionViewCell.reuseIdentifier)
        collectionView.isHidden = true
        
        setupAutoComplete()
        
        bindDataViewModel()
    }

    
    // MARK: - UIButton Actions
    @IBAction func cancelButton(_ sender: Any) {
        self.mySearchTextField.resignFirstResponder()
        self.mySearchTextField.text = ""
        self.teamsImages.removeAll()
        self.collectionView.reloadData()
    }
    
    
    // MARK: - Configure Auto complete field
    func setDataAutocompleteField() {
        mySearchTextField.filterStrings(self.filterItems)
        
        mySearchTextField.itemSelectionHandler = { filteredResults, itemPosition in
            let league = filteredResults[itemPosition]
            debugPrint("Selected league == ", league.title)
            
            self.mySearchTextField.text = league.title
            
            self.mySearchTextField.resignFirstResponder()
                        
            self.fetchTeamsOfLeague(league.title)
        }
    }
    
    func setupAutoComplete() {
        mySearchTextField.placeholder = "Search by league"
        
        //mySearchTextField.maxNumberOfResults = 25
        mySearchTextField.maxResultsListHeight = Int(UIScreen.main.bounds.height/1.6)
        
        mySearchTextField.theme.font = UIFont.systemFont(ofSize: 14)
        mySearchTextField.theme.bgColor = UIColor.white
        mySearchTextField.theme.borderColor = UIColor.white
        mySearchTextField.theme.separatorColor = UIColor.lightGray
        mySearchTextField.theme.cellHeight = 40
    }
    
    // MARK: - Call ViewModel methods
    func fetchTeamsOfLeague(_ selectedLeague: String) {
        teamsViewModel.getTeamsByLeague(selectedLeague)
    }
    
    func bindDataViewModel() {
        leaguesViewModel.leaguesNames.bind { [weak self] leaguesNames in
            guard let names = leaguesNames else { return }
            self?.filterItems = names
            
            self?.updateDataLeagues()
        }
        
        teamsViewModel.teamsBadge.bind { [weak self] badges in
            guard let badges = badges else { return }
            self?.teamsImages = badges
            
            self?.updateDataTeams()
        }
    }
    
    // MARK: - Other methods
    func updateDataLeagues() {
        DispatchQueue.main.async {
            self.setDataAutocompleteField()
        }
    }
    
    func updateDataTeams() {
        DispatchQueue.main.async {
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
        }
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamsImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCollectionViewCell.reuseIdentifier, for: indexPath) as! TeamCollectionViewCell
        cell.configureCell(with: teamsImages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (self.collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size-40)
    }
}
