//
//  HeaderCollectionReusableView.swift
//  Testik
//
//  Created by Михаил Зайцев on 10.07.2021.
//

import UIKit

final class HeaderCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Const, Var & Outlets
    static let identifier = "HeaderCollectionReusableView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        return label
    } ()
    
    // MARK: - Methods
    public func configure () {
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
