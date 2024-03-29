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

//print(node1.next)

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

class QueueClass<T: Equatable> {
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

//let queue = Queue<Int>()
//queue.enqueue(value: 3)
//queue.enqueue(value: 3)
//queue.enqueue(value: 3)
//queue.enqueue(value: 3)
//queue.enqueue(value: 3)
//
//for _ in 1...5 {
//    queue.dequeue()
//}

//queue.count == 0

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


class TreeClass<T: Comparable> {
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

class TreeNode<T:Comparable> {
    var value: T
    var left: TreeNode<T>?
    var right: TreeNode<T>?
    init(value: T) {
        self.value = value
    }
}

class LLNode<Key> {
    let val: Key
    var next: LLNode?
    init(val: Key) {
        self.val = val
    }
}

struct Queue<T> {
    private var head: LLNode<T>?
    private var tail: LLNode<T>?
    var isEmpty: Bool {
        return head == nil
    }
    mutating func enQueue(_ newElement: T) {
        let newNode = LLNode(val: newElement)
        guard let tail = tail else {
            self.head = newNode
            self.tail = newNode
            return
        }
        tail.next = newNode
        self.tail = newNode
    }
    mutating func deQueue() -> T? {
        guard let oldHead = head else {
            return nil
        }
        self.head = oldHead.next
        if oldHead.next == nil {
            self.tail = nil
        }
        return oldHead.val
    }
    func peek() -> T? {
        return self.head?.val
    }
}

//Breadth-First Search 🥖🍞
// We start at the root (first level)
// at each level, we look from left to right for a value before continuing on to the next level

func breadthFirstSearch<T>(root: TreeNode<T>) {
    var myQueue = Queue<TreeNode<T>>()
    
    myQueue.enQueue(root)
    
    while !myQueue.isEmpty {
        let currentNode = myQueue.deQueue()!
        
//        if currentNode.value == toFind {
            print(currentNode.value)
//        }
        
        if let leftNode = currentNode.left {
            myQueue.enQueue(leftNode)
        }
        
        if let rightChild = currentNode.right {
            myQueue.enQueue(rightChild)
        }
    }
}

//this is our root
let treeNode1 = TreeNode(value: 1)
//these will be the children of our root
let treeNode2 = TreeNode(value: 2)
let treeNode3 = TreeNode(value: 3)

treeNode1.left = treeNode2
treeNode1.right = treeNode3
//our tree currently:
//          (1)
//         L   R
//       (2)   (3)
//

let treeNode5 = TreeNode(value: 5)
let treeNode6 = TreeNode(value: 6)
treeNode2.left = treeNode5
treeNode2.right = treeNode6
//our tree currently:
//          (1)
//         L   R
//       (2)   (3)
//      L   R
//     (5)  (6)

let treeNode7 = TreeNode(value: 7)
let treeNode9 = TreeNode(value: 9)
treeNode3.left = treeNode7
treeNode3.right = treeNode9
//our tree currently:
//           (1)
//         L     R
//       (2)      (3)
//      L   R     L   R
//     (5)  (6)  (7)   (9)


//breadthFirstSearch(root: treeNode1)
// prints from left to right at each level, and then at the next level
// tree above will print 1, 2, 3, 5, 6, 7, 9


//Depth-First Search ⚓️⚓️ -> We will review in the future


// How do we do stuff -> Algorithms
// list of instructions that helps us do stuff
// What does that mean on a computer?
// Function -> could be an algorithm or part of one
// Programs -> Apps
// "Software" -> using algorithms to solve problems

// What are the two  major limitations of algorithms? (physics problems)
// time complexity and space complexity
// our programs are going to execute in real time (4th dimension!)
// our programs need to store things (1st-3rd dimensions)

// big-O notation - time and space, but generally when we evaluate algorithms, we're looking at time.

// Space complexity - how much information needs to be stored
//O(1) space (things saved)
func constantSpaceFunction(something: Int) {
    let anotherThing = something
    for _ in 1...1_000_000 {
//        print(anotherThing)
    }
}

//O(n) space (things saved)
func linearSpaceFunction(somethings: [Int]) {
    for currentThing in somethings {
        var anotherThing = currentThing
        print(anotherThing)
    }
}

//O(n^2) space (things saved)
func quadraticSpaceFunction(somethings: [Int]) {
    for _ in somethings {
        for currentThing in somethings {

        var anotherThing = currentThing
        print(anotherThing)
        }
        
    }
}

//look out for loops! look out for while loops!

//What does complexity mean for us?
// It's measuring the best case scenario, the worst case scenario, and the "average" case scenario

//Time complexity:

//O(1) time function (if you care about math, this is n^0)

func printTheThing(something:[[Int]]) {
    print(something)
}

//another O(1) time function

func printAHundredThings(something:[[Int]]) {
    for i in 1...100 {
        print(something)
    }
}

// this isn't O(1), it's O(n)
func printNTimes(something: [[Int]]) {
    for i in something {
        //this prints arrays n times
        print(i)
    }
}

// another O(n) function, where n is number ofTimes
func printTheSpecifiedNumberOfTimes(phrase toPrint:String, number ofTimes:Int) {
    for i in 1...ofTimes {
        print(toPrint)
    }
}

// compound complexity -> O(a * b) -> O(ab) -> we end up here O(n^2)
// O(m * n)
func printSomeCombinedNumberOfTimes(phrase toPrint: String, aNumber: Int, bNumber: Int) {
    for _ in 1...aNumber {
        for _ in 1...bNumber {
            print(toPrint)
        }
    }
}

//O(n^2)
func printAQuadraticNumberOfTimes(phrase toPrint: String, aNumber: Int) {
    for _ in 1...aNumber {
        for _ in 1...aNumber {
            print(toPrint)
        }
    }
}

//What's the complexity? O(a*b)
func printSomeTimes(something: [[Int]]) {
    for a in something {
        for b in a {
            print(b)
        }
        //this prints arrays n times
    }
}

//O(a+b) -> O(n)
func printSomeAddedNumberOfTimes(phrase toPrint: String, aNumber: Int, bNumber: Int) {
    for _ in 1...aNumber {
        print(toPrint)
    }
    
    for _ in 1...bNumber {
        print(toPrint)
    }
}


// Iterating
// repeatedly looking through something
// ex: looping
// helps you automate a process
// lets you perform the same operation multiple/n-number of times
// all done in one function/program/algorithm "usage"

//Recursion -> it's like iteration, but on a different level. whoa man
//calling a function inside of a function!

//wut?
//we apply the same pattern as iterating, but in a function call to this same function being defined, and only need to provide some simple information in the "base case(s)." These base cases tend to build in the edge cases that would've been problems had we solved iteratively

func sumFromOneToNIteratively(n: Int) -> Int {
    guard n > 1 else {return 1}
    var sum = 0
    for i in 1...n {
        sum += i
    }
    return sum
}

func sumFromOneToNRecursively(n: Int) -> Int {
    guard n > 1 else {return 1}
    return n + sumFromOneToNRecursively(n: n-1)
}

sumFromOneToNRecursively(n: 5)

func factorialRecursively(n:Int) -> Int {
    //let's figure out n!
    guard n > 1 else { return 1 }
    return n * factorialRecursively(n: n-1)
}

print(factorialRecursively(n: 1))
print(factorialRecursively(n: 3))
print(factorialRecursively(n: 10))
print(factorialRecursively(n: 11))
//danger danger danger!
//we can get an infinite loop if we don't set up our base cases correctly.

//n is the term (think of this like counting the number of items between commas from left to right... almost like an array's index) that we want to find the value for
func fib(n: Int) -> Int {
    guard n >= 1 else {return 0}
    if n == 2 {return 1}
    return fib(n: n-1) + fib(n: n-2)
}

// write a recursive function that take a sentence (a string with words in it) and returns the sentence in reverse order.
// Hint: string.reverse doesn't do what we want here
// "here is a string" -> "string a is here", not "gnirts a si ereh"
// Advice: solve it iteratively first to find the pattern you'll want to apply recursively.

//first let's talk about an iterative solution

func reverseSentenceIteratively(input: String) -> String {
    //this line converts our string into an array of words
    let inputArray = input.components(separatedBy: " ")
    var reversedInput = ""
    //loop through
    for i in inputArray.reversed() {
        if reversedInput == "" {
            //why? There aren't any spaces :( Gotta start without one
            reversedInput += i
        } else {
            //why? for all words after the first one, let's make sure there's a space separating them from the previous one.
            reversedInput += " \(i)"
        }
    }
    return reversedInput
}

func reverseSentenceIterativelyOneLine(input:String) -> String {
    input.components(separatedBy: " ").reversed().joined(separator: " ")
}

// don't think it's right
// base case: if the count in the array of words is 1, return the first thing in the array
// let reversed sentence = array.popLast
// form the new string from the words left in the sentence array using a join

func reverseSentenceRecursivelyMaybe(input:String) -> String {
    //    "this is cool" -> ["this", "is", "cool"]

    var sentArr = input.components(separatedBy: " ")
    
    //base case - "nice"
    if sentArr.count == 1 {
      return sentArr[0]
    }
    
    let reverseSent = sentArr.popLast()! //cool, [this, is]
    
    let newString = sentArr.joined(separator: " ") //"this is"
    // cool + " " + f("this is")
    // cool + " " + "is" + " " + f("this")
    // cool + " " + "is" + " " + "this"

    return reverseSent + " " + reverseSentenceRecursivelyMaybe(input: newString)
    
    //call self inside of self
}
