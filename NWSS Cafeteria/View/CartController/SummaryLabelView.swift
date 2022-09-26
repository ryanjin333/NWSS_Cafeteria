//
//  SummaryLabelView.swift
//  NWSS Cafeteria
//
//  Created by Ryan Jin on 2022-09-25.
//

import UIKit

class SummaryLabelView: UIView {
    
    let summaryLabel = UILabel()
    
    let summaryAmountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        setupSummaryLabels()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    func setInfo(labelText: String, amount: String, color: UIColor) {
        summaryLabel.text = labelText
        summaryAmountLabel.text = amount
        summaryLabel.textColor = color
        summaryAmountLabel.textColor = color
    }
    
    private func setupView() {
        self.backgroundColor = .clear
    }
    
    private func setupSummaryLabels() {
        let summaryFont = UIFont.init(name: "AvenirNext-Medium", size: CartControllerVariables.subtotalAndTotalTextSize)
        summaryLabel.font = summaryFont
        summaryAmountLabel.font = summaryFont
    }
    
    private func setupConstraints() {
        self.addSubview(summaryLabel)
        self.addSubview(summaryAmountLabel)
        
        summaryLabel.addConstraint(top: self.topAnchor, left: self.leftAnchor, right: nil, bottom: self.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        summaryAmountLabel.addConstraint(top: self.topAnchor, left: nil, right: self.rightAnchor, bottom: self.bottomAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
