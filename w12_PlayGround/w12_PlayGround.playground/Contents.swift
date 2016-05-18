//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

// var: 변수 let: 불변 변수 = 상수
// type은 : 찍고 뒤에 씀

var view : UIView

// alloc은 안해도 됨 initWithCoder:(NSCoder *)coder key:()__ 형태를 지원함
//view = UIView.init(coder: <#T##NSCoder#>)
view = UIView.init(frame: CGRectMake(0, 0, 100, 100))
view.backgroundColor = UIColor.redColor()

view.backgroundColor = UIColor.yellowColor()


var total = 0

// 모든 변수는 초기화가 필요 ()로 초기화
var numberArray : [Int] = [Int]()
for number in 0..<10 {
    numberArray.append(number)
    total += number
}

numberArray
print("\(numberArray)")

func greet(name: String, day: String) -> String {
    return "Hello \(name), today is \(day)."
}
greet("Bob", day: "Tuesday")

// filter, map & reduce
let words = ["angry", "hungry", "aardvark", "aardwolf"]

func concatenate(xs: [String]) -> String {
    var result: String = ""
    for x in xs {
        result += x + " "
    }
    return result.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
}
concatenate(words)
// "angry hungry aardvark aardwolf"

print("GRR!! " + words
    .filter {$0.hasSuffix("gry")}
    .map {$0.uppercaseString}
    .reduce("HULK") {"\($0) \($1)"} + "!!!"
)
// "GRR!! HULK ANGRY HUNGRY!!!"

// filter & map 예제
let x = [10, 3, 20, 15, 4]
    .sort()
    .filter { $0 > 5 }
    .map { $0 * 100 }

print("\(x)")

func hammingWeight(number: Int) -> (String, Int) {
    var 몫 = (Int)(number / 2)
    var 나머지 = number % 2
    var 결과 = String(나머지)
    var 개수 = 0
    
    if (나머지 == 1) {
        개수 = 개수 + 1
    }
    
    while (몫 > 0) {
        나머지 = 몫 % 2
        몫 = (Int)(몫 / 2)
        if (나머지 == 1) {
            개수 = 개수 + 1
        }
        결과 = String(나머지) + 결과
    }
    
    return (결과, 개수)
}

let result = hammingWeight(11)
print("\(result)")

// in이 축약 문법
func hammingWeight2(n: Int) -> (String, Int) {
    let tString = String(n, radix: 2)
    let ones = tString.characters.filter({
        (c: Character) -> Bool in
        c == "1" ? true : false
    })
    
    return (tString, ones.count)
}

let result2 = hammingWeight2(11)
print("\(result2)")

// struct와 enum은 value type, class은 reference type
// struct로 넘기면 복사됨 만약 struct 안에 class가 들어있었다면 포인터만 복사되므로 class는 reference type으로 남음
// Swift의 객체는 reference count가 없으므로 value와 reference type을 둘 다 쓸 수 있음
// Objective-C와의 호환을 위해 @Objective?~~ 라고 class 앞에 붙이면 Cocoa에 넘길 수 있음
// 단 struct는 넘기기 어려움
// value type은 scope가 함수 안으로 제한되므로 var 대신 let으로 가져옴
// closure는 변수를 캡쳐해옴

// pascal삼각형 만들기

func makePascalTriangle(numberOfRows: Int) -> ([[Int]]) {
    func makePascal(numberOfRowsNeeded: Int, intermediateArray: [[Int]]) -> (numberOfRowsNeeded:Int, result: [[Int]]) {
        if numberOfRowsNeeded == 0 {
            return (0, result: intermediateArray)
        } else if numberOfRowsNeeded == numberOfRows {
            return makePascal(numberOfRowsNeeded - 1, intermediateArray: [[1]])
        } else {
            let previousArray = intermediateArray[intermediateArray.count - 1]
            
            var middleArray : [Int] = [Int]()
            for number in 0...previousArray.count {
                if number == 0 {
                    middleArray.append(previousArray[number])
                } else if number == previousArray.count{
                    middleArray.append(previousArray[number - 1])
                } else {
                    middleArray.append(previousArray[number - 1] + previousArray[number])
                }
            }

            var interResultArray = intermediateArray
            interResultArray.append(middleArray)
        
            return makePascal(numberOfRowsNeeded - 1, intermediateArray: interResultArray)
        }
    }
    
    return makePascal(numberOfRows, intermediateArray: [[Int]]()).result
}

let resultPascal = makePascalTriangle(5)
print("resultPascal: \(resultPascal)")


