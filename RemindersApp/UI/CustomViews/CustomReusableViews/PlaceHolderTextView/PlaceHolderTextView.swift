//
//  PlaceHolderTextView.swift
//  RemindersApp
//
//  Created by Burak Gül on 12.07.2024.
//

import UIKit

class PlaceHolderTextView: UITextView {
    
    private lazy var placeHolderLabel: UILabel = {
        var placeHolderLabel = UILabel()
        return placeHolderLabel
    }()
    
    weak var externalDelegate: UITextViewDelegate?
    
    
    //MARK: - Init Functions
    init(frame: CGRect, textContainer: NSTextContainer?, placeholder: String, placeholderColor: UIColor) {
        super.init(frame: frame, textContainer: textContainer)
        configurePlaceholder(placeholder: placeholder, color: placeholderColor)
        // here is very important because this assignment runs hide/show label
        self.delegate = self
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    private func setup() {
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(placeHolderLabel)
        NSLayoutConstraint.activate([
            placeHolderLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            placeHolderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            placeHolderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
    }
    
    private func configurePlaceholder(placeholder: String, color: UIColor) {
        placeHolderLabel.text = placeholder
        placeHolderLabel.textColor = color
        setup()
        
        placeHolderLabel.isHidden = !self.text.isEmpty
    }
    
    // These 2 functions check whether it allows working with another delegate.
    override func responds(to aSelector: Selector!) -> Bool {
        if let delegate = externalDelegate, delegate.responds(to: aSelector) {
            return true
        }
        return super.responds(to: aSelector)
    }
    
    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        if let delegate = externalDelegate, delegate.responds(to: aSelector) {
            return delegate
        }
        return super.forwardingTarget(for: aSelector)
    }
    
    
    func configure(placeHolderText : String) {
        self.placeHolderLabel.text = placeHolderText
    }
    
    func setText(_ text : String)  {
        self.text = text
        placeHolderLabel.isHidden = true
    }
    
}

extension PlaceHolderTextView : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // İn here , hide label work should belong to self
        placeHolderLabel.isHidden = !textView.text.isEmpty
        // in here , there may be other works
        externalDelegate?.textViewDidChange?(textView)
        
    }
}

//#Preview(""){
//
//}



