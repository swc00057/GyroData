//
//  CustomTableViewCell.swift
//  GyroData
//
//  Created by so on 2022/09/22.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [title,second,measureDate])
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.left.bottom.right.top.equalTo(contentView)
        }
        
        return stackView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    lazy var second: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40)
        return label
    }()
    
    lazy var measureDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
    private func addContentView() {
        stackView.addSubview(title)
        stackView.addSubview(second)
        stackView.addSubview(measureDate)
        
        measureDate.snp.makeConstraints { (make) in
            make.leading.equalTo(stackView.snp.leading).offset(10)
            make.top.equalTo(stackView.snp.top).offset(10)
            make.bottom.equalTo(title.snp.top).offset(-10)
        }
        title.snp.makeConstraints { make in
            make.bottom.equalTo(stackView.snp.bottom)
            make.leading.equalTo(measureDate)
//            make.top.equalTo(dateLabel.snp.bottom).offset(3)
//            make.bottom.equalTo(stackView.snp.bottom)
        }
        second.snp.makeConstraints { make in
//            make.top.equalTo(stackView.snp.top).offset(10)
            make.trailing.equalTo(stackView.snp.trailing).offset(1)
        }
    }
}

extension CustomTableViewCell {
    public func bind(model: CustomCellModel) {
        
        measureDate.text = model.measureDate
        second.text = model.second
        title.text = model.title
//        dataTypeLabel.text = model.dataTypeLabel
//        valueLabel.text = model.valueLabel
//        dateLabel.text = model.dateLabel
    }
}
