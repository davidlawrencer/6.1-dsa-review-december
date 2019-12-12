import UIKit

var str = "Hello, playground"

//Linked List

//Made up of Nodes

//How is a Node constructed? What is it?
//It's a thing that has a value and a "next"

//What is "next"?
//It's another node -> we assign as a property of one node the "next" node that it refers to
//var next: Node<T>?

//Why is next optional
//At some point, it will be nil


//Has to be a class because we want to specifically refer to another place in memory when we give a value to "next"
//Reminder: structs always copy values
//T and Any are different
//T is a placeholder for the type that you want to use
//Once it's declared/indicated, you cannot change that type
//Any actually stores "any" value you want.
//Ex: let array:[Any] = [1,4,"string"]
class Node<T> {
    //value
    var value: T
    //next
    var next: Node?
    
    init(value: T) {
        self.value = value
        next = nil
    }
}

let node1 = Node(value: 1)
let node2 = Node(value: 2)
let node3 = Node(value: 3)
let node4 = Node(value: 4)
node1.next = node2
node2.next =  node3
//could do this as node1.next?.next = node3
node2.next?.next?.next?.next?.next = node4

print(node1.next)

//(1)//first node -> (2)//second node -> (5)//third node
//looking for a specific node has a runtime O(n) where n is the number of nodes that are connected

//if we keep track of the first and last nodes.... using some kind of data structure, we could look at nodes starting from the end AND the beginning

//Linked List gives structure to our nodes
//[(1)//first node -> (2)//second node -> (5)//third node]

//one object that references the first node, which allows us to reference the next one, the one after that, so on.


//gives us the ability to search and manipulate a series of nodes
//In an array, if we want to insert/delete in the middle, we have to shift everything in the array
//In a linked list, we just change some pointers (change next for a few things, rest of the chain remains the same)

class LinkedList<T: Equatable> {
    //linked lists start with empty chain of nodes
    private var head: Node<T>?
//  private var tail: Node<T>? <- this would be the last node (the one that has a nil value for next)
//  private var count: Int <- increment/decrement each time a node is added/removed
    
    //we can set up the rest of our linked list just using functions
    
    //add a value
    public func appendValue(value: T){
        let node = Node<T>(value: value)
        if head == nil {
            head = node
        } else {
            //this wouldn't add to the last node
            //head?.next = node
            let lastNode = findLastNode()
            lastNode?.next = node
        }
    }
    // ^ sometimes people add nodes, but if we know the type of the LinkedList, we shouldn't need to know that it contains Nodes.
    
    
    //delete a value
    func deleteAllValues(value: T) {
        //start at head
        //assign currentNode to head
        //if head is nil, return
        //edge case: see if head matches that value
            //if so, check that head's next isn't nil
                //if it isn't, assign head to head.next
                //if it is, head = nil and return
        //while currentNode != nil
        //check that currentNode.next isn't nil and assign a pointer
            //if it's nil, return
            //if not, assign it a pointer
            //while pointer.value == value
            //currentNode.next = currentNode.next.next
            //pointer.next = nil
            //pointer = currentNode.next
        //after all that, reassign currentNode and continue
        
        //might not do anything if the value doesn't exist
        //delete it once? delete it many times?
        
    }
    
    //deleteNodeAt(location: Int)? -> should we be deleting a value or a specific node at a specific location?
    //if i said delete the fifth node, i'll start at head and keep count.
    //counter = 1
    //currentNode = head
    //while currentNode.next != nil
        //if counter == location
            //swap the next for the node we're at to "delete" the node that we looked for
        //else, counter += 1
    
    
    
    //find the value at node n
    //counter
    //currentNode = head
    //while currentNOde.next != nil
        // if counter == n
            //return currentNode.value
        //else
        //counter += 1
    
    //find last value
    func findLastNode() -> Node<T>? {
        var currentNode = head
        while currentNode?.next != nil {
            currentNode = currentNode?.next
        }
        return currentNode
    }
    
    //more advanced, less common functions:
    //insert at (place) -> add before the "place" node
    
}

let linkedList = LinkedList<Int>()
//that was... fun???


//Stacks!!!

//adds and removes stuff that is "on top of each other"
//LIFO - last in, first out (the thing we just added will be what we remove)
//At a given time, we're ONLY interacting with one element in the stack (the "top" of the stack)

class Stack<T: Equatable> {
    private var elements = [T]()
    //LL Comments are for linked list implementation
    
    //add to the top
    func push(value:T) {
        elements.append(value)
        //LL: add a node with this value before head
    }
    
    //remove from the top
    func pop() -> T? {
        //in other languages that don't have optionals, you might need this:
        //        if elements.isEmpty {
        //            return nil
        //        }
        //this returns the element, but doesn't remove it
//        return elements.last
        return elements.popLast()
        //LL: remove the node at head (oldHead), reassign head in the LL, and return the value at oldHead
    }
    
    //look at the top
    func peek() -> T? {
        return elements.last
        //LL: return head
    }
    
    //see if i have anything in my stack
    func isEmpty() -> Bool {
        return elements.isEmpty
        //LL: return whether or not head != nil
    }
}

//


//Queues!!!

// FIFO - first in, first out
// ex: food in your digestive track
// ex: playlist

// only need to look at two elements
// 1. what's at the front of line
// 2. what's at the back of the line

class Queue<T: Equatable> {
    //implementing with an array!
    //could we do this with two stacks?
    //yes! we could have one stack that handles enqueuing, and a second that handles dequeuing.
    //when we enqueue something, we would have recreate the dequeue stack
    //it's like a slinky
    
    private var array = [T]()
    
    var count: Int {
        //the number of things in the queue
        return array.count
    }
    
    var front: T? {
        //the thing that is first in the queue (this is the item that will be removed next time i dequeue something)
        return array.first
    }
    
    func enqueue(value: T) {
        array.append(value)
        //adds value to end of array/structure
    }

    func dequeue() -> T? {
        //removes values at the beginning of the array/structure
        array.removeFirst()
    }
    
    func isEmpty() -> Bool {
        array.isEmpty
    }
}

let queue = Queue<Int>()
queue.enqueue(value: 3)
queue.enqueue(value: 3)
queue.enqueue(value: 3)
queue.enqueue(value: 3)
queue.enqueue(value: 3)

for _ in 1...5 {
    queue.dequeue()
}

queue.count == 0

//Dictionaries!

//Does space matter? These days, not as much :(
//Reason we use it: by hashing, we are able to make read/write O(1)
//Reason we use it #2: we can associate keys and values in order to simulate a relationship between information without using objects

var dict: [String:Int] = [String:Int]()
//review -> what happens when:
dict["david"] //get nil

//what happens when:
dict["david"] = 54 //stores that value in association with the key "david"

//what happens when:
dict["david"] //get back Optional(54)

//in swift:
dict.keys // each of these MUST be unique
dict.values // these AREN'T necessarily unique

//mutable v. immutable?
//mutable is some data that you can change
//immutable you can't
//think of this like the difference between var and let

//find duplicates!!!
//ex: delete all the duplicates in a linked list?
//you can assign a key in the dictionary the value of that node, and increment it. if the value for that key in the dictionary >1, it's a duplicate
//frequency map/dict/table (it's just a dictionary [T:Int])
//runtime will probably be O(n), where n is the list/collection/group of info you're looking for duplicates in

//example input for findDuplicates -> [1,2,3,4,5,6,7,8,9] -> n is 9



//Trees


//What is it?
//made up of nodes
//it has a root node (similar to a head in a LinkedList)
//A thing with branches
//nodes have "parents" and "children" (some relationship between info)
//sometimes people will call certain nodes "siblings"
//a "leaf" is a node at the bottom-most level (has no left or right)

//tree node has a value
//tree node has TWO references/pointers (for our purposes)
//"left" and "right"
//we can navigate through the tree by starting at the root and then going left or right from there. Ex: root?.left?.right?.left?.right?.left would bring us to a descendant TreeNode 5 levels away from the root

class TreeNode<T: Comparable> {
    let value: T
    var left: TreeNode?
    var right: TreeNode?
    
    init(value: T) {
        self.value = value
    }
    
    static func < (lhs: TreeNode<T>, rhs: TreeNode<T>) -> Bool {
        return lhs.value < rhs.value
    }
}

class Tree<T: Comparable> {
    private var root: TreeNode<T>?
//maybe i want a count?
    //but all i need in order to look for things, compare things, add things, or delete things is a reference to the root
    
    //MARK: -- TODO: implement adding to a tree, deleting from a tree, finding a specific value in a tree. DON'T worry about ordering these things from small to large, or anything like that.
    
    //@y001@, it's only three functions. They're probably pretty similar to stuff within a Linked List's functionality
    
    //? what happens when we delete something -> it removes everything that is a branch of that TreeNode
    //when we add something, where should it go -> try to balance out the tree.
    
    //? breadth v. depth
    //depth will recursively start down the left side (think of this as a single "lineage" from root to leaf)
    //breadth will start at the layer/level (think of this as a "generation" of nodes)
    
}

//!@^ wants more quizzes
