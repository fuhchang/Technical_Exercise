//
//  UserDetailViewController.swift
//  Technical_Exercise
//
//  Created by Fuh chang Loi on 29/5/21.
//

import Foundation
import UIKit

class UserDetailViewController: UIViewController {
    var userDetail: values?
    lazy var userDetailView: UserDetailView = {
        let userDetailView = UserDetailView()
        return userDetailView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail View"
        userDetailView.userDetail = userDetail
        userDetailView.delegate = self
        self.view = userDetailView
    }
}

extension UserDetailViewController: UserDetailViewProtocol {
    func onClickOwnerLinks(href: String, title: String) {
        let webViewVC = SafariWebViewController()
        webViewVC.urlSTR = href
        webViewVC.titleText = title
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(webViewVC, animated: true)
        }
    }
}
