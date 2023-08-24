//
//  hui_management_flutterUITestsLaunchTests.swift
//  hui_management_flutterUITests
//
//  Created by Linh Ha on 23/08/2023.
//


import XCTest

final class hui_management_flutterUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()



//        snapshot("PaymentScreen")
//        snapshot("ReportScreen")
//        snapshot("FundDetailScreen")
//        snapshot("FundMemberScreen")
//        snapshot("FundSessionScreen")
//        snapshot("FundSessionReportEditScreen")
//        snapshot("TakenSessionExportScreen")
        
        snapshot("LoginScreen")
        app.buttons["Đăng nhập"].tap()
        snapshot("InfoScreen")
        app.staticTexts["Thành viên\nTab 2 of 5"]/*@START_MENU_TOKEN@*/.press(forDuration: 1.3);/*[[".tap()",".press(forDuration: 1.3);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        snapshot("memberScreen")
        app.staticTexts["Dây hụi\nTab 3 of 5"]/*@START_MENU_TOKEN@*/.press(forDuration: 1.0);/*[[".tap()",".press(forDuration: 1.0);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        snapshot("fundsScreen")
        app.staticTexts["Thanh toán\nTab 4 of 5"]/*@START_MENU_TOKEN@*/.press(forDuration: 1.1);/*[[".tap()",".press(forDuration: 1.1);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        snapshot("paymentsScreen")
        app.staticTexts["Báo cáo\nTab 5 of 5"]/*@START_MENU_TOKEN@*/.press(forDuration: 1.3);/*[[".tap()",".press(forDuration: 1.3);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        snapshot("reportScreen")
        
        


        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
