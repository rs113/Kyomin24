//
//  MzadiAppproduct.swift
//  Mzadi
//
//  Created by Emizentech on 01/10/21.
//


import Foundation

public struct MzadiProducts {
    
    public static let TenDollarMonthlySub = "Mzadi_One_Month_User_Plan"
    
    public static let ThirtyDollarMonthlySub = "Mzadi_One_Month_Complany_Plan"

    public static let ThreeHundredDollarMonthlySub = "Maadi_OneYear_Company_Plan"
    
    public static let store = IAPManager(productIDs: MzadiProducts.productIDs)
    public static var productIDs: Set<ProductID> = [TenDollarMonthlySub,ThirtyDollarMonthlySub,ThreeHundredDollarMonthlySub]
    
    
}

public func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
    return productIdentifier.components(separatedBy: ".").last
}




