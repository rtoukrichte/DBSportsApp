//
//  ReusableCell.swift
//  DBSports
//
//  Created by Rida TOUKRICHTE on 02/01/2024.
//

import Foundation

protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    static var reuseIdentifier: String {
        return String.init(describing: self)
    }
}

protocol ConfigurableCell: ReusableCell, NibLoadable {
    func configureCell(with item: String)
}
