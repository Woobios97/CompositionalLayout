//
//  Item.swift
//  BasicCompositionalLayout
//
//  Created by 김우섭 on 12/13/23.
//

import Foundation

// MARK: - 섹션과 아이템 정의
/*
섹션과 아이템이 있고 아이템은 3가지 타입이 있을 거고 해당 타입에 들어가는 모델은 HomeItem이다.
*/

struct Section: Hashable {
    let id: String  // 컬렉션뷰 섹션으로 들어가기 위해서는 hashable이라는 프로토콜을 채택해야한다.
}

/*
enum으로 정한 이유는 섹션에 들어갈 아이템의 여러 종류가 들어갈텐데,
다양한 분기처리를 통해서 레이아웃과 셀을 결정을 지을 것이기 때문이다.
*/
enum Item: Hashable {
    case banner(HomeItem)
    case normalCarousel(HomeItem)
    case listCarousel(HomeItem)
}

struct HomeItem: Hashable {
    let text: String
    let subTitle: String? = ""
    let imageUrl: String
}
