//
//  ContentView.swift
//  labtest
//
//  Created by Ethan Sylvester on 2025-02-09.
//

import SwiftUI

struct GameScreen: View {
    @State private var questionNumber: String = "2";
    
    var body: some View {
        VStack {
            Grid {
                GridRow {
                    Text(questionNumber)
                        .padding()
                }
                GridRow {
                    Button("Prime", action: checkAnswer )
                        .padding()
                }
                GridRow {
                    Button("Not Prime",  action: checkAnswer)
                        .padding()
                }
            }
        }
        .padding()
    }
    
    func checkAnswer() {
        // cast the number in question to an int
        let questionInt = Int(questionNumber)!

        // check the first and last index of the prime numbers collection for matching, because they
        // will take the longest to find in a binary search
        if (questionInt == primeNumbers[0] || questionInt == primeNumbers[primeNumbers.count - 1]) {
            correctAnswers.append(true)
            return
        }
        // if numbers arent the first or last index, binary search the collection, and append whether or not
        // it was found to the answers collection
        correctAnswers.append(binarySearch(questionInt))
    }
    
    func binarySearch(_ number: Int) -> Bool {
        var min = 0, max = primeNumbers.count - 1
        print()

        while (min < max) {
            let mid = (min + max / 2)

            if (primeNumbers[mid] == number)
            {
                return true
            }
            if (primeNumbers[mid] < number) {
                min = mid + 1
            } else {
                max = mid - 1
            }
        }
        return false
    }
}

let primeNumbers = [
    2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73,
    79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157,
    163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239,
    241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331,
    337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421,
    431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509,
    521, 523, 541, 547, 557, 563, 569, 571, 577, 587, 593, 599, 601, 607, 613,
    617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701, 709,
    719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797, 809, 811, 821,
    823, 827, 829, 839, 853, 857, 859, 863, 877, 881, 883, 887, 907, 911, 919,
    929, 937, 941, 947, 953, 967, 971, 977, 983, 991, 997
]

var correctAnswers: Array<Bool> = []



#Preview {
    GameScreen()
}
