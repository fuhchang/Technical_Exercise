//
//  DetailInfoCell.swift
//  Technical_Exercise
//
//  Created by Fuh chang Loi on 29/5/21.
//

import Foundation
import UIKit

class DetailInfoCell: UITableViewCell {
    lazy var avatarView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var displayName: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    lazy var displayType: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        return label
    }()
    
    lazy var displayDate: UILabel = {
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
    
    func configure(name: String, type: String, date: String, imageData: Data?) {
        if let imgData = imageData {
            avatarView.image = UIImage(data: imgData)
            avatarView.contentMode = .scaleAspectFit
        }
        displayName.text = "Display name: \(name)"
        displayType.text = "Owner Type: \(type)"
        displayDate.text = "Created on: \(Utility.shared.dateFormatter(strDate: date))"
    }
    
    func layout() {
        self.addSubview(avatarView)
        self.addSubview(displayName)
        self.addSubview(displayType)
        self.addSubview(displayDate)
    }
    
    private func addConstraints() {
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        avatarView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        avatarView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        avatarView.contentMode = .scaleAspectFit
        avatarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        avatarView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        avatarView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        displayName.translatesAutoresizingMaskIntoConstraints = false
        displayName.leadingAnchor.constraint(equalTo: avatarView.safeAreaLayoutGuide.trailingAnchor, constant: 5).isActive = true
        displayName.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        displayName.bottomAnchor.constraint(equalTo: displayType.safeAreaLayoutGuide.topAnchor, constant: -5).isActive = true
        displayType.translatesAutoresizingMaskIntoConstraints = false
        displayType.centerYAnchor.constraint(equalTo: avatarView.safeAreaLayoutGuide.centerYAnchor).isActive = true
        displayType.leadingAnchor.constraint(equalTo: avatarView.safeAreaLayoutGuide.trailingAnchor, constant: 5).isActive = true
        displayType.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        displayDate.translatesAutoresizingMaskIntoConstraints = false
        displayDate.topAnchor.constraint(equalTo: displayType.safeAreaLayoutGuide.bottomAnchor, constant: 5).isActive = true
        displayDate.leadingAnchor.constraint(equalTo: avatarView.safeAreaLayoutGuide.trailingAnchor, constant: 5).isActive = true
        displayDate.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
}
