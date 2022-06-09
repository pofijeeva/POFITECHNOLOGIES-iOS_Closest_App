//
//  PropertyReservationModel.swift
//  HomeStay
//
//  Created by pofiapple10 on 22/12/21.
//  Copyright © 2021 POFI TECHNOLOGIES. All rights reserved.
//

import Foundation
struct propertyDetailsModel : Codable{
    let code: Int?
    let message: String?
    let data: propertyModel?
}

struct propertyModel: Codable{
    let property_details:property_detailsModel?
    let booking_list: [BookingList]?
}

struct property_detailsModel: Codable{
    let ren_title: String?
    let ren_summary: String?
    let name: String?
    let ren_image: String?
    let booking_count: Int?
    let cancel_bk_count: Int?
    let address: String?
   // let wl_prd_id: NSNumber?
    let user_name: String?
    let user_image: String?
    let price_list: Int?
    let total_amnt: String?
    let month_amnt: String?
    let received_amnt: String?
}



struct BookingList: Codable {
    let prop_title: String?
    let pickup_location: String?
    let booking_num: String?
    let prop_id: Int?
    let check_in: String?
    let check_out: String?
    let paid_status: Int?
    let pmt_type: String?
    let host_approve_status : Int?
    let cancelled_status: Int?
    let total_amnt: String?
    let sub_total: Int?
    let pro_image: String?
    let booking_id: Int?
    
}

