//
//  BitbucketInfoView.swift
//  Technical_Exercise
//
//  Created by Fuh chang Loi on 29/5/21.
//

import Foundation
import UIKit
protocol BitbucketInfoViewProtocols {
    func onClickNext(nextUrl: String)
    func loadRepoWebView(webViewURL: String)
    func loadRepoDetailView(val: values)
}
class BitbucketInfoView: UIView {
    var result: bitbucketInfo?
    var delegate: BitbucketInfoViewProtocols?
    var isBtnConstraintActive: Bool = false
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DetailInfoCell.self, forCellReuseIdentifier: "DetailInfoCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    lazy var nextBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("NEXT", for: .normal)
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        return btn
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
        self.addSubview(nextBtn)
    }
    
    func configure(result: bitbucketInfo) {
        self.result = result
        DispatchQueue.main.async {
            if (result.next != "" && result.next != nil) != self.isBtnConstraintActive {
                self.addConstraints()
            }
        }
    }
    
    @objc func didTapEditButton() {
        delegate?.onClickNext(nextUrl: result?.next ?? "")
    }
    
    private func addConstraints() {
        tableView.removeAllConstraints()
        nextBtn.removeAllConstraints()
        if result?.next != "" && result?.next != nil {
            isBtnConstraintActive = true
        }
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        if isBtnConstraintActive {
            tableView.bottomAnchor.constraint(equalTo: nextBtn.safeAreaLayoutGuide.topAnchor, constant: -20).isActive = true
            nextBtn.isHidden = false
            nextBtn.translatesAutoresizingMaskIntoConstraints = false
            nextBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            nextBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
            nextBtn.widthAnchor.constraint(equalToConstant: 300).isActive = true
            nextBtn.topAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor).isActive = true
            nextBtn.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
        } else {
            nextBtn.isHidden = true
            tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}

extension BitbucketInfoView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.values?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailInfoCell") as? DetailInfoCell else {
            return UITableViewCell()
        }
        if let value = self.result?.values?[indexPath.row] {
            if let owner = value.owner {
                cell.configure(name: owner.display_name ?? "",
                               type: owner.type ?? "",
                               date: value.created_on ?? "",
                               imageData: owner.imageData)
            }
        }
        return cell
    }
}

extension BitbucketInfoView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let value = result?.values?[indexPath.row] {
            if let htmlLink = value.website, htmlLink != "" {
                delegate?.loadRepoWebView(webViewURL: htmlLink)
            } else {
                delegate?.loadRepoDetailView(val: value)
            }
        }
    }
}
