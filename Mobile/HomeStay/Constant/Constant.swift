
//  Constant.swift
//  HomeStay
//  Created by POFI TECHNOLOGIES on 16/07/18.
//  Copyright © 2018 POFI TECHNOLOGIES. All rights reserved.


import Foundation
import UIKit

// MARK:- App lang

let LANG_EN = "en"
let LANG_PH = "ph"

// MARK:- Enum constants



enum Menu {
    case HOME
    case MYPROFILE
    case INBOX
    case ADDLISTING
    case MYLISTING
    case MYBOOKINGS
    case MYPROPERTYRES
    case WISHLIST
    case REPORTORCANCEL
    case MYREVIEW
    case PAYMENTDETAILS
    case COUPONS
    case LANGUAGE
    case CURRENCY
    case CONTACTUS
    case LOGOUT
}
//enum Menu {
//    case MYPROFILE
//    case HOME
//    case INBOX
//    case STARRED
//    case UNREAD
//    case RESERVATION
//    case PENDING
//    case ARCHIEVED
//    case YOURLISTING
////    case EXPERIENCENOW
////    case EXPERIENCEHISTORY
////    case EXPERIENCELISTING
//    case YOUR_TRIPS
//    case ACCOUNT
//    case COUPON
//    case CURRENCY
//    case WISHLIST
//    case LOGOUT
////    case HOME
////    case INBOX
////    case YOUR_LISTING
////    case YOUR_TRIPS
////    case WISHLIST
////    case ACCOUNT
////    case CURRENCY
////    case LOGOUT
//}

//Singleton Class

class Singleton {
    static var sharedInstance = Singleton()
    //var selectedCategory: String!
    var selectedCategory: String! = "1"
    var listingCurrencySymb = String()
    var rentYourSpace : RentYourSpaceModel!
    var PlaceList : PlaceListModel!
    var PropertyDetail: PropertyDetails!
    var homeModel: HomeModel!
    var yourTripModel: YourTripModel!
    var inboxList: InboxListModel!
    var inboxConversationModel: InboxConversationModel!
    var PropertyListingModel: PropertyListingModel!
    var userDetailModel: UserDetailModel!
    var userInfoModel : UserInfo!
    var accInfoModel : AccountInfoModel!
    var wishListModel : WishlistModel!
    var timeTableDetails : TimeTableClass!
    var rootClass : RootClass!
    var MoreFilterModel: MoreFilter!
    var couponDetailsJson: CouponDetailsJson!
    
    // var ExperienceBase: ExperienceBase!
}

//maintaine opening time closingTime
var constant_openingTime = Int()
var constant_closingTime = Int()


// MARK:- Variable Constant
var applyFilterButtonClickedBool = Bool()

var filter_header_text = String()
var filter_list_type = String()
var filter_room_type = String()
var filter_home_type = String()
var filter_arriveDate = String()
var filter_departDate = String()
var filter_p_min =  String()
var filter_p_max = String()
var filter_guest = Int()
var add_on_amount = Int()
var Bundle_amount = Int()

var SelectTabIndex = 2


var SemiBoldFont = "SofiaProSemiBold"//"Sofia Pro Semi Bold"
var RegularFont = "SofiaProMedium"//"Sofia Pro Medium"
var BoldFont = "SofiaProBold"//Sofia Pro Bold"
var forAddPhotoDict = NSMutableDictionary()
var commonMaintainListDataDict = NSMutableDictionary()
var BUndleSelectedArray = NSMutableArray()
var BundleArray = NSMutableArray()

var BundleSelectedDictValues = NSMutableArray()
var AddonsSelectedDictValues = NSMutableArray()
var AddonsSelectedValuesDict = NSMutableArray()
var ListingAddonsDict = NSMutableDictionary()
var bundle_checkindate = String()
var bundle_checkoutdate = String()

var ListingAddonsArray = NSMutableArray()

var GlobalLanguageDictionary = NSMutableDictionary()

var isFromHomePage_Search = Bool()
var isFromRentYourSpace_search = Bool()
var listingIndex = Int()
var isFromPaymentSuccess = Bool()
var isFromBookingDetails = Bool()
var SelectedBookingNum = NSMutableArray()
var SharedsaveInstance = ExperienceListingBundleViewController()
var sharedInstanceExperience = ExperienceBaseViewController()
var sharedInstanceListing = ListingViewControllersBundle()
let addressKey = "address"
var UserID = String()
var UserEmail = String()
var BaseSelectedIndex = 0
 // let AppColor = UIColor(red: 3/255.0, green: 32/255.0, blue: 84/255.0, alpha: 1.0)
var AppColor = UIColor(red: 255/255.0, green: 56/255.0, blue: 36/255.0, alpha: 1.0)

//UIColor(red: 96/255.0, green: 25/255.0, blue: 107/255.0, alpha: 1.0)

let AppSecondColor = UIColor(red: 255/255.0, green: 194/255.0, blue: 31/255.0, alpha: 1.0)
//let AppSecondColor = UIColor(red: 255/255.0, green: 56/255.0, blue: 36/255.0, alpha: 1.0)

let AppSecondColor1 = UIColor(red: 246/255.0, green: 196/255.0, blue: 74/255.0, alpha: 1.0)

//let AppSecondColor1 = UIColor(red: 238/255.0, green: 198/255.0, blue: 96/255.0, alpha: 1.0)

let ForestGreen = UIColor(red: 34/255.0, green: 139/255.0, blue: 34/255.0, alpha: 1.0)

let limeYellow = UIColor(red: 255/255.0, green: 187/255.0, blue: 52/255.0, alpha: 1.0)
let BorderColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0)
let BorderColor1 = UIColor(red: 52/255.0, green: 79/255.0, blue: 141/255.0, alpha: 1.0)


//UIColor(red: 248/255.0, green: 188/255.0, blue: 5/255.0, alpha: 1.0) rgb(34,139,34)

var googleClientID:String = "1062492361912-oacvujiqbrdh1lbf8a58jugs2735hq08.apps.googleusercontent.com"
//"1074572941294-22ksmonfg6jll40u3mhoc9sebfo5u33v.apps.googleusercontent.com"
//"152099665099-mahq241a8ceed27te1jsn8041k0kqsmq.apps.googleusercontent.com" com.googleusercontent.apps.152099665099-mahq241a8ceed27te1jsn8041k0kqsmq

//let MenuArray = ["Inbox","Your Listing","Your Trips","Account","Currency","Wishlist","Logout"]
//let MenuIconArray = ["Inbox","yourlisting","yourtrips","Account","currency","wishlist","logout"]


//let MenuArray = ["Inbox","Your Listing","Your Trips","Account","Currency","Wishlist","Language","Logout"]
let flightMenuArray = ["Home","Inbox","My Trips","Account","Currency","Cancellation","Language","Logout"]
let flightMenuIconArray = ["yourlisting","Inbox","yourtrips","Account","currency","wishlist","language","logout"]
//let MenuIconArray = ["mail_menu","yourlisting","yourtrips","Account","currency","wishlist","language","logout"]



//let MenuArray = ["Inbox","Your Listing","Your Trips","Account","Currency","Wishlist","Logout"]
let MenuArray = ["Home","Your Messages","Property Listing","Trip History","Your Wish List","Account Section","Credit's & Coupon","Manage Currency", "Logout"]
let MenuIconArray = ["home","mail_menu","yourlisting","yourtrips","wishlist","voucher (3)","Account","currency","logout"]
let DropMenuIconArray = ["home","mail_menu","emptystar","unread","reservation-1","clock (3)","download-button","yourlisting","yourtrips","wishlist","voucher (3)","Account","currency","logout"]

// MARK:- User Defaults
let login_session = UserDefaults.standard
let app_session = UserDefaults.standard
var usersession = UserDefaults.standard
let lanuguage_selection = UserDefaults.standard
var resultVal = UserDefaults.standard
var checkDates = UserDefaults.standard
var LocationName = ""
var checkinDate = ""
var CheckOutDate = ""
// MARK:- HTTP request url constants

// HomeStay Base urlhttps
//let HDDN_BASEURL = "http://flight.mytaxisoft.com/json/"
//let HDDN_BASEURL = "https://homestaydnn.mytaxisoft.com/json/"
//let HDDN_BASEURL = "http://testhomestaydnn.mytaxisoft.com/json/"
//Already used one
//let HDDN_BASEURL = "http://pham.mytaxisoft.com/json/"

//Working URL
//let HDDN_BASEURL = "https://demo.homestaydnn.com/json/" "https://beta.closest.ai/cms/terms-of-use"

let BASEURL = "https://beta.closest.ai/cms/"
let HDDN_BASEURL = "https://beta.closest.ai/api/v_1_1/"//"https://beta.closest.ai/api/v_1_1/"//"https://beta.closest.ai/api/v_1_0/"//"https://closest.trymydemo.com/api/v_1_1/" //"https://beta.closest.ai/api/v_1_0/"
//"http://beta.closest.ai/" "https://closest.trymydemo.com/api/v_1_0/"//

// "https://www.bensonboat.pofirentals.in/json/"
// "https://www.bensonboat.pofirentals.in/json/"
// "https://demorental.shopurgrocery.in/api/v_1_0/"

// "https://www.bensonboat.pofirentals.in/json/"

//"https://homestaydnn.trymydemo.in/json/"
//"http://hs-qa.pofi5.in/json/"
//"https://staginghomestaydnn4.mytaxisoft.com/json/"
//"https://stage1appnewfeaturehomestay.mytaxisoft.com/json/"
//"https://workingdemohomestay.mytaxisoft.com/json/"
//"https://stage1demohomestay.mytaxisoft.com/json/"

// New Features

let DISPUTE_STATUS_CHANGE = HDDN_BASEURL + "mobile_dispute_status_change"
//cancel request accept
let HOST_ACCEPT_CANCE_REQUEST = HDDN_BASEURL + "host_accept_cancel_request"
//cancel request reject
let HOST_REJECT_CANCE_REQUEST = HDDN_BASEURL + "host_reject_cancel_request"
let MOBILE_INBOX_STARRED_MESSGAE = HDDN_BASEURL + "mobile_inbox_starred_message"
let MOBILE_INBOX_UNREAD_MESSGAE = HDDN_BASEURL + "mobile_inbox_unread_message"
let MOBILE_INBOX_RESERVATION_MESSGAE = HDDN_BASEURL + "mobile_inbox_reservation_message"
let MOBILE_INBOX_PENDINGREQ_MESSGAE = HDDN_BASEURL + "mobile_inbox_pending_req_message"
let MOBILE_INBOX_ARCHIVED_MESSGAE = HDDN_BASEURL + "mobile_inbox_archived_message"
let MOBILE_INBOX_STAR_STATUS = HDDN_BASEURL + "mobile_inbox_star_status"
let MOBILE_INBOX_ARCHIVE_STATUS = HDDN_BASEURL + "mobile_inbox_archive_status"
let COUPON_DETAILS_API = HDDN_BASEURL + "mobile_coupon_details"
let WALLET_AVAILABLE_API = HDDN_BASEURL + "mobile_overall_wallet"
let PROPERTY_RESERVATION = HDDN_BASEURL + "my-property-reservation"
let PROPERTY_DETAILS = HDDN_BASEURL + "my-property-bookings"
let HOST_CANCEL_BOOKING = HDDN_BASEURL + "mobile_host_cancel_booking"
let APPROVE_REJECT_BOOKING = HDDN_BASEURL + "host_approve_reject_booking"
let PROPERTY_CANCEL_API = HDDN_BASEURL + "property_cancel_view"
let BOOKINGPAYMENT = HDDN_BASEURL + "booking_payment"
let LISTING_PAYMENT = HDDN_BASEURL  + "listing_payment"
let HOST_PAYOUT = HDDN_BASEURL  + "host_payout"
let GUESTCANCEL = HDDN_BASEURL + "guest_cancel_booking"



let COPON_APPLY_API = HDDN_BASEURL + "apply-coupon"
let COPON_REJECT_API = HDDN_BASEURL + "mobile_coupon_code_reject"
let WALLET_APPLY_API = HDDN_BASEURL + "mobile_wallet_apply"
let AgentCodeApply = HDDN_BASEURL + "mobile_agent_code_apply"
let EXPERIENCECANCEL = HDDN_BASEURL + "add_exp_cancellation"
let EXPERIENCEVIEWCANCELLATION = HDDN_BASEURL + "view_your_exp_cancellation"
let EXPERIENCEINVOICE = HDDN_BASEURL + "experience_invoice"
let EXPERIENCEHOSTCANCEL = HDDN_BASEURL + "experience_host_cancel_booking"
let ExPERIENCEMOBILECANCELVIEW = HDDN_BASEURL + "mobile_experience_cancel_view"
let LOCATIONLIST = HDDN_BASEURL + "location_list"
let CURRENCYLIST = HDDN_BASEURL + "currency_list"
let LANGUAGELIST = HDDN_BASEURL + "language_list"
let TERMS = BASEURL + "terms-of-use"
let PRIVACYPOLICY = BASEURL + "privacy-policy"


//Testing URL
//let HDDN_BASEURL = "https://stage1demohomestay.mytaxisoft.com/json/"

////Dev URL
//let HDDN_BASEURL = "https://demo1.homestaydnn.com/json/"

// Discover url
let DISCOVER_API = HDDN_BASEURL+"discover"

// Login API
let REQ_LOGIN = HDDN_BASEURL+"mobile_login"

// Sign API
let REQ_SIGNUP = HDDN_BASEURL+"mobile_signup"

// Forget Password
let REQ_FORGET_PASSWORD = HDDN_BASEURL+"mobile_forgotpsd"

// Logout
let REQ_LOGOUT = HDDN_BASEURL+"mobile_logout"

// Version Update
let REQ_VERSION_UPDATE =  HDDN_BASEURL+"version_update"

// Property HomePage
let REQ_HOMEPAGE =  HDDN_BASEURL+"property_home"

// Property Detail page API
let REQ_PROPERTY_DETAIL_PAGE = HDDN_BASEURL+"rental-list"

// Rental details
let REQ_RENTAL_DETAIL =  HDDN_BASEURL+"rental_detail"

//invoice
let INVOICE_API = HDDN_BASEURL + "invoice"
let PRICING_API = HDDN_BASEURL + "mobile_add_property_step3"

// Request to host
let REQ_HOST_REQUEST = HDDN_BASEURL+"mobile_host_request"

// Your trips
let REQ_YOUR_TRIPS = HDDN_BASEURL+"mobile_your_trips"

// Listing API
let REQ_LISTING_API = HDDN_BASEURL+"mobile_listview"

// Get Currenct Symbol
let REQ_CURRENCY_SYMBOL = HDDN_BASEURL+"mobile_get_currency_symbol"

// Rent Your Space
let REQ_RENT_YOUR_SPACE = HDDN_BASEURL+"list_values"

// Rent Your Space Step 1
let REQ_RENT_YOUR_SPACE_STEP1 =  HDDN_BASEURL+"mobile_add_property_step1"

// Created property status
let CREATED_PROPERTY_STATUS = HDDN_BASEURL + "created_property_status"

// Update Calender status
let SAVE_CALENDER_LISTING = HDDN_BASEURL + "mobile_add_property_step2"

// Update Pricing Details
let SAVE_PRICE_LISTING = HDDN_BASEURL + "mobile_add_property_step3"

// Update Overview Listing
let SAVE_OVERVIEW_LISTING = HDDN_BASEURL + "mobile_add_property_step4"

// Update Photo Listing
let SAVE_PHOTO_LISTING = HDDN_BASEURL + "mobile_add_property_step5"

// Update Amenities Listing
let SAVE_AMINITIES_LISTING = HDDN_BASEURL + "mobile_add_property_step6"

// Update ListingInfo
let SAVE_LISTINGINFO_LISTING = HDDN_BASEURL + "mobile_add_property_step7"

// Update Address Info
let SAVE_ADDRESS_LISTING = HDDN_BASEURL + "mobile_add_property_step8"

// Update Cancellation Policy
let SAVE_CANCELLATION_LISTING = HDDN_BASEURL + "mobile_add_property_step9"

// Delete Photo Listing
let DELETE_PHOTO_LISTING = HDDN_BASEURL + "property_image_delete"
let DELETE_PHOTO_EXPERIENCE  = HDDN_BASEURL + "delete_experience_photos"

// Show ListingInfo
let SHOW_PROPERTY_LISTING = HDDN_BASEURL + "mobile_listview"

// Show Property List
let SHOW_PLACE_LISTING = HDDN_BASEURL + "rental-list"

// Show Property Detail
let SHOW_PROPERTY_DETAIL = HDDN_BASEURL + "rental_detail"

//Update Mobile currency
let UPDATE_MOBILE_CURRENCY = HDDN_BASEURL + "mobile_get_currency_symbol"

// Pay by Stripe
let PAY_BY_STRIPE = HDDN_BASEURL + "booking_pay_stripe"

//let PAY_BY_STRIPE = HDDN_BASEURL + "trip_pay_by_stripe"

// Pay by Paypal
let PAY_BY_PAYPAL = HDDN_BASEURL + "booking_pay_paypal"
let APPLE_PAY = HDDN_BASEURL + "booking_pay_applepay"

//let PAY_BY_PAYPAL = HDDN_BASEURL + "trip_paypal_success"

// Pay by PayMaya
let PAY_BY_PAYMAYA = HDDN_BASEURL + "trip_paymaya_success"

// InboxAPI
let INBOX_API = HDDN_BASEURL + "inbox"

// Inbox History
let INBOX_HISTORY = HDDN_BASEURL + "inbox_conversation"

// Send message
let SEND_MESSAGE = HDDN_BASEURL + "mobile_send_message"

// Delete message
let DELETE_MESSAGE = HDDN_BASEURL + "mobile_delete_message"


// Host Decline API
let HOST_DECLINE = HDDN_BASEURL + "mobile_host_decline"

// HostApprove API
let HOST_ACCEPT = HDDN_BASEURL + "mobile_host_approval"

// Listing Pay by Stripe
let LISTING_PAY_BY_STRIPE = HDDN_BASEURL + "listing_pay_by_stripe"

// Listing Pay by Paypal
let LISTING_PAY_BY_PAYPAL = HDDN_BASEURL + "listing_pay_by_paypal"

// Listing Pay by PayMaya
let LISTING_PAY_BY_PAYMAYA = HDDN_BASEURL + "list_paymaya_success"

// Add to WishList
let ADD_WISHLIST = HDDN_BASEURL + "add_wishlist_property"

// Remove from Wishlist
let REMOVE_WISHLIST = HDDN_BASEURL + "remove_wishlist_property"

// Get Account Details
let GET_USER_ACCOUNT_DETAILS = HDDN_BASEURL + "mobile_user_account_details"

// Get WishList API
let GET_WISHLIST_API = HDDN_BASEURL + "mobile_wishlistview"

//User Info API
let USER_INFO_API = HDDN_BASEURL + "mobile_user_details"

//Update User Account API
let USER_ACC_UPDATE_API = HDDN_BASEURL + "mobile_updateaccount"

//Update Password API
let USER_PASSWD_UPDATE_API = HDDN_BASEURL + "rest_password"

//Create Wishlist API
let CREATE_WISHLIST_API = HDDN_BASEURL + "create_wishlist"

//Cancellation API
let CANCELLATION_API = HDDN_BASEURL + "add_property_cancel"

//Add Review API
let ADD_REVIEW_API = HDDN_BASEURL + "add_review"

//Add Dispute API
let DISPUTE_API = HDDN_BASEURL + "add_dispute"

//Pay by CreditCard API
let PAY_BY_CREDITCARD_API = HDDN_BASEURL + "trip_pay_by_credit_card"

//Mobile Host Instant Pay API
let HOST_REQ_INSTANT_PAY_API = HDDN_BASEURL + "save_booking"
let HOURLY_INSTANT_PAY = HDDN_BASEURL + "save_hourly_booking"

//Mobile User Update Profile
let UPDATE_USER_PROF_API = HDDN_BASEURL + "mobile_updateprofile"

// Mobile Trust and Verification
let TRUST_VERIFY_API =  HDDN_BASEURL + "trust_verification"

// Trust and Verification
let TRUST_VERIFY_OTP_API =  HDDN_BASEURL + "trust_verification_validator"

//Hotel Your Review
let HOTEL_YOUR_REVIEW = HDDN_BASEURL + "your_review"

//Update User Account API
let UPDATE_USER_DETAILS_API = HDDN_BASEURL + "mobile_updateprofile"

///////////////////////////////   Restaurant APIs   ///////////////////////////////////////////

let RESTURANT_SEARCH = HDDN_BASEURL + "restaurant_search"
let RESTURANT_DETAIL_SEARCH = HDDN_BASEURL + "restaurant_rental_detail"
let REASTURANT_BOOK_REQUEST = HDDN_BASEURL + "restaurant_guest_request"
let REASTURANT_GET_PRICE_DETAIL = HDDN_BASEURL + "get_price_detail"
let REASTURANT_TABLE_DETAILS = HDDN_BASEURL  + "get_table_detail"
let REASTURANT_LIST_VALUES = HDDN_BASEURL + "restaurant_list_values"
let REATURANT_YOUR_TRIPS = HDDN_BASEURL + "restaurant_trips_details"
let REASTURANT_INBOX_CONVERSATION = HDDN_BASEURL + "rest_inbox_conversation"
let REASTURANT_LISTVIEW = HDDN_BASEURL + "mobile_restaurant_listview"
let REASTURANT_PAY_STRIPE = HDDN_BASEURL + "restaurant_trip_pay_by_stripe"
let REASTURANT_HOST_PAY_STRIPE = HDDN_BASEURL + "restaurant_hosting_pay_by_stripe"
let REASTURANT_SEND_MESSAGE = HDDN_BASEURL + "restaurant_booking_message"
let REASTURANT_BOOKING_CONFIRM = HDDN_BASEURL + "restaurant_booking_confirm"
let REASTURANT_CREDITCARD_PAYMENT = HDDN_BASEURL + "restaurant_trip_pay_by_credit_card"
let REASTURANT_UPDATE_PRICE = HDDN_BASEURL + "mobile_add_restaurant_step3"
let REASTURANT_CANCEL_REQUEST = HDDN_BASEURL + "restaurant_booking_cancellation"
let REASTURANT_DISPUTE_REQUEST = HDDN_BASEURL + "restaurant_booking_dispute"
let REASTURANT_MESSAGE_REQUEST = HDDN_BASEURL + "restaurant_booking_message"
let REASTURANT_RATING_REQUEST = HDDN_BASEURL + "add_restaurant_review"
let REASTURANT_CREATE_STATUS = HDDN_BASEURL + "created_restaurant_status"
let REASTURANT_LISTING_STEP1 = HDDN_BASEURL + "mobile_add_restaurant_step1"
let REASTURANT_LISTING_STEP2 = HDDN_BASEURL + "mobile_add_restaurant_step2"
let REASTURANT_LISTING_STEP4 = HDDN_BASEURL + "mobile_add_restaurant_step4"
let REASTURANT_LISTING_STEP5 = HDDN_BASEURL + "mobile_add_restaurant_step5"
let REASTURANT_LISTING_TABLENAME_ADD = HDDN_BASEURL + "add_restaurant_table_timing"
let REASTURANT_LISTING_STEP12 = HDDN_BASEURL + "mobile_add_restaurant_step12"
let REASTURANT_LISTING_STEP9 = HDDN_BASEURL + "mobile_add_restaurant_step9"
let REASTURANT_LISTING_STEP10 = HDDN_BASEURL + "mobile_add_restaurant_step10"
let REASTURANT_LISTING_STEP11 = HDDN_BASEURL + "mobile_add_restaurant_step11"
let REASTURANT_ADD_DISH = HDDN_BASEURL + "add_new_menu_item"
let REASTURANT_DELETE_ITEM = HDDN_BASEURL + "delete_menu_item"
let REASTURANT_MENU_ITEM = HDDN_BASEURL + "delete_menu"
let REASTURANT_UPDATE_MENU = HDDN_BASEURL + "update_menu_item"
let REASTURANT_TABLE_TIMING = HDDN_BASEURL + "mobile_add_restaurant_step6"
let REASTURANT_WISHLIST_CREASTE = HDDN_BASEURL + "create_restaurant_wishlist"
let REASTURANT_ADD_WISHLIST = HDDN_BASEURL + "add_restaurant_to_wishlist"
let REASTURANT_REMOVE_WISHLIST = HDDN_BASEURL + "remove_restaurant_from_wishlist"
let REASTURANT_ADD_TABLE_TIMING = HDDN_BASEURL + "add_restaurant_table_timing"
let REASTURANT_UPDATE_TABLE_TIMING = HDDN_BASEURL + "update_restaurant_table_timing"
let REASTURANT_DELETE_TABLE_TIMING = HDDN_BASEURL + "delete_restaurant_table_timing"
let REASTURANT_TIMINGS_FOR_CALENDER = HDDN_BASEURL + "get_timings_for_calendar"
let REASTURANT_YOUR_REVIEW = HDDN_BASEURL + "your_restaurant_review"
let DAY_CALC_API = HDDN_BASEURL + "calculate_booking_price"//"ajaxdateCalculate"
let HOUR_CALC_API = HDDN_BASEURL + "calculate_hourly_booking_price"

let EXPERIENCEPAYBYSTRIPE = HDDN_BASEURL + "experience_guest_pay_stripe"
let EXPERIENCEHOSTPAYBYSTRIPE = HDDN_BASEURL + "experience_host_pay_stripe"
let EXPERIENCEEDITTIMESHEET = HDDN_BASEURL + "edit_experience_timesheet"
let EXPERIENCEDELETETIMESHEET = HDDN_BASEURL + "delete_experience_timesheet"
let EXPERIENCETIMESTATUSCHANGE = HDDN_BASEURL + "change_exp_timesheet_status"
let EXPERIENCEPAYBYPAYPALGUEST = HDDN_BASEURL + "experience_guest_pay_paypal"
let EXPERIENCEPAYBYPAYPALHOST = HDDN_BASEURL + "experience_host_pay_paypal"
let EXPERIENCEPAYBYCREDITCARD = HDDN_BASEURL + "experience_guest_pay_creditcard"
let EXPERIENCENOW = HDDN_BASEURL + "explore_experience"
let EXPERIENCESENDMESSAGE = HDDN_BASEURL + "send_exp_message"
let DISPUTEVIEW = HDDN_BASEURL + "your_dispute"
let EXPERIENCEADDWISHLIST = HDDN_BASEURL + "add_wishlist_experience"
let EXPERIENCEREMOVEWISHLIST = HDDN_BASEURL + "remove_wishlist_experience"
let EMAILVERIFICATION = HDDN_BASEURL + "email_verfication"
let CHECKEMAILVERIFICATION = HDDN_BASEURL + "checkemail_verfiy"


//maintain Flight filterData
var ifFlightFilterApplied = Bool()
var flightFliterData = NSMutableDictionary()
var flightFilterResultsData = NSMutableDictionary()
var flightFilterResultsArray = NSMutableArray()
var Flight_journey_type = String()
var flight_adults_count = String()
var flight_children_count = String()
var flight_infant_count = String()
var flight_type_class = String()


var checkedIDArray = NSMutableArray()
var AddonscheckedIDArray = NSMutableArray()

var accountSelectedCountry = String()
var seasonalDatesArray = NSMutableArray()
var ExperiencySelectedCurrency = String()

// Flight API's
let FLIGHT_HOMEPAGE =  HDDN_BASEURL+"flights_home"
let FLIGHT_GET_AIRPORT_LISTS =  HDDN_BASEURL+"get_airport_lists"
let FLIGHT_SEARCH =  HDDN_BASEURL+"search_flights"
let FLIGHT_ENQUIRY = HDDN_BASEURL+"flight_enquiry"



let storyBoardHome = UIStoryboard(name: "Main", bundle: nil)
let storyBoardExperience = UIStoryboard(name: "Experience", bundle: nil)
// Review API
//#define ReviewedDataApi (k_domainName @"your_review")
//#define DisputedDataApi (k_domainName @"your_dispute")
//
//Trip payment api
//#define TripCreditCardPaymentApi (k_domainName @"trip_pay_by_credit_card")
//
//#define TripStripPaymentApi (k_domainName @"trip_pay_by_stripe")
//
//#define TripPaypalPaymentApi (k_domainName @"trip_pay_by_paypal")
////
//
//
//#define StripePaymentApi (k_domainName @"listing_pay_by_stripe")
////http://demo1.laravelecommerce.com/json/listing_pay_by_stripe
//
//#define PaypalPaymentApi (k_domainName @"listing_pay_by_paypal")
////http://demo1.laravelecommerce.com/json/listing_pay_by_paypal
//
//#define InboxConversationApi (k_domainName @"inbox_conversation")
//
////http://demo1.laravelecommerce.com/json/inbox_conversation
//
//#define HostDeclineApi (k_domainName @"mobile_host_decline")
//
//#define HostApprovalApi (k_domainName @"mobile_host_approval")
//
//
//
////"http://demo1.laravelecommerce.com/json/mobile_host_decline",
//
//#define SendMessageApi (k_domainName @"mobile_send_message")
//
////"http://demo1.laravelecommerce.com/json/mobile_send_message",
//
//#define UserAccountDetailsApi (k_domainName @"mobile_user_account_details")
//
////http://demo1.laravelecommerce.com/json/mobile_user_account_details
//
//#define UpdateUserAccountDetailsApi (k_domainName @"mobile_updateaccount")
//
////http://demo1.laravelecommerce.com/json/mobile_updateaccount
//
//#define ResetUserPasswordApi (k_domainName @"rest_password")
//
////http://demo1.laravelecommerce.com/rest_password
//#define InboxApi (k_domainName @"inbox")
//
//#define GetUserDetails (k_domainName @"mobile_user_details")
//
//#define MoreAboutHost (k_domainName @"more_abt_host")
//
//
//#define UpdateUserDetails (k_domainName @"mobile_updateprofile")
//
//#define GetCurrency (k_domainName @"mobile_get_currency_symbol")
////http:demo1.laravelcommerce.com/json/mobile_get_currency_symbol
//
//#define RentYourspacelistApi (k_domainName @"list_values")
//
//#define AddPropertyApi (k_domainName @"mobile_add_property_step1")
//
//#define saveCalenderApi (k_domainName @"mobile_add_property_step2")
//
//#define Step3Api (k_domainName @"mobile_add_property_step3")
//
//#define GetCurrencyApi (k_domainName @"mobile_get_currency_symbol")
//
//#define saveStep4Api (k_domainName @"mobile_add_property_step4")
//
//#define SaveStep5Api (k_domainName @"mobile_add_property_step5")
//
//#define Step6Api (k_domainName @"mobile_add_property_step6")
//
//#define Step7Api (k_domainName @"mobile_add_property_step7")
//
//#define Step8Api (k_domainName @"mobile_add_property_step8")
//
//#define Step9Api (k_domainName @"mobile_add_property_step9")
//
//#define WishListApi (k_domainName @"mobile_wishlistview")
//
////Get created property value
////http://demo1.laravelecommerce.com/json/created_property_status
//
//#define CreatedPropertyApi (k_domainName @"created_property_status")
//
//#define CreateWishListApi (k_domainName @"create_wishlist")
//
//#define AddWishListApi (k_domainName @"add_wishlist_property")
//
//#define AddReviewApi (k_domainName @"add_review")
//
//#define AddDisputeApi (k_domainName @"add_dispute")
//
//#define removeWishListApi (k_domainName @"remove_wishlist_property")
//
//
//#define PayPalApi (k_domainName @"pay_by_paypal")
//
//#define ListPayPalApi (k_domainName @"list_paypal_success")
//
//#define TripPayPalApi (k_domainName @"trip_paypal_success")



// MARK: Experience Modules
let ExperienceBaseDetails =  HDDN_BASEURL + "manage_experience"
let ExperienceAddNotes = HDDN_BASEURL + "add_notes_to_guest"
let ExperienceAddBio = HDDN_BASEURL + "add_host_details"
let ExperienceRequirements = HDDN_BASEURL + "add_guest_requirements"
let ExperienceGroupSize = HDDN_BASEURL + "add_group_size"
let ExperienceAddPrice = HDDN_BASEURL + "add_price"
let ExperienceAddKit = HDDN_BASEURL + "add_kit_details"
let ExperienceAddSchedule = HDDN_BASEURL +  "add_experience_schedule"
let ExperienceUpdateKit = HDDN_BASEURL +  "update_kit_details"
let ExperienceDeleteKit = HDDN_BASEURL +  "delete_kit_details"
let AddExperienceBacic = HDDN_BASEURL + "add_experience_basic"
let ExploreExperience = HDDN_BASEURL + "explore_experience"
let AddExperienceLanguage = HDDN_BASEURL + "add_experience_language"
let AddExperienceOrganisation = HDDN_BASEURL +  "add_organization_dtls"
let AddExperienceTitle = HDDN_BASEURL + "add_experience_title"
let AddExperienceTagLine = HDDN_BASEURL + "add_experience_tagline"
let AddExperienceWhatYouWillDo = HDDN_BASEURL + "add_what_you_will_do"
let AddExperienceWhereYouWillBe = HDDN_BASEURL + "add_where_you_will_be"
let ExperienceChooseTime = HDDN_BASEURL + "experience_booking_enquiry"
let ExperienceConfirm = HDDN_BASEURL + "experience_booking_confirm"
let ExperienceHistory = HDDN_BASEURL + "experience_history"
let AddExperienceLocationDetails = HDDN_BASEURL + "add_location_details"
let DeleteScheduledExperience = HDDN_BASEURL + "delete_experience_schedule"
let ChangeScheduledExperienceStatus = HDDN_BASEURL + "change_exp_date_status"
let AddExprencePhotos = HDDN_BASEURL + "add_experience_photos"
let AddExperienceTimeSheet = HDDN_BASEURL + "add_experience_timesheet"
let viewExperienceTimesheet = HDDN_BASEURL + "view_experience_timesheet"
let AddExperienceCancelPolicy = HDDN_BASEURL + "add_experience_cancel_policy"


 let COUPONS = HDDN_BASEURL + "coupons"
let MYBOOKINGS = HDDN_BASEURL + "my_booking"
let INVOICE = HDDN_BASEURL + "invoice"
let WISHLISTVIEW = HDDN_BASEURL + "mobile_wishlistview"
let INBOX = HDDN_BASEURL + "inbox"
let INBOXCONVERSATION = HDDN_BASEURL + "inbox_conversation"
let REVIEWDETAILS = HDDN_BASEURL + "review_detail"
let DISPUTEDETAILS = HDDN_BASEURL + "dispute_detail"
let CANCELDETAILS = HDDN_BASEURL + "cancel_about_detail"
let CONTACTUS = HDDN_BASEURL + "contact-us"



var dictOfExperience = NSDictionary()
var arrayOfdictBasics = NSMutableArray()
var currentExpId = ""
var arrayOfCurrency = NSMutableArray()
var TimingsArray = NSArray()
var imageArrayExperience = NSMutableArray()
var isFromManage = false
var arrayOfBoolValues = NSMutableArray()
var arrayOfResult = NSArray()
var arrayOfHeadings = NSMutableArray()
var SelectedCurrency = String()
var accessToken = String()


struct HomeStayConstants {
    static let kEmptySpace = " "
}
