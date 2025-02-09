//
//  ContentView.swift
//  labtest
//
//  Created by Ethan Sylvester on 2025-02-09.
//

import SwiftUI

struct GameView: View {
    @State private var questionNumber: Int = Int.random(in: 0...1000);
    @State private var image: Image? = nil
    @State private var roundNumber: Int = 1
    @State private var correctAnswers: Int = 0
    @State private var roundTimer = 5
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        VStack {
            Grid {
                GridRow {
                    Text("\(String(roundTimer))s.")
                }.font(.system(size: 32))
                
                GridRow {
                    Text(String(questionNumber))
                        .padding()
                        .font(.system(size: 64))
                    
                }
                GridRow {
                    Button("Prime") {
                        checkAnswer(true)
                    }
                    .padding()
                    .font(.system(size: 32))
                }
                GridRow {
                    Button("Not Prime") {
                        checkAnswer(false)
                    }
                    .padding()
                    .font(.system(size: 32))
                }
                GridRow {
                    image?.resizable()
                }.padding()
                    .frame(width: 100, height: 100)
              
                if (roundNumber == 10) {
                    GridRow {
                        Text("You got \(correctAnswers) correct!")

                    }.padding()
                        .font(.system(size: 32))
                    GridRow {
                        Button("Play again!") {
                            roundNumber = 1
                            correctAnswers = 0
                            image = nil
                            roundTimer = 5
                        }.padding()
                            .font(.system(size: 32))
                           
                    }
                }
            }
        }.onReceive(timer) {
            time in
            if (roundNumber == 10) {
                return
            }
            if roundTimer > 0 {
                roundTimer -= 1
            } else {
                outOfTime()
                roundTimer = 5
            }
        }

    }
    
    func outOfTime() {
        image = Image("x")
        roundNumber += 1
        questionNumber  = Int.random(in: 0...1000)
    }
    
    
    
    func checkAnswer(_ isPrime: Bool) {
        if (roundNumber == 10) {
            return
        }
        // cast the number in question to an int
        let questionInt = questionNumber
        
        // check the first and last index of the prime numbers collection for matching, because they
        // will take the longest to find in a binary search
        if (questionInt == primeNumbers[0] || questionInt == primeNumbers[primeNumbers.count - 1]) {

            image = Image("check")
            correctAnswers += 1
            roundNumber += 1
            questionNumber  = Int.random(in: 0...1000)
            return
            
        }
        // if numbers arent the first or last index, binary search the collection, and append whether or not
        // it was found to the answers collection
        let numberIsPrime = binarySearch(questionInt)
    
        
        if (isPrime == numberIsPrime) {
            image = Image("check")
            correctAnswers += 1
        } else {
            image = Image("x")
        }

        questionNumber = Int.random(in: 0...1000)

        roundNumber += 1
        
    }
    
    func binarySearch(_ number: Int) -> Bool {
        var min = 0, max = primeNumbers.count - 1

        
        while (min < max) {

            let mid = (min + max) / 2
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


#Preview {
    GameView()
}
