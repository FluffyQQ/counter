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
                logText.text.append("\n\(dateString): значение увелично на +1")
            } else if counter < oldValue {
                logText.text.append("\n\(dateString): значение уменьшено на -1")
            }
            scrollToBottom()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logText.text = "История изменений:"
        counterText.text = "\(counter)"
        logText.isEditable = false
    }
    
    @IBAction func increment() {
        counter += 1
    }
    
    @IBAction func decrement() {
        if counter > 0 {
            counter -= 1
        } else {
            let dateString = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short)
            logText.text.append("\n\(dateString): поппытка уменьшить значение счётчика ниже 0")
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
