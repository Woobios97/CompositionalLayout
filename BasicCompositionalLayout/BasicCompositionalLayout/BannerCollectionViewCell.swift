//
//  BannerCollectionViewCell.swift
//  BasicCompositionalLayout
//
//  Created by 김우섭 on 12/13/23.
//

import UIKit
import SnapKit
import Kingfisher

class BannerCollectionViewCell: UICollectionViewCell {
    
    static let id = "BannerCell"
    
    let titleLabel = UILabel()
    let backgroundImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setUI()
    }
    
  
    
    private func setUI() {
        // Snapkit
        self.addSubview(backgroundImage)
        self.addSubview(titleLabel)
        
        // constraints 적용
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    /*
     titleLabel과 backgroundImage를 init함수에 넣어줄 수 없다. 그래서 config함수를 만들어서 이 URL을 받아서 타이틀과 이미지를 세팅을 해준다
    */
    public func config(title: String, imageUrl: String) {
        // title
        titleLabel.text = title
        // image set
        let url = URL(string: imageUrl)
        backgroundImage.kf.setImage(with: url, placeholder: UIImage(systemName: "perseon"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
