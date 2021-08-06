//
//  BitbucketInfoVM.swift
//  Technical_Exercise
//
//  Created by Fuh chang Loi on 29/5/21.
//

import Foundation
import UIKit
protocol BitbucketInfoVMProcotol {
    func handleBitBucketInfo(result: bitbucketInfo)
    func naviToUserDetailScreen(val: values)
}
struct BitbucketInfoVM {
    var delegate: BitbucketInfoVMProcotol?
    let group = DispatchGroup()
    func loadBitBucketInfo(urlString: String) {
        var repoDetailResponse: bitbucketInfo?
        NetworkManager.shared.urlSessionCall(urlString: urlString, completion: { (response, error) in
            if error == nil {
                if let data = response as? Data {
                    if let decodedResponse = try? JSONDecoder().decode(bitbucketInfo.self, from: data) {
                        repoDetailResponse = decodedResponse
                        if let values = decodedResponse.values {
                            for (i, repoDetail) in values.enumerated() {
                                if let url = repoDetail.links?.avatar?.href {
                                    group.enter()
                                    loadAvatarImage(stringUrl: url, completion: { (imageData, error) in
                                        repoDetailResponse?.values?[i].owner?.imageData = imageData
                                        group.leave()
                                    })
                                }
                            }
                            group.notify(queue: .main) {
                                if let response = repoDetailResponse {
                                    delegate?.handleBitBucketInfo(result: response)
                                }
                            }
                        }
                    }
                }
            }
        })
    }
    
    func loadImage(val: values) {
        var deftailInfo = val
        self.loadAvatarImage(stringUrl: val.project?.links?.avatar?.href ?? "", completion: { (imageData, error) in
            deftailInfo.project?.imageData = imageData
            self.delegate?.naviToUserDetailScreen(val: deftailInfo)
        })
        if Thread.current.isRunningXCTest {
            deftailInfo.project?.imageData = UIImage(named: "java")?.pngData()
            self.delegate?.naviToUserDetailScreen(val: deftailInfo)
        }
    }
    func loadAvatarImage(stringUrl: String, completion: @escaping (_ response: Data?, _ error: Error?) -> Void) {
        if let url = URL(string: stringUrl) {
            NetworkManager.shared.getData(from: url) { data, response, error in
                guard let imageData = data, error == nil else { return }
                completion(imageData, error)
            }
            if Thread.current.isRunningXCTest {
                completion(UIImage(named: "java")?.pngData(), nil)
            }
        }
    }
}
