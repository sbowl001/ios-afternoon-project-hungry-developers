import UIKit

class Spoon {
    //    Add an index property to Spoon.
    var index: Int
    init(_ index: Int) {  //why _?
        self.index = index
    }
    private var lock = NSLock()
    func pickup() {
       self.lock.lock()
    }
    func putDown() {
        self.lock.unlock()
        
    }
}

class Developer {
    var name: String
    var leftSpoon: Spoon
    var rightSpoon: Spoon
    
    
    init(name: String, leftSpoon: Spoon, rightSpoon: Spoon ) {
        self.name = name
        self.leftSpoon = leftSpoon
        self.rightSpoon = rightSpoon
    }
    func think(){
        let lowerIndexSpoon: Spoon
        let higherIndexSpoon: Spoon
        
        if leftSpoon.index < rightSpoon.index {
            lowerIndexSpoon = leftSpoon
            higherIndexSpoon = rightSpoon
        } else {
            higherIndexSpoon = leftSpoon
            lowerIndexSpoon = rightSpoon
        }
        
        lowerIndexSpoon.pickup()
        higherIndexSpoon.pickup()  //what guarantees that the lower index spoon is picked up first? // the lock?
        
        //    Refactor think() function, so that a developer will always pick up their lower-numbered spoon first. (The order in which they put them down doesn't matter.)
        //    Test the app again. In theory, with this solution, the app can't deadlock. Run it until you're confident that that's true.
        //        should pick up both spoons before returning.
    }
    
    func eat() {
//        should pause for a random amount of time before putting both spoons down
        usleep(2_000)
        print("\(self.name) started eating")
        self.leftSpoon.putDown()
        self.rightSpoon.putDown()
        print("\(self.name) finished eating")
    }
    
    func run(){
        while true {
            self.think()
            self.eat()
        }
        
      
    }
    
}
    
    
    
    
    

    



 
    //    Create 5 Spoons and 5 Developers giving each developer a left and right spoon. Note that developers will of course share spoons. Every developer's right spoon is the next developer's left spoon.
//    Give each spoon an index from 1 to 5.
    var spoon1 = Spoon(1)
    var spoon2 = Spoon(2)
    var spoon3 = Spoon(3)
    var spoon4 = Spoon(4)
    var spoon5 = Spoon(5)
    
    let dev1 = Developer(name: "dev1", leftSpoon: spoon1, rightSpoon: spoon2)
    let dev2 = Developer(name: "dev2", leftSpoon: spoon2, rightSpoon: spoon3)
    let dev3 = Developer(name: "dev3", leftSpoon: spoon3, rightSpoon: spoon4)
    let dev4 = Developer(name: "dev4", leftSpoon: spoon4, rightSpoon: spoon5)
    let dev5 = Developer(name: "dev5", leftSpoon: spoon5, rightSpoon: spoon1)
//    Call run() on each developer in a different queue/thread. You can do this with the following code assuming you put your developers in an array:

    var developers: [Developer] = [dev1, dev2, dev3, dev4, dev5]
    DispatchQueue.concurrentPerform(iterations: 5) {
    developers[$0].run()
}

