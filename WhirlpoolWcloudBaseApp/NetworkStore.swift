//
//  NetworkStore.swift
//  WhirlpoolWcloudBaseApp
//
//  Created by Vikram Naik on 08/09/17.
//  Copyright © 2017 whirlpool. All rights reserved.
//

struct NetworkStore {
    
    private struct Domains {
        static let Prod_Stg = "https://api-stg-products.mysmartappliances.com/api/v4"
    }
    
    private struct SecretKeys {
        static let ClientID = "3e883bbce67aa91160631be6c8bdf6a60b02a4ae53f02f87a767415c70548457"
        static let ClientSecret = "e6100655439103cb706d7660d7a2deaac2b910da7f08276fd21ef07fc05373af"

    }
    private  struct Routes {
        static let Api = "/api/mobile"
    }
    
    private  static let Domain = Domains.Prod_Stg
    private  static let Route = Routes.Api
//    private  static let BaseURL = Domain + Route
    private  static let BaseURL = Domain
    private  static let WPBrandName = "jennair"
    
    static var AppLogin: String {
        return BaseURL  + "/oauth/token"
    }
    
    static var BrandName: String {
        return WPBrandName
    }
    
    static var ClientId: String {
        return SecretKeys.ClientID
    }
    static var ClientSecret: String {
        return SecretKeys.ClientSecret

    }    
    static var API : String{
        
        return Routes.Api
    }
    
}
