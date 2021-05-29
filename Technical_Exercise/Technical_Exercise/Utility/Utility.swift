//
//  Utility.swift
//  Technical_Exercise
//
//  Created by Fuh chang Loi on 29/5/21.
//

import Foundation
import UIKit

class Utility {
    public static let shared = Utility()
    func dateFormatter(strDate: String) -> String {
        var str = strDate
        if let dotRange = str.range(of: ".") {
            str.removeSubrange(dotRange.lowerBound..<str.endIndex)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let formattedDate = dateFormatter.date(from: "\(str)+0000") {
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "dd.MM.yy"
                return dateFormatterPrint.string(from: formattedDate)
            }
        }
        return ""
    }
    
    func loadDataFromJsonFile(fileName: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: fileName, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    func jsonParser(jsonData: Data) -> bitbucketInfo? {
        do {
            let decodedData = try JSONDecoder().decode(bitbucketInfo.self, from: jsonData)
            return decodedData
        } catch {
            print("decode error")
        }
        return nil
    }
}

extension UIView {
    
    public func removeAllConstraints() {
        var _superview = self.superview
        while let superview = _superview {
            for constraint in superview.constraints {
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }
                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }
            _superview = superview.superview
        }
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }
}

var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}

extension Thread {
    var isRunningXCTest: Bool {
        for key in self.threadDictionary.allKeys {
            guard let keyAsString = key as? String else {
                continue
            }
            if keyAsString.split(separator: ".").contains("xctest") {
                return true
            }
        }
        return false
    }
}


