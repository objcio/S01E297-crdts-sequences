import Foundation

public typealias SiteID = String

public struct RSeq<A> {
    var siteID: SiteID
    var root: [Node<A>] = []
    var clock = 0
    
    public init(siteID: SiteID) {
        self.siteID = siteID
    }
    
    public mutating func insert(_ value: A, at idx: Int) {
        clock += 1
        let node = Node(id: NodeID(time: clock, siteID: siteID), value: value)
        if idx == 0 {
            root.insert(node, at: 0)
        } else {
            let allNodes = Array(self)
            let parent = allNodes[idx-1]
            for i in root.indices {
                root[i].insert(node, after: parent.id)
            }
        }
    }
    
    public var elements: [A] {
        map { $0.value }
    }
}

extension RSeq: Sequence {
    public func makeIterator() -> AnyIterator<Node<A>> {
        var remainder = root
        
        return AnyIterator<Node> {
            guard !remainder.isEmpty else { return nil }
            let result = remainder.removeFirst()
            remainder.insert(contentsOf: result.children, at: 0)
            return result
        }
    }
}

struct NodeID: Equatable {
    var time: Int
    var siteID: SiteID
}

public struct Node<A> {
    var id: NodeID
    var value: A
    var children: [Node<A>] =  []
    
    mutating func insert(_ node: Self, after parentID: NodeID) {
        if id == parentID {
            children.insert(node, at: 0)
        } else {
            for i in children.indices {
                children[i].insert(node, after: parentID)
            }
        }
    }
}
