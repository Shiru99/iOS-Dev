/*
        Basics of swift
*/

import Foundation


// 1. Variables

var x: Int = 0
var y: Float=1.0;
var z: Double=1.00000000000001;

var b: Bool = false;

var s: String="text";


// 2. Constants

let abc = "hello there";
//abc = "hello world";  // ERROR


// 3. Arrays

var nums : [Float] = [];

var temp: [Any] = [1,2,3,4,"five",6];

var ages = [1,2,43];
//ages.count;
//ages.last
//ages[2]

//ages.append(99)
//ages.insert(99, 2);
//ages.sort();
//ages.reverse();
//ages.shuffle();
 

// 4. Sets - unordered

var setZ : Set<Int> = [ ]

// 5. Hashable

var ageSet = Set(ages)
print(ageSet)
// ageSet.contains(99)     // constant time
// ageSet.insert(99)  


// 6. Dictionary

var devices: [String:String] = [
    "phone":"nokia",
    "laptop":"HP",
    "smartWatch":"NA",
]

// devices["phone"]


// 7. Function

func printHello()  {
    print("Hello World!")
}

printHello() 


func printName(name: String)  {
    print(name)
}

printName(name: "John Doe") 

func addition(firstNumber: Int, secondNumber: Int) -> Int {
    let sum = firstNumber + secondNumber
    return sum;
}



var output = addition(firstNumber:99, secondNumber: 100)

print(output)


// to : argument label - makes call site more readable

func subtraction(firstNumber: Int, to secondNumber: Int) -> Int {
    let sub = firstNumber - secondNumber
    return sub;
}

output = subtraction(firstNumber:100, to:99) // call site
print (output)

// output = subtraction(firstNumber:100, secondNumber:99)  // ERROR


// 8. Conditional

var isDarkModeOn = false

if isDarkModeOn {
    print("Dark Mode is on")
} else {
    print("Dark Mode us off")
}


var highScore = 64

if highScore <= 50{
    print("Need improvement in this field")
} else if( highScore < 75 && highScore > 50) {
    print("Doing great... keep it up")
}else {
    print("Good Work")
}


// 9. Loops

let names = ["John Doe", "James Doe", "Jenny Doe"]

for name in names{
    print(name)
}

print("---")

for name in names where name.contains("Doe"){
    print("- "+name)
}
print("---")


for i in 1...5{
    print(i)
}
print("---")

for i in 0..<5{
    print(i)
}

// 10. Enum
enum Direction {
    case East
    case West
    case North 
    case South
}

func getDirectionFromCompass(in direction : Direction){
    if( direction == .North){
        print("Pointing correctly towards north")
    }else{
        print("Something went wrong... not pointing towards north")
    }
}

getDirectionFromCompass(in: Direction.South)
getDirectionFromCompass(in: Direction.North)
getDirectionFromCompass(in: .East)
getDirectionFromCompass(in: .West)

enum Phone: String {
    case iPhone14 = "Cool phone by apple"
    case pixel = "Clean phone by Google"
}

func describePhone(in phone : Phone){
    print(phone.rawValue)       // rawValue
}

describePhone(in: .iPhone14)
describePhone(in: .pixel)
// describePhone(in: "pixel")   // Error



// 11. Switch Statements

func getDirectionFromCompassWithSwitch(in direction : Direction){
    switch direction {
    case .North:
        print("Go North")
    case .South:
        print("Go South")
    case .East:
        print("Go East")
    default:
        print("Go west")
    }
}

getDirectionFromCompassWithSwitch(in: .West)



// 12. Operators

let v1: Int = 44;
let v2: Int = 88;

var div = v1 / v2;
print(div)

let rem = v2 % v1
print (rem)


if (v1 != v2) {
    print("v1 & v2 are not equal")
}else{
    print("v1 & v2 are equal")
}

// var isDarkModeOn = false

if !isDarkModeOn && (true || false) {
    print("Dark Mode is off")
}

div += 1
div -= 1

var name = "John"
let text = "Hello " + name 

print(text)


// 13. Optional

 
ages = [] // [1,3,66,2,56,77,99,22]
ages.sort()

// if let
if let oldestAge = ages.last {
    print("The oldest age is \(oldestAge)") //String Interpolation
} else {
    print("this result seems to be nil")
}


// nil coalescing
let oldestAge1 = ages.last ?? 100
print("The oldest age is \(oldestAge1)")

// guard statement
func getOldestAge(){
    guard let oldestAge2 = ages.last else {
        print("this variable seems to be nil")
        return; 
    }
    
    print("The oldest age is \(oldestAge2)")
}

getOldestAge()

// force unwrap
// let oldestAge3 = ages.last!


// 14. Classes

//
class Dev {
    var name:String = "";
    var jobTitle:String = "";
    var yearsExp: Int = 0;
}

let james = Dev()
print(james)

//
class Dev1 {
    var name:String?
    var jobTitle:String?
    var yearsExp: Int?
}
let jenny = Dev1()
print(jenny)

//
class Dev2 {
    var name:String?
    var jobTitle:String?
    var yearsExp: Int?
    
    init(){}
    
    init(name: String, jobTitle:String, yearsExp:Int){
        self.name=name;
        self.jobTitle=jobTitle;
        self.yearsExp=yearsExp;
    }
    
    func printName(){
        print(name!)    // force unwrap
    }
}

let joy = Dev2()
// joy.printName()  // error

let joe = Dev2(name: "John Doe", jobTitle: "SDE-0", yearsExp: 0)
joe.printName()

//
class Developer {
    var name:String
    var jobTitle:String
    var yearsExp: Int
    
    init(name: String, jobTitle:String, yearsExp:Int){
        self.name=name;
        self.jobTitle=jobTitle;
        self.yearsExp=yearsExp;
    }
    
    func getDetails(){
        print("[name - \(self.name), jobTitle - \(self.jobTitle), yearsExp - \(self.yearsExp)]")
    }
}


let john = Developer(name: "John Doe", jobTitle: "SDE-0", yearsExp: 0)
print(john)
john.getDetails()


// 14. inheritance 

class iOSDeveloper: Developer{
    var favFramework: String?

    func tellFavFramework(){
        if let favFramework_ = self.favFramework {
            print(favFramework_)
        }else {
            print("This Dev don't have any fav framework")
        }
    }

    override func getDetails(){
        guard let favFramework_ = self.favFramework else {
            super.getDetails()
            return; 
        }

        print("[name - \(self.name), jobTitle - \(self.jobTitle), yearsExp - \(self.yearsExp) & fav framework is - \(favFramework_)]")
    } 
}

let joey = iOSDeveloper(name: "joey Doe", jobTitle: "SDE-0", yearsExp: 0)
joey.tellFavFramework()
joey.getDetails();

joey.favFramework="ARKit"
joey.tellFavFramework()
joey.getDetails();


// 15. Struct - value type

struct DevStruct {
    var name:String
    var jobTitle:String
    var yearsExp: Int
    
    func getDetails(){
        print("[name - \(self.name), jobTitle - \(self.jobTitle), yearsExp - \(self.yearsExp)]")
    }
}

let johnStruct = DevStruct(name: "John Doe", jobTitle: "SDE-0", yearsExp: 0)
print(johnStruct)

johnStruct.getDetails()


// 16. Reference type vs Value type

var l1 = john       // class
var l2 = johnStruct // struct

l1.name = "John Doe 2"
l2.name = "John Doe 2"

print(john.name + " == " + l1.name)
print(johnStruct.name + " != " +  l2.name)


// 17. extension - Extensions add new functionality to an existing class, structure, enumeration, or protocol type

extension Int {
    func square() -> Int {
        return self * self
    }
}

let num = 5
print(num.square())


