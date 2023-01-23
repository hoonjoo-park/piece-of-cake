//
//  ArticleListSkeletonViewModel.swift
//  piece-of-cake
//
//  Created by Hoonjoo Park on 2023/01/23.
//

import Foundation
import UIKit

struct ArticleListSkeletonViewModel {
    var numberOfSections: Int { return 1 }
    
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return 5
    }
    
    
    func cellForRowAt(_ index: Int) -> ArticleListSkeletonCell {
        return ArticleListSkeletonCell()
    }
}

