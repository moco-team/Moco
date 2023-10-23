//
//  MocoTests.swift
//  MocoTests
//
//  Created by Aaron Christopher Tanhar on 11/10/23.
//

@testable import Moco
import XCTest

final class MocoTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSpeakPromptViewModel() {
        let speakPromptViewModel = SpeakPromptViewModel()

        XCTAssertFalse(speakPromptViewModel.isRecording)
        XCTAssertFalse(speakPromptViewModel.showHint)
        XCTAssertFalse(speakPromptViewModel.showPopUp)
        speakPromptViewModel.correctAnswer = "budi itu babi"
        XCTAssertTrue(speakPromptViewModel.isCorrectAnswer("budi itu babi"))
        XCTAssertTrue(speakPromptViewModel.isCorrectAnswer("babi itu budi", possibleTranscripts: ["budi it u b a bi", "babski"]))
        XCTAssertFalse(speakPromptViewModel.isCorrectAnswer("kiu kiu"))
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        XCTAssertEqual(69 * 1, 69)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
