let game = BaseballGame()
game.start()

class BaseballGame {
    func start() {
        let answer = makeAnswer()
        
//        print(answer) // 정상 작동 확인용
        
        print("< 게임을 시작합니다 >")
       
        while true {
            print("숫자를 입력하세요")
            
            let input = readLine()! // !로 옵셔널 언레핑
            if let inputArray = input.map({ Int(String($0)) }).compactMap({ $0 }) as? [Int], inputArray.count == 3 {
                if Set(inputArray).count != 3 || inputArray[0] == 0 {
                    print("올바르지 않은 입력값입니다")
                    continue
                }
                
                if self.checkStrikeBall(answer: answer, input: input) {
                    break
                }
            } else {
                print("올바르지 않은 입력값입니다.")
            }
        }
    }


    func checkStrikeBall(answer: [Int], input: String) -> Bool {
      
        let input = Array(input.map { Int(String($0))! }) // 타입 변환
        
        var strike = 0
        var ball = 0
        for i in 0...9 {
            if let answerIndex = answer.firstIndex(of: i),
               let inputIndex = input.firstIndex(of: i) {
                if answerIndex == inputIndex {
                    strike += 1
                } else {
                    ball += 1
                }
            }
        }
        if answer == input {
            print("정답입니다!")
            return true
        } else if strike == 0 && ball == 0 {
            print("Nothing")
            return false
        } else {
            print("\(strike)스트라이크, \(ball)볼")
            return false
        }
    }
    
    func makeAnswer() -> [Int] {
        
        var answer = [Int]()
        answer.append(Int.random(in: 1...9))
        answer.append(Int.random(in: 0...9))
        answer.append(Int.random(in: 0...9))
        if Set(answer).count == 3 {
            return answer
        } else {
            return makeAnswer()
        }
    }
}



// 핵심흐름: 정답생성 -> 게임시작 -> 사용자 입력받기 -> 정답비교 -> 결과 출력 및 반복

