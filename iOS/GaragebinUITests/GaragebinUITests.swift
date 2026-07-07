import XCTest

final class GaragebinUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testAddEntryFlow() {
        app.buttons["addButton"].tap()
        let titleField = app.textFields["titleField"]
        XCTAssertTrue(titleField.waitForExistence(timeout: 2))
        titleField.tap()
        titleField.typeText("New Bin")
        app.buttons["saveButton"].tap()
        XCTAssertTrue(app.staticTexts["New Bin"].waitForExistence(timeout: 2))
    }

    func testKeyboardDismissesOnTapOutside() {
        app.buttons["addButton"].tap()
        let titleField = app.textFields["titleField"]
        XCTAssertTrue(titleField.waitForExistence(timeout: 2))
        titleField.tap()
        titleField.typeText("Tap Test")
        XCTAssertTrue(app.keyboards.element.exists)
        app.staticTexts["Add Bin"].tap()
        XCTAssertFalse(app.keyboards.element.waitForExistence(timeout: 1))
    }

    func testFreeLimitTriggersPaywall() {
        for i in 0..<(Int(9)) {
            app.buttons["addButton"].tap()
            let titleField = app.textFields["titleField"]
            if titleField.waitForExistence(timeout: 2) {
                titleField.tap()
                titleField.typeText("Entry \(i)")
                app.buttons["saveButton"].tap()
            } else {
                break
            }
        }
        app.buttons["addButton"].tap()
        XCTAssertTrue(app.buttons["unlockProButton"].waitForExistence(timeout: 2))
    }

    func testCancelAddDismissesSheet() {
        app.buttons["addButton"].tap()
        XCTAssertTrue(app.buttons["cancelButton"].waitForExistence(timeout: 2))
        app.buttons["cancelButton"].tap()
        XCTAssertFalse(app.buttons["cancelButton"].exists)
    }

    func testSettingsSheetOpens() {
        app.buttons["settingsButton"].tap()
        XCTAssertTrue(app.buttons["settingsDoneButton"].waitForExistence(timeout: 2))
        app.buttons["settingsDoneButton"].tap()
    }
}
