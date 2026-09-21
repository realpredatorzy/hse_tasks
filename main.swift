import Foundation

func playMap(player1 : Int, player2: Int) {
    var row = Array(1...10)
    
    let ladders = [
        3: 22,
        10: 19,
        23: 41,
        31: 48,
        49: 67,
        85: 91
    ]
    let snakes = [
        11:1,
        18:5,
        36:20,
        56:51,
        70:52,
        81:68,
        97:80
    ]
    
    for _ in 0..<10 {
        var line = ""
        
        for cell in row {
            if player1 == cell && player2 == cell {
                line += " X "
            } else if player1 == cell {
                line += "p1 "
            } else if player2 == cell {
                line += "p2 "
            } else if ladders.keys.contains(cell) {
                line += "L1 "
            } else if ladders.values.contains(cell){
                line += "L2 "
            } else if snakes.keys.contains(cell) {
                line += "S1 "
            } else if snakes.values.contains(cell){
                line += "S2 "
            } else {
                line += String(format: "%2d ", cell)
            }
        }
        
        print(line)
        row = Array(row.map { $0 + 10 }.reversed())
    }
}

func game() {
    var curPosPlayer1 = 1
    var curPosPlayer2 = 1
    var currentPlayer = 1
    
    let ladders = [
        3: 22,
        10: 19,
        23: 41,
        31: 48,
        49: 67,
        85: 91
    ]
    let snakes = [
        11:1,
        18:5,
        36:20,
        56:51,
        70:52,
        81:68,
        97:80
    ]
    
    playMap(player1: curPosPlayer1, player2: curPosPlayer2)
    
    while curPosPlayer1 != 100 && curPosPlayer2 != 100 {
        var msg = ""
        while msg != "go" {
            print()
            print("Введите 'go', чтобы бросить кубик")
            msg = readLine() ?? ""
        }
        let score = Int.random(in: 1...6)
        
        if currentPlayer == 1 {
            print("Ходит первый игрок")
            curPosPlayer1 += score
            
            if curPosPlayer1 > 100 {
                curPosPlayer1 -= score
            }
            
            if ladders[curPosPlayer1] != nil {
                curPosPlayer1 = ladders[curPosPlayer1]!
                print("Поднялся по лестнице")
            }
            
            if snakes[curPosPlayer1] != nil {
                curPosPlayer1 = snakes[curPosPlayer1]!
                print("Спустился по змее")
            }
            
            print("Игрок 1 выбросил \(score) и оказался на клетке \(curPosPlayer1)")
            playMap(player1: curPosPlayer1, player2: curPosPlayer2)
            currentPlayer = 2
        } else {
            print("Ходит второй игрок")

            curPosPlayer2 += score
            
            if curPosPlayer2 > 100 {
                curPosPlayer2 -= score
            }
            
            if ladders[curPosPlayer2] != nil {
                curPosPlayer2 = ladders[curPosPlayer2]!
                print("Поднялся по лестнице")
            }
            
            if snakes[curPosPlayer2] != nil {
                curPosPlayer2 = snakes[curPosPlayer2]!
                print("Спустился по змее")
            }
            
            print("Игрок 2 выбросил \(score) и оказался на клетке \(curPosPlayer2)")
            playMap(player1: curPosPlayer1, player2: curPosPlayer2)
            currentPlayer = 1
        }
    }
    if curPosPlayer1 == 100 {
        print("Победил игрок 1!")
    } else {
        print("Победил игрок 2!")
    }
}


game()
