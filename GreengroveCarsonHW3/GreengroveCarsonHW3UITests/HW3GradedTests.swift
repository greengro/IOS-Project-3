//
//  HW3GradedTests.swift
//  ChooseUITests
//
//  Created by Harrison Weinerman on 9/10/20.
//

import XCTest

class HW3GradedTestCases: XCTestCase {
    
    private let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        XCUIDevice.shared.orientation = .portrait
        continueAfterFailure = false
        XCUIApplication().launch()
        
        let nameTextField = app.textFields[HW3AccessibilityIdentifiers.nameTextField]
        // Added for students who are making keyboard come up on runtime
        if app.keyboards.count != 0 {
            nameTextField.typeText("\n")
        }
    }

    func testBasicUIElements() {
        let titleLabel = app.staticTexts[HW3AccessibilityIdentifiers.titleLabel]
        let outputLabel = app.staticTexts[HW3AccessibilityIdentifiers.outputLabel]
        let nameTextField = app.textFields[HW3AccessibilityIdentifiers.nameTextField]
        let optionButton1 = app.buttons[HW3AccessibilityIdentifiers.optionButton1]
        let optionButton2 = app.buttons[HW3AccessibilityIdentifiers.optionButton2]
        let resetButton = app.buttons[HW3AccessibilityIdentifiers.resetButton]
        
        XCTAssert(titleLabel.exists)
        XCTAssert(outputLabel.exists)
        XCTAssert(nameTextField.exists)
        XCTAssert(optionButton1.exists)
        XCTAssert(optionButton2.exists)
        XCTAssert(resetButton.exists)
        XCTAssertNotEqual(nameTextField.placeholderValue, "")
    }
    
    /// Tests the Done button on the keyboard works
    func testDoneButton() {
        let nameTextField = app.textFields[HW3AccessibilityIdentifiers.nameTextField]
        XCTAssertEqual(app.keyboards.count, 0)
        nameTextField.tap()
        XCTAssertEqual(app.keyboards.count, 1)
        app.keyboards.buttons["Done"].tap()
        XCTAssertEqual(app.keyboards.count, 0)
    }
    
    /// Tests the background button works
    func testBackgroundButton() {
        let nameTextField = app.textFields[HW3AccessibilityIdentifiers.nameTextField]
        let titleLabel = app.staticTexts[HW3AccessibilityIdentifiers.titleLabel]
        
        XCTAssertEqual(app.keyboards.count, 0)
        nameTextField.tap()
        XCTAssertEqual(app.keyboards.count, 1)
        titleLabel.tap()
        XCTAssertEqual(app.keyboards.count, 0)
    }
    
    /// Tests basic functionality with no text input
    func testOptionsNoUserInput() {
        let outputLabel = app.staticTexts[HW3AccessibilityIdentifiers.outputLabel]
        let optionButton1 = app.buttons[HW3AccessibilityIdentifiers.optionButton1]
        let optionButton2 = app.buttons[HW3AccessibilityIdentifiers.optionButton2]
        let nameTextField = app.textFields[HW3AccessibilityIdentifiers.nameTextField]
        
        XCTAssertEqual(nameTextField.label, "")
        let initialMessage = outputLabel.label
        XCTAssertEqual(app.keyboards.count, 0)
        
        optionButton1.tap()
        let option1 = outputLabel.label
        XCTAssertNotEqual(option1, initialMessage)
        optionButton2.tap()
        let option2 = outputLabel.label
        XCTAssertNotEqual(option2, initialMessage)
        XCTAssertNotEqual(option1, option2)
        XCTAssertEqual(app.keyboards.count, 0)
    }
    
    /// Test basic button presses with text input
    func testOptionsUserInput() {
        let outputLabel = app.staticTexts[HW3AccessibilityIdentifiers.outputLabel]
        let nameTextField = app.textFields[HW3AccessibilityIdentifiers.nameTextField]
        let optionButton1 = app.buttons[HW3AccessibilityIdentifiers.optionButton1]
        let optionButton2 = app.buttons[HW3AccessibilityIdentifiers.optionButton2]
      
        XCTAssertEqual(nameTextField.label, "")
        let initialMessage = outputLabel.label
        XCTAssertEqual(app.keyboards.count, 0)
        
        let name = "Tommy Trojan"
        nameTextField.tap()
        XCTAssertEqual(app.keyboards.count, 1)
        nameTextField.typeText(name)
        app.keyboards.buttons["Done"].tap()
        XCTAssertEqual(app.keyboards.count, 0)

        optionButton1.tap()
        let option1 = outputLabel.label
        XCTAssertNotEqual(option1, initialMessage)
        optionButton2.tap()
        let option2 = outputLabel.label
        XCTAssertNotEqual(option2, initialMessage)
        XCTAssertNotEqual(option1, option2)
        XCTAssert(option1.contains(name))
        XCTAssert(option2.contains(name))
    }
    
    /// Tests behavior is different with and without text input
    func testButtonOutputIsDifferentAfterInput() {
        let outputLabel = app.staticTexts[HW3AccessibilityIdentifiers.outputLabel]
        let nameTextField = app.textFields[HW3AccessibilityIdentifiers.nameTextField]
        let optionButton1 = app.buttons[HW3AccessibilityIdentifiers.optionButton1]
        let optionButton2 = app.buttons[HW3AccessibilityIdentifiers.optionButton2]
        
        XCTAssertEqual(nameTextField.label, "")
        XCTAssertEqual(app.keyboards.count, 0)
        
        optionButton1.tap()
        let option1Message = outputLabel.label
        optionButton2.tap()
        let option2Message = outputLabel.label
        
        let name = "Tommy Trojan"
        nameTextField.tap()
        XCTAssertEqual(app.keyboards.count, 1)
        nameTextField.typeText(name)
        app.keyboards.buttons["Done"].tap()
        XCTAssertEqual(app.keyboards.count, 0)
        
        optionButton1.tap()
        let option1MessageUpdated = outputLabel.label
        optionButton2.tap()
        let option2MessageUpdated = outputLabel.label

        XCTAssertNotEqual(option2Message, option2MessageUpdated)
        XCTAssertNotEqual(option1Message, option1MessageUpdated)
    }
    
    /// Tests reset button
    func testResetButton() {
        let titleLabel = app.staticTexts[HW3AccessibilityIdentifiers.titleLabel]
        let outputLabel = app.staticTexts[HW3AccessibilityIdentifiers.outputLabel]
        let nameTextField = app.textFields[HW3AccessibilityIdentifiers.nameTextField]
        let resetButton = app.buttons[HW3AccessibilityIdentifiers.resetButton]
        let optionButton1 = app.buttons[HW3AccessibilityIdentifiers.optionButton1]
        
        let initialMessage = outputLabel.label
        let name = "Tommy Trojan"
        
        nameTextField.tap()
        XCTAssertEqual(app.keyboards.count, 1)
        nameTextField.typeText(name)
        
        app.keyboards.buttons["Done"].tap()
        XCTAssertEqual(app.keyboards.count, 0)

        optionButton1.tap()
        resetButton.tap()
        
        XCTAssertEqual(nameTextField.label, "")
        XCTAssertEqual(outputLabel.label, initialMessage)
        XCTAssertNotEqual(titleLabel.label, "")
    }
}
