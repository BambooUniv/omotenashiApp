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
  
  // サインイン・サインアウト周り
  static let apiSigninUrl = Const.apiBaseUrl + "/signin.php"
  static let apiSignupUrl = Const.apiBaseUrl + "/signup.php"
  
  // お助け機能周り
  static let apiHelpCreateUrl = Const.apiBaseUrl + "/help/create.php"
  static let apiHelpSearchUrl = Const.apiBaseUrl + "/help/search.php"
  static let apiHelpsetConfirmUrl = Const.apiBaseUrl + "/help/set_confirm.php"
  static let apiHelpComfirmUrl = Const.apiBaseUrl + "/help/confirm.php"
  static let apiHelpGetDistanceUrl = Const.apiBaseUrl + "/help/get_distance.php"
  static let apiHelpSetDistanceUrl = Const.apiBaseUrl + "/help/set_distance.php"
  static let apiHelpDidOmotenashiUrl = Const.apiBaseUrl + "/help/did_omotenashi.php"
  static let apiHelpDidAcceptedUrl = Const.apiBaseUrl + "/help/is_accepted.php"
  
  
}