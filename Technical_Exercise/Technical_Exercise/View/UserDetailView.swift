//
//  UserDetailView.swift
//  Technical_Exercise
//
//  Created by Fuh chang Loi on 29/5/21.
//

import Foundation
import UIKit

protocol UserDetailViewProtocol {
    func onClickOwnerLinks(href: String, title: String)
}
class UserDetailView: UIView {
    var delegate: UserDetailViewProtocol?
    var userDetail: values?
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(DetailInfoCell.self, forCellReuseIdentifier: "DetailInfoCell")
        tableView.register(ProjectInfoCell.self, forCellReuseIdentifier: "ProjectInfoCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = tableView.backgroundColor
        DispatchQueue.main.async {
            self.layout()
            self.addConstraints()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        self.addSubview(tableView)
    }
    
    private func addConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension UserDetailView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Profile"
        } else if section == 1 {
            return "Owners links"
        } else if section == 2 {
            return "Project"
        }
        return ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var sectionSize = 1
        
        if let htmlLink = userDetail?.owner?.links?.html?.href, htmlLink != "" {
            sectionSize += 1
        }
        if let projectDetail = userDetail?.project, ((projectDetail.links?.html) != nil) {
            sectionSize += 1
        }
        return sectionSize
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            if let  htmlLink = userDetail?.owner?.links?.html?.href, htmlLink != "" {
                return 1
            }
        } else if section == 2 {
            if let projectDetail = userDetail?.project, ((projectDetail.links?.html) != nil) {
                return 1
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailInfoCell") as? DetailInfoCell else {
                return UITableViewCell()
            }
            if let value = userDetail {
                if let owner = value.owner {
                    cell.configure(name: owner.display_name ?? "",
                                   type: owner.type ?? "",
                                   date: value.created_on ?? "",
                                   imageData: owner.imageData)
                }
            }
            return cell
        } else if indexPath.section == 1 {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell.textLabel?.text = "link to repo"
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectInfoCell") as? ProjectInfoCell else {
                return UITableViewCell()
            }
            if let detail = userDetail?.project {
                print(detail)
                cell.configure(name: detail.name ?? "",
                               imageData: detail.imageData)
            }
            return cell
        }
        return UITableViewCell()
    }
}

extension UserDetailView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            delegate?.onClickOwnerLinks(href: userDetail?.owner?.links?.html?.href ?? "", title: "OWNER")
        } else if indexPath.section == 2 {
            delegate?.onClickOwnerLinks(href: userDetail?.project?.links?.html?.href ?? "", title: "PROJECT")
        }
    }
}
