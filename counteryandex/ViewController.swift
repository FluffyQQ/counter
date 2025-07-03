//
//  ViewController.swift
//  counteryandex
//
//  Created by Максим Фролов on 03.07.2025.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var counterText: UILabel!
    @IBOutlet weak var logText: UITextView!
    
    private var counter: Int = 0 {
        didSet {
            counterText.text = "\(counter)"
            let dateString = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium)
            if counter == 0 && oldValue != 0 {
                logText.text.append("\n\(dateString): значение сброшено")
            } else if counter > oldValue {
                logText.text.append("\n\(dateString): значение изменено на +1")
            } else if counter < oldValue {
                logText.text.append("\n\(dateString): значение изменено на -1")
            }
            scrollToBottom()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logText.text = "История изменений:"
        counterText.text = "\(counter)"
        logText.isEditable = false
        // Устанавливаем цвета кнопок, если не задано в storyboard
        if let plusButton = self.view.viewWithTag(101) as? UIButton {
            plusButton.tintColor = .systemRed
        }
        if let minusButton = self.view.viewWithTag(102) as? UIButton {
            minusButton.tintColor = .systemBlue
        }
    }
    
    @IBAction func increment() {
        counter += 1
    }
    
    @IBAction func decrement() {
        if counter > 0 {
            counter -= 1
        } else {
            let dateString = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium)
            logText.text.append("\n\(dateString): попытка уменьшить значение счётчика ниже 0")
            scrollToBottom()
        }
    }
    
    @IBAction func reset() {
        counter = 0
    }
    
    
    private func scrollToBottom() {
        guard !logText.text.isEmpty else { return }
        let range = NSMakeRange(max(logText.text.count - 1, 0), 1)
        logText.scrollRangeToVisible(range)
    }
    
}
