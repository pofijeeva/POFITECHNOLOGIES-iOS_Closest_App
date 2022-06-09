//
//  PaymentDetailsModel.swift
//  HomeStay
//
//  Created by pofiapple10 on 24/12/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import Foundation

struct CommonSuccessModel: Codable {
    let code: Int?
    let data: [String]?
    let message: String?
}

struct PaymentDetailsModel: Codable {
    let code: Int?
    let data: PaymentChildModel?
    let message: String?
}
struct PaymentChildModel: Codable {
    let booking_payment: [BookingPaymentModel]?
    let currency_symbol: String?
    let paid_amnt: Int?
    let payable_amnt: Int?
    let total_amnt: Int?
}
struct BookingPaymentModel: Codable {
    let amount: String?
    let bookingno: String?
    let cancelled_status: Int?
    let currency_code: String?
    let currency_symbol: String?
    let dateadded: String?
    let host_id: Int?
    let name :String?
    let paid_status: Int?
    let property_id: Int?
    let ren_title: String?
    let sub_total: String?
    let transaction_id: String?
    let transaction_method: String?
    
}


//ListingPayment

struct MyListingPaymentModel: Codable {
    let code: Int?
    let message: String?
    let data: MylistingPaymentData?
}
struct MylistingPaymentData: Codable {
 
    let currency_symbol: String?
    let paid_amount: Int?
    let payable_amnt: Int?
    let total_amount: Int?
    let listing_payment: [MylistingPaymentChildModel]?
    
    
}

struct MylistingPaymentChildModel: Codable {
    let commission_type: String?
    let currency_code: String?
    let currency_symbol: String?
    let dateadded: String?
    let firstName: String?
    let payment_status:Int?
    let property_price: String?
    let property_title: String?
    let sub_total: String?
    let totalAmt:String?
    let transaction_id: String?
    let transaction_method:String?
}
//HostingPayment

struct HostpaymentModel: Codable {
    let code: Int?
    let message: String?
    let data: HostpaymentData?
}
struct HostpaymentData: Codable {
    let payout_list: [HospaymentChildModel]?
    let currency_symbol: String?
    let paid_amnt: Int?
    let payable_amnt: Int?
    let total_amount: String?
}

struct HospaymentChildModel: Codable {
    let id: Int?
    let host_id: Int?
    let prop_id: Int?
    let transaction_id: String?
    let paid_on: String?
    let comm_user_currency: String?
    let total_amnt: String?
}


//Account DetailsModel
struct AddPayoutDetailsModel: Codable {
    let code: Int?
    let message: String?
    let data: AddpayoutInfoModel?
}
struct AddpayoutInfoModel: Codable {
    let  payout_perference: PayoutRefrenceModel?
    let  accountinfo: AccountInfoDetailModel?
}
struct AccountInfoDetailModel: Codable {
    let accname: String?
    let branch_name: String?
}
struct PayoutRefrenceModel: Codable {
    let accname: String?
    let accno: String?
    let bankname: String?
    let branch_name: String?
    let ifc_code: String?
}
// PayOut Method


