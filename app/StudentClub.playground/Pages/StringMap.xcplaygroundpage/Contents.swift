//: [Previous](@previous)

import Foundation

//var str = "[1, 100, 101, 102, 999]"
//    .dropFirst().dropLast()
//    .split(separator: ",")
//    .map(String.init)
//    .map{$0.trimmingCharacters(in: CharacterSet.whitespaces)}
//    .map{Int($0)}
//
//print(str)


//var list = [1,2,3,4].map{$0+2}


struct Out{
    var num: Int
}

struct In{
    var num: Int
    
    init(out: Out) {
        self.num = out.num + 2
    }
}

var list = [Out(num: 1), Out(num: 2), Out(num: 3)]
    .map{In(out: $0)}

print(list.map{$0.num})


//: [Next](@next)
