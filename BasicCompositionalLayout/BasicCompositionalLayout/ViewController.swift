//
//  ViewController.swift
//  BasicCompositionalLayout
//
//  Created by 김우섭 on 12/13/23.
//

import UIKit

class ViewController: UIViewController {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout:.init())
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
        collectionView.setCollectionViewLayout(createLayot(), animated: true)
        setDataSource()
        setSnapShot()
    }
    
    private func setUI() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    /*
    item을 정의해놨기 때문에, 해당 아이템을 받아오기 때문에, 그 안에 있는 Value까지도 같이 받아올 수가 있다.
    여기서 만약에 Config을 타게 되면 해당 아이템에 대한 Value값이 같이 들어오기 때문에 그걸 통해서 컨트롤이 가능하게 될 것이다.
    */
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            switch itemIdentifier {
                
            case .banner(let item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.id, for: indexPath) as? BannerCollectionViewCell else { return UICollectionViewCell()}
                
                cell.config(title: item.text, imageUrl: item.imageUrl)
                return cell
            default:
                return UICollectionViewCell()
            }
            
            
        })
    }
    
    /*
    snapshot의 섹션을 넣어주고, 그 섹션에다가 아이템들을 넣어줘야 된다.
    스냅샷에 같은 섹션은 하나만 넣을 수 있다. 스냅샷은 하나만 쓰기 때문이다.
    만약 똑같은 섹션을, 똑같은 레이아웃을 두 번 쓰고 싶다면 아이디를 구별해서 써야한다.
    */
    private func setSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([Section(id: "Banner")]) // snapshot에 아이템들 섹션 -> 섹션리스트가 들어갈 수 있다.
        let bannerItems = [
            Item.banner(HomeItem(text: "현대백화점", imageUrl: "https://img.hankyung.com/photo/201907/01.20162306.1.jpg")),
            Item.banner(HomeItem(text: "롯데백화점", imageUrl: "https://img1.daumcdn.net/thumb/R1280x0/?fname=http://t1.daumcdn.net/brunch/service/guest/image/FogoI_H9Gea1rJJxdN24-b8e9C8.jpg")),
            Item.banner(HomeItem(text: "신세계백화점", imageUrl: "https://cdn.designhouse.co.kr/cms/img/2021/03/M.1616723759.8261.3.jpg"))
        ]
        snapshot.appendItems(bannerItems, toSection: Section(id: "Banner"))
        
        dataSource?.apply(snapshot)
    }
    
    private func createLayot() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            
            
            return self?.createBannerSection()
        })
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }

}



// MARK: - 컬력센 cell UI 등록
// 레이아웃 구현 - 3가지
// datasource -> cellProvider
// snapshot -> datasource.apply(snapshot)
