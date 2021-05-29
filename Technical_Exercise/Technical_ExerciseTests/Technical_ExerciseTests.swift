//
//  Technical_ExerciseTests.swift
//  Technical_ExerciseTests
//
//  Created by Fuh chang Loi on 29/5/21.
//

import XCTest
@testable import Technical_Exercise

class Technical_ExerciseTests: XCTestCase {
    var mainVC: ViewController?
    var bitbucketInfoView: BitbucketInfoView?
    override func setUpWithError() throws {
        mainVC = ViewController()
        mainVC?.bitbucketView = BitbucketInfoView()
        mainVC?.viewDidLoad()
        if let dataResponse = Utility.shared.loadDataFromJsonFile(fileName: "responsefile1") {
            if let result = Utility.shared.jsonParser(jsonData: dataResponse) {
                mainVC?.handleBitBucketInfo(result: result)
                mainVC?.bitbucketView.result = result
            }
        }
        bitbucketInfoView = mainVC?.bitbucketView
    }

    override func tearDownWithError() throws {
        mainVC = nil
        bitbucketInfoView = nil
    }
    
    func testonClickNext() {
        XCTAssert(((mainVC?.onClickNext(nextUrl: bitbucketInfoView?.result?.next ?? "")) != nil))
    }
    
    func testloadRepoDetailView() {
        if let value = bitbucketInfoView?.result?.values?.first {
            mainVC?.loadRepoDetailView(val:value)
        }
    }
    
    func testloadRepoWebView() {
        if let dataResponse = Utility.shared.loadDataFromJsonFile(fileName: "responsefile2") {
            if let result = Utility.shared.jsonParser(jsonData: dataResponse) {
                if let value = result.values?.first {
                    if let webLink = value.website {
                        mainVC?.loadRepoWebView(webViewURL: webLink)
                    }
                }
            }
        }
    }
    
    func testCaseCheckFirstCellDetail() {
        let firstIndex = IndexPath(row: 0, section: 0)
        guard let cell = bitbucketInfoView?.tableView(bitbucketInfoView?.tableView ?? UITableView(), cellForRowAt: firstIndex) as? DetailInfoCell else {
            return
        }
        XCTAssertEqual(cell.displayName.text, "Display name: opensymphony")
        XCTAssertEqual(cell.displayType.text, "Owner Type: user")
        XCTAssertEqual(cell.displayDate.text, "Created on: 06.06.11")
    }

    func testCaseCheckCellFourDetail() {
        let firstIndex = IndexPath(row: 4, section: 0)
        guard let cell = bitbucketInfoView?.tableView(bitbucketInfoView?.tableView ?? UITableView(), cellForRowAt: firstIndex) as? DetailInfoCell else {
            return
        }
        XCTAssertEqual(cell.displayName.text, "Display name: Joseph Walton")
        XCTAssertEqual(cell.displayType.text, "Owner Type: user")
        XCTAssertEqual(cell.displayDate.text, "Created on: 16.06.11")
    }
    
    func testDidSelectTableView() {
        let firstIndex = IndexPath(row: 1, section: 0)
        XCTAssertNoThrow( bitbucketInfoView?.tableView( bitbucketInfoView?.tableView ?? UITableView(), didSelectRowAt: firstIndex))
    }
    
    func testDidTapButton() {
        XCTAssertNoThrow(bitbucketInfoView?.didTapEditButton())
    }
    
    func testCaseCheckIfNextBtnIsShown() {
        if let _ = mainVC?.bitbucketView.result?.next {
            if let nextBtn = mainVC?.bitbucketView.nextBtn {
                XCTAssertFalse(nextBtn.isHidden)
            }
        }
    }
    
    func testCaseNextBtnShouldNotBeShown() {
        self.mainVC?.bitbucketView.result?.next = ""
        if let result = self.mainVC?.bitbucketView.result {
        self.mainVC?.bitbucketView.configure(result: result)
            if let nextBtn = self.mainVC?.bitbucketView.nextBtn {
                DispatchQueue.main.async {
                    XCTAssertTrue(nextBtn.isHidden)
                }
            }
        }
    }
    
    func testAddConstraint() {
        mainVC?.bitbucketView.isBtnConstraintActive = false
        mainVC?.bitbucketView.result?.next = ""
        if let result = mainVC?.bitbucketView.result {
            mainVC?.bitbucketView.configure(result: result)
        }
    }
}
