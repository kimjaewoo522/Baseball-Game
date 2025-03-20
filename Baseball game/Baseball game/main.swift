//
//  main.swift
//  Baseball game
//
//  Created by 김재우 on 3/17/25.
//

let game = BaseballGame() //맨 밑으로 가도 상관이없는지
game.start()

class BaseballGame {
    func start() {
        let answer = makeAnswer()
        
        print(answer) // TODO: 다 완성하고 지우기
        
        print("< 게임을 시작합니다 >")
       
        while true {
            print("숫자를 입력하세요")
            
            let input = readLine()! // readLine으로 넘어온건 String으로 받아온다
            if let inputArray = input.map({ Int(String($0)) }).compactMap({ $0 }) as? [Int], inputArray.count == 3 {
                if Set(inputArray).count != 3 || inputArray.contains(0) {
                    print("올바르지 않은 입력값입니다")
                    continue
                }
                
                if self.checkStrikeBall(answer: answer, input: input) { //본인 것을 호출할때 에는 인스턴스 이름 없이 바로 호출할수 있다. 굳이 명시하려면 self를 붙인다
                    break
                }
            } else {
                print("올바르지 않은 입력값입니다.")
            }
        }
    }


    func checkStrikeBall(answer: [Int], input: String) -> Bool {
        //  let answer = answer.map { "\($0)" }.joined()  // answer를 string으로 바꿔주는 역할을 한다
        let input = Array(input.map { Int(String($0))! }) // 타입 변환 나중에 알아보기
        
        // 숫자 3개중 배열에 포함되는 숫자가 있는지 판단, but 그 숫자가 정답 자리에 있으면 안됨(볼)
        // 숫자 3개중 배열에 그 순서가 맞는 숫자가 있는지 판단(스트라이크)
        var strike = 0
        var ball = 0
        for i in 0...9 {
            if let answerIndex = answer.firstIndex(of: i), // example:  479 일떄    9 index 2
               let inputIndex = input.firstIndex(of: i) { // if let은 nil값이 아닐때만 실행함(optional binding, nil값을 뱉으면 아예 실행을 안하니까 그 숫자가 있는지 없는지 까지 판단 가능, 일단 실행이 되면 그 인덱스 자리에 같은 i 값이 있으면 strike 아니면 ball로 판단가능)
                if answerIndex == inputIndex {  // answer와 input 배열에서 숫자 i의 위치가 같은지 비교
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
        // TODO: 랜덤 숫자 3개 배열 반환해야함
        var answer = [Int]()
        answer.append(Int.random(in: 1...9))
        answer.append(Int.random(in: 1...9))
        answer.append(Int.random(in: 1...9)) // 배열이 숫자 3개니까 한개씩 랜덤한수 추가?
        if Set(answer).count == 3 {   // set을 왜썼을까? 3이어야 숫자 3개가 랜덤한 수로 지정되었다는 뜻 answer: 순서가 없다, 중복을 허용하지 않는다(중복된 수 는제거 )
            return answer
        } else {
            return makeAnswer() // 이건 뭘까(recursive, 재귀) 다시 makeAnswer를 호출해서 처음부터 다시시작 true일떄 answer 반환
        }
    }
}



// 핵심흐름: 정답생성 -> 게임시작 -> 사용자 입력받기 -> 정답비교 -> 결과 출력 및 반복

// 야구게임 룰: 랜덤한 숫자 3개를 생성한다(set 이용?)-> 상대방이 숫자 3개를 말한다(순서 상관x)
//
// while 사용 ? : 조건이 true면 조건이 false가 될 때까지 반복
// while vs for in : 반복횟수를 개발자가 예측할 수 있으면 for를 쓰고 예측할 수 없으면 while을 쓴다
//
//
//
//
// ex) 생각한 숫자 345
// 상대방 숫자: 123 = 1 볼
// 상대방 숫자: 543 = 1 스트라이크 2 볼
// 상대방 숫자: 678 = Nothing
//
// 예외처리
// ads: 세자리 '숫자'가 아님 "올바르지 않은 입력값입니다"
// 288: 중복되는 숫자가 존재 "올바르지 않은 입력값입니다"
// 103: 1-9 숫자가 아닌 숫자가 들어갔으므로 "올바르지 않은 입력값입니다"
// 345: "정답입니다!"
