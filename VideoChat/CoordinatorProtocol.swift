//
//  CoordinatorProtocol.swift
//  VideoChat
//
//  Created by Mac First UPTech on 3/31/17.
//  Copyright © 2017 Mac First UPTech. All rights reserved.
//

import RxSwift

protocol CoordinatorProtocol {
  var finished: Observable<Void> { get }
  func start()
  func finish()
}
