//
//  ViewController.swift
//  Technical_Exercise
//
//  Created by Fuh chang Loi on 29/5/21.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    var bitbucketRepoDetail: bitbucketInfo?
    lazy var bitbucketView: BitbucketInfoView = {
        let bitbucketDetailView = BitbucketInfoView()
        bitbucketDetailView.delegate = self
       return bitbucketDetailView
    }()
    lazy var bitBucketVM: BitbucketInfoVM = {
        return BitbucketInfoVM()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Owner List"
        bitBucketVM.delegate = self
        DispatchQueue.main.async {
            self.showSpinner(onView: self.view)
            self.bitBucketVM.loadBitBucketInfo(urlString: "https://api.bitbucket.org/2.0/repositories")
        }
        self.view = bitbucketView
    }
}

extension ViewController: BitbucketInfoVMProcotol {
    func handleBitBucketInfo(result: bitbucketInfo) {
        DispatchQueue.main.async {
            self.removeSpinner()
            self.bitbucketRepoDetail = result
            self.bitbucketView.configure(result: result)
            self.bitbucketView.tableView.reloadData()
        }
    }
    
    func naviToUserDetailScreen(val: values) {
        DispatchQueue.main.async {
            self.removeSpinner()
            let userDetailVC = UserDetailViewController()
            userDetailVC.userDetail = val
            self.navigationController?.pushViewController(userDetailVC, animated: true)
        }
    }
}


extension ViewController: BitbucketInfoViewProtocols {
    func onClickNext(nextUrl: String) {
        DispatchQueue.main.async {
            self.showSpinner(onView: self.view)
            self.bitBucketVM.loadBitBucketInfo(urlString: nextUrl)
        }
    }
    
    func loadRepoWebView(webViewURL: String) {
        let webViewVC = SafariWebViewController()
        webViewVC.urlSTR = webViewURL
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(webViewVC, animated: true)
        }
    }
    
    func loadRepoDetailView(val: values) {
        self.showSpinner(onView: self.view)
        self.bitBucketVM.loadImage(val: val)
    }
}
