//
//  [프로그래머스] 멀쩡한 정사각형 개수 구하기
//
//
//  https://programmers.co.kr/learn/courses/30/lessons/62048
//

import Foundation

func solution(_ w: Int, _ h: Int) -> Int64 {
    let answer: Int64 = Int64(w * h)
    let gcd = getGcd(w, h)
    
    return answer - Int64(w + h - gcd)
}

// 최대공약수 구하기 - 유클리드 호제법
func getGcd(_ num1: Int, _ num2: Int) -> Int {
    guard num1 != 0 && num2 != 0 else {
        return 0
    }
    
    guard num1 != 1 && num2 != 1 else {
        return 1
    }
    
    guard num1 % num2 != 0 else {
        return num2
    }
    
    guard num2 % num1 != 0 else {
        return num1
    }
    
    var big = (num1 > num2 ? num1 : num2)
    var small = (num1 < num2 ? num1 : num2)
    
    while big % small != 0 {
        let temp = big % small
        big = small
        small = temp
    }
    
    return small
}
