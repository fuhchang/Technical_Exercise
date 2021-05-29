//
//  ProjectInfoCell.swift
//  Technical_Exercise
//
//  Created by Fuh chang Loi on 29/5/21.
//

import Foundation
import UIKit

class ProjectInfoCell: UITableViewCell {
    
    lazy var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var displayName: UILabel = {
       let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String, imageData: Data?) {
        if let imgData = imageData {
            avatarView.image = UIImage(data: imgData)
            avatarView.contentMode = .scaleAspectFit
        }
        displayName.text = "Project Title: \(name)"
    }
    
    func layout() {
        self.addSubview(avatarView)
        self.addSubview(displayName)
    }
    
    private func addConstraints() {
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        avatarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        avatarView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        avatarView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        displayName.translatesAutoresizingMaskIntoConstraints = false
        displayName.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        displayName.leadingAnchor.constraint(equalTo: avatarView.safeAreaLayoutGuide.trailingAnchor, constant: 2).isActive = true
        displayName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        displayName.centerYAnchor.constraint(equalToSystemSpacingBelow: avatarView.safeAreaLayoutGuide.centerYAnchor, multiplier: 0).isActive = true
    }
}
