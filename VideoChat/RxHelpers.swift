//
//  RxHelpers.swift
//  VideoChat
//
//  Created by Mac First UPTech on 3/31/17.
//  Copyright © 2017 Mac First UPTech. All rights reserved.
//

import RxSwift

extension Observable {
  func voidValues() -> Observable<Void> {
    return map { _ in () }
  }

  func doOnResult(action: @escaping () -> Void) -> Observable {
    return `do`(
      onNext: { _ in action() },
      onError: { _ in action() }
    )
  }

  func doOnErrorOrCompleted(closure: @escaping (() -> Void)) -> Observable {
    return `do`(onError: { _ in closure() }, onCompleted: { closure() })
  }

  func logErrors(_ file: String = #file, _ function: String = #function, _ line: Int = #line) -> Observable<Element> {
    return self.do(onError: { error in
      print("======Error!Start======")
      print(error, file, function, line)
      print("======Error!End======")
    })
  }

  func logValues(_ file: String = #file, _ function: String = #function, _ line: Int = #line) -> Observable<Element> {
    return self.do(onNext: { value in
      print("======Info!Start======")
      print(value, file, function, line)
      print("======Info!End======")
    })
  }
}
