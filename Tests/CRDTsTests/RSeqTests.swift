//
//  File.swift
//  
//
//  Created by Chris Eidhof on 24.03.22.
//

import Foundation
import XCTest
import CRDTs

class RSeqTests: XCTestCase {
    func testSimple() {
        var seq = RSeq<Character>(siteID: "siteA")
        seq.insert("a", at: 0)
        seq.insert("b", at: 1)
        seq.insert("c", at: 1)
        XCTAssertEqual(seq.elements, ["a", "c", "b"])
    }
}
