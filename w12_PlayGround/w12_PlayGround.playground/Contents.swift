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
