//
//  UserDetailViewControllerTests.swift
//  Technical_ExerciseTests
//
//  Created by Fuh chang Loi on 29/5/21.
//

import Foundation
import XCTest
@testable import Technical_Exercise

class UserDetailViewControllerTests: XCTestCase {
    var detailVC: UserDetailViewController?
    var userDetailView: UserDetailView?
    var resultDetail: values?
    override func setUpWithError() throws {
        detailVC = UserDetailViewController()
        detailVC?.viewDidLoad()
        userDetailView = detailVC?.userDetailView
        if let dataResponse = Utility.shared.loadDataFromJsonFile(fileName: "responsefile1") {
            if let result = Utility.shared.jsonParser(jsonData: dataResponse) {
                resultDetail = result.values?.first
                userDetailView?.userDetail = resultDetail
            }
        }
    }
    override func tearDownWithError() throws {
        detailVC = nil
        userDetailView = nil
    }
    
    func testonClickOwnerLinks() {
        detailVC?.onClickOwnerLinks(href: resultDetail?.owner?.links?.html?.href ?? "", title: "")
    }
    
    func testNumberOfSection() {
        XCTAssertEqual(userDetailView?.numberOfSections(in: userDetailView?.tableView ?? UITableView()), 3)
    }
    
    func testNumberOfRowInSection() {
        //first section first row - profile detail
        XCTAssertEqual(userDetailView?.tableView(userDetailView?.tableView ?? UITableView(), numberOfRowsInSection: 0), 1)
        //second section first row - owner link
        XCTAssertEqual(userDetailView?.tableView(userDetailView?.tableView ?? UITableView(), numberOfRowsInSection: 1), 1)
        //third section first row - project link
        XCTAssertEqual(userDetailView?.tableView(userDetailView?.tableView ?? UITableView(), numberOfRowsInSection: 2), 1)
    }
    
    func testSectionHeaderTitle() {
        XCTAssertEqual(userDetailView?.tableView(userDetailView?.tableView ?? UITableView(), titleForHeaderInSection: 0), "Profile")
        XCTAssertEqual(userDetailView?.tableView(userDetailView?.tableView ?? UITableView(), titleForHeaderInSection: 1), "Owners links")
        XCTAssertEqual(userDetailView?.tableView(userDetailView?.tableView ?? UITableView(), titleForHeaderInSection: 2), "Project")
    }
    
    func testUserProfileDetail() {
        let firstIndex = IndexPath(row: 0, section: 0)
        guard let cell = userDetailView?.tableView(userDetailView?.tableView ?? UITableView(), cellForRowAt: firstIndex) as? DetailInfoCell else {
            return
        }
        let displayName = "Display name: \(userDetailView?.userDetail?.owner?.display_name ?? "")"
        XCTAssertEqual(cell.displayName.text, displayName)
        let ownerType = "Owner Type: \(userDetailView?.userDetail?.owner?.type ?? "")"
        XCTAssertEqual(cell.displayType.text, ownerType)
        let createdOn = "Created on: \(Utility.shared.dateFormatter(strDate: userDetailView?.userDetail?.created_on ?? ""))"
        XCTAssertEqual(cell.displayDate.text, createdOn)
    }
    
    func testOwnerRepoRow() {
        let secondIndex = IndexPath(row: 0, section: 1)
        guard let cell = userDetailView?.tableView(userDetailView?.tableView ?? UITableView(), cellForRowAt: secondIndex) else {
            return
        }
        XCTAssertEqual(cell.textLabel?.text, "link to repo")
    }
    
    func testProjectLinkRow() {
        let thirdIndex = IndexPath(row: 0, section: 2)
        guard let cell = userDetailView?.tableView(userDetailView?.tableView ?? UITableView(), cellForRowAt: thirdIndex) as? ProjectInfoCell else {
            return
        }
        let displayName = "Project Title: \(userDetailView?.userDetail?.project?.name ?? "")"
        XCTAssertEqual(cell.displayName.text, displayName)
        XCTAssertEqual(cell.imageView?.image, UIImage(data: userDetailView?.userDetail?.project?.imageData ?? Data()))
    }
    
    func testTableViewDidSelect() {
        XCTAssertNoThrow(userDetailView?.tableView(userDetailView?.tableView ?? UITableView(), didSelectRowAt: IndexPath(row: 0, section: 1)))
        XCTAssertNoThrow(userDetailView?.tableView(userDetailView?.tableView ?? UITableView(), didSelectRowAt: IndexPath(row: 0, section: 2)))
        XCTAssertNoThrow(userDetailView?.tableView(userDetailView?.tableView ?? UITableView(), didSelectRowAt: IndexPath(row: 0, section: 0)))
    }
}
