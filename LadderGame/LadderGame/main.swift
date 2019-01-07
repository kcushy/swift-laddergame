//
//  main.swift
//  LadderGame
//
//  Created by kcushy
//  Copyright © 2017 Codesquad Inc. All rights reserved.
//

import Foundation

// set error case
enum inputError: Error {
    case lackValue
    case wrongValue
    var description: String {
        switch self {
        case .lackValue: return "1 이상의 숫자를 입력해주세요"
        case .wrongValue: return "잘못된 값입니다."
        }
    }
}

func main() {
    while true {
        do {
            let pass = try meetMinimum()
            let ladders = makeFullLadder(pass.people, pass.ladder)
            printFull(ladders)
            return
        }
        catch inputError.lackValue {
            print(inputError.lackValue.description)
        }
        catch inputError.wrongValue {
            print(inputError.wrongValue.description)
        }
        catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
}

// test minimum value
func meetMinimum() throws -> (people: Int, ladder: Int) {
    let people = receivePeople()
    let ladder = receiveLadder()
    // confirm a Int type
    guard let participant = Int(people),
        let height = Int(ladder) else {
            throw inputError.wrongValue
    }
    guard participant >= 1 && height >= 1 else {
        throw inputError.lackValue
    }
 
    return (participant, height)
}


// create completed ladder
func makeFullLadder(_ people: Int, _ maxLadder: Int) -> [[String]] {
    var ladders = [[String]]()
    while ladders.count < maxLadder {
        let part = makeLadderPart(from: people)
        ladders.append(part)
    }
    return ladders
}

// create one line ladder
func makeLadderPart(from people: Int) -> [String] {
    var ladders = [String](repeating: " ", count: people - 1)
    guard !ladders.isEmpty else {
        return []
    }
    for index in 0..<people - 1 {
        ladders[index] = inspectExcept(ladders, index)
    }
    return ladders
}

// inspect a except case
func inspectExcept(_ ladders: [String], _ index: Int) -> String {
    guard index > 0 && ladders[index - 1] == "-" else {
        return makeHorizon()
    }
    return " "
}

// make a horizon line
func makeHorizon() -> String {
    guard arc4random_uniform(2) == 1 else {
        return " "
    }
    return "-"
}

// print full ladder
func printFull(_ ladders: [[String]]) {
    for ladder in ladders {
        printPart(of: ladder)
        print()
    }
}

// print a line of ladder
func printPart(of ladders: [String]) {
    print("|", terminator: "")
    for part in ladders {
        print(part, terminator: "|")
    }
}

main()

