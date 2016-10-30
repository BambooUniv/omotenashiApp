//
//  Const.swift
//  omotenashiApp
//
//  よく使う定数をまとめたクラス
//　呼び出すときは Const.定数名

import Foundation

struct Const {
  
  /*----------------------------------------
  * API関係
  *---------------------------------------*/
  static let apiBaseUrl = "http://omotenashi.prodrb.com/api"
  static let apiSigninUrl = Const.apiBaseUrl + "/signin.php"
  static let apiSignupUrl = Const.apiBaseUrl + "/signup.php"
  
}