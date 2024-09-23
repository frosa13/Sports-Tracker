//
//  CountdownLabel.swift
//  Sports Tracker
//
//  Created by Francisco Rosa on 22/09/2024.
//

import UIKit

class CountdownLabel: UILabel {
    
    private var countdownTimer: Timer?
    
    var targetDate: Date? {
        didSet {
            startCountdown()
        }
    }
    
    var countdown: DateComponents {
        return Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: targetDate ?? Date())
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func updateTime() {
        let countdown = self.countdown
        
        guard let hours = countdown.hour,
              let minutes = countdown.minute,
              let seconds = countdown.second else {
            self.text = "--:--:--"
            return
        }
        
        // Reached the target date
        guard hours >= 0 && minutes >= 0 && seconds >= 0 else {
            self.text = "00:00:00"
            countdownTimer?.invalidate()
            return
        }
    
        self.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    private func startCountdown() {
        countdownTimer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateTime),
            userInfo: nil, repeats: true
        )
    }
    
    func invalidateTimer() {
        countdownTimer?.invalidate()
    }
}
