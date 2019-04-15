//
//  UnitTestLadderGame.swift
//  UnitTestLadderGame
//
//  Created by cushy k on 14/04/2019.
//  Copyright © 2019 Codesquad Inc. All rights reserved.
//

import XCTest
@testable import LadderGame

class UnitTestLadderGame: XCTestCase {
    var ladderGame : LadderGame!
    var ladderPlayer : [LadderPlayer]!
    var names : [String]!
    var namesIncludedOverMaxLength: [String]!
    var inSufficientHeight: String!
    var emptyName: String!
    var inspection: Inspection!
    var unExpectedHeight: String!
    var normalHeight: String!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        names = ["hngfu", "nori", "drake", "cony"]
        namesIncludedOverMaxLength = ["hngfu", "nori", "justin"]
        ladderPlayer = names.map{ LadderPlayer(name: $0) }
        ladderGame = LadderGame(people: ladderPlayer, height: 5)
        inspection = Inspection()
        unExpectedHeight = "five"
        inSufficientHeight = "0"
        emptyName = ""
        normalHeight = "5"
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        ladderGame = nil
        ladderPlayer = nil
        names = nil
        inspection = nil
        unExpectedHeight = nil
        inSufficientHeight = nil
        emptyName = nil
        normalHeight = nil
    }

    func testNameLengthOver() {

        ladderPlayer = namesIncludedOverMaxLength.map{ LadderPlayer(name: $0) }
        XCTAssertThrowsError(try inspection.meetLength(of: ladderPlayer), "A name length is over, but nothing happend") { (error) in
            XCTAssertEqual(error as? inputError, inputError.exceedLength)}
    }


    func testHeightExcludeInt() {
        XCTAssertThrowsError(try inspection.meetMinimum(of: ladderPlayer, of: unExpectedHeight), "A ladder is not int type, but nothing happend") { (error) in
            XCTAssertEqual(error as? inputError, inputError.wrongValue)}
    }

    func testNameCountHasInsufficient() {
        let lackPlayer = LadderPlayer(name: emptyName)
        XCTAssertThrowsError(try inspection.meetMinimum(of: [lackPlayer], of: normalHeight), "No name was entered, but nothing happend") { (error) in
            XCTAssertEqual(error as? inputError, inputError.lackValue)}
    }

    func testHeightHasInsufficient() {
        XCTAssertThrowsError(try inspection.meetMinimum(of: ladderPlayer, of: inSufficientHeight), "There is not enough ladder, but nothing happend") { (error) in
            XCTAssertEqual(error as? inputError, inputError.lackValue)}
    }

    func testConsecutiveLineHasInsufficient() {
        let ladders = ladderGame.fullLadder()
        print(ladders)
        var isConsecutive = false
        for laddersPart in ladders {
            isConsecutive = inspection.verifyChain(from: laddersPart)
        }
        XCTAssertEqual(isConsecutive, false)
    }
}
