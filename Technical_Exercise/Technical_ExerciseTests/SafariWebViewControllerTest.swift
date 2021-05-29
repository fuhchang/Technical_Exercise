//
//  SafariWebViewControllerTest.swift
//  Technical_ExerciseTests
//
//  Created by Fuh chang Loi on 29/5/21.
//

import Foundation
import XCTest
@testable import Technical_Exercise

class SafariWebViewControllerTest: XCTestCase {
    var webView: SafariWebViewController?
    var resultDetail: bitbucketInfo?
    override func setUpWithError() throws {
        webView = SafariWebViewController()
        if let dataResponse = Utility.shared.loadDataFromJsonFile(fileName: "responsefile2") {
            if let result = Utility.shared.jsonParser(jsonData: dataResponse) {
                resultDetail = result
            }
        }
    }
    
    override func tearDownWithError() throws {
        webView = nil
    }
    
    func testLoadWebView() {
        webView?.urlSTR = resultDetail?.values?.first?.website
        XCTAssertNoThrow(webView?.loadWebView())
    }
    
    func testOnBackButtonPress() {
        XCTAssertNoThrow(webView?.onBackButtonPress())
    }
}
