//
//  TimerManager.swift
//  Run
//
//  Created by Лукичев Сергей on 24.08.2023.
//

import UIKit
import Combine

final class TimerManager {
    
    private var timer: Timer?
    
    @Published var elapsedTime = 0.0
    @Published var isRunning = false
    
    func startTimer() {
        logger.log("\(#fileID) -> \(#function)")
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.elapsedTime += 0.1
            
            if let timer = self.timer {
                RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
            }
        }
    }
    
    func stopTimer() {
        logger.log("\(#fileID) -> \(#function)")
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        logger.log("\(#fileID) -> \(#function)")
        isRunning = false
        elapsedTime = 0.0
        timer?.invalidate()
        timer = nil
    }
    
}
