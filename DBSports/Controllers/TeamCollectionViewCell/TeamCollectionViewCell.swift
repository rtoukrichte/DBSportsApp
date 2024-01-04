//
//  TeamCollectionViewCell.swift
//  DBSports
//
//  Created by Rida TOUKRICHTE on 02/01/2024.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell, ConfigurableCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var teamBadge: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    func configureCell(with teamBadge: String) {
        guard let teamBadgeURL = URL(string: teamBadge) else {
            return
        }
        self.teamBadge.load(url: teamBadgeURL) { isLoaded in
            if isLoaded {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.teamBadge.isHidden = false
                    self.activityIndicator.isHidden = true
                }
            }
        }
    }
    
}

extension UIImageView {
    func load(url: URL, completion: @escaping (Bool) -> ()) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                    completion(true)
                }
            }
            completion(false)
        }
    }
}
