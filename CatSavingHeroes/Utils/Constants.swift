//
//  Constants.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/05.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_CAT_PROFILE = Firestore.firestore().collection("cat_profile")
let COLLECTION_MESSAGES = Firestore.firestore().collection("messages")
let COLLECTION_CHANNELS = Firestore.firestore().collection("channels")
let COLLECTION_CHANNELS_ZIP = Firestore.firestore().collection("channels_zip")
let COLLECTION_GROUP_CHANNELS_ZIP = Firestore.firestore().collectionGroup("channels_zip")
let COLLECTION_GROUP_CHANNELS_SUB_LIKE = Firestore.firestore().collection("SUB").document("LIKEWHO")



let KEY_ZIP = "zip"
let KEY_EMAIL = "email"
let KEY_USERNAME = "name"
let KEY_PASSWORD = "password"
let KEY_UID = "uid"
let KEY_PROFILE_IMAGE_URL = "profileImageUrl"
let KEY_CAT_IMAGE_URL = "catImageUrl"
let KEY_CHANNEL_IMAGE_URL = "channelImageUrl"

let KEY_LIKE_COUNT = "likeCount"
let KEY_COMMENT_COUNT = "commentCount"
let KEY_LIKE_WHO = "likewho"

let FOLDER_PROFILE_IMAGES = "profile_images"
let FOLDER_CAT_IMAGES = "cat_images"
let FOLDER_CHANNEL_IMAGES = "channel_images"

let IMAGEURL = "gs://catsavingheores.appspot.com"


let LIKE = "like"
let UN_LIKE = "unlike"
let LIKE_STATE = "likestate"



let WEATHER_API_KEY = "159e98ac01ffc30824c47cc4c5e9e004"


//DUMMY
let products: [Product] = Bundle.main.decode("product.json")


//mongo
let CAT_ADD_API_URL = "https://cat-saving-heros.azurewebsites.net/api/cat/add"
let CAT_SELECT_API_URL = "https://cat-saving-heros.azurewebsites.net/api/cat"
let CAT_DELETE_API_URL = "https://cat-saving-heros.azurewebsites.net/api/cat/delete"

let CARE_CAT_ADD_API_URL = "https://cat-saving-heros.azurewebsites.net/api/carecat/add"
let CARE_CAT_SELECT_API_URL = "https://cat-saving-heros.azurewebsites.net/api/carecat"
let CARE_CAT_DELETE_API_URL = "https://cat-saving-heros.azurewebsites.net/api/carecat/delete"
//geo
let GEO_CARE_API_URL = "https://cat-saving-heros.azurewebsites.net/api/carecat/search/geo2"
let GEO_CAT_API_URL = "https://cat-saving-heros.azurewebsites.net/api/cat"

//mongo관리자 전체 삭제 -> 포스트맨으로하삼
let DELETE_ALL_CAT = "https://cat-saving-heros.azurewebsites.net/api/cat/delete/all/yeomeme1030@!"
let DELETE_ALL_CARE = "https://cat-saving-heros.azurewebsites.net/api/carecat/delete/all/yeomeme1030@!"

//네비게이션바 높이
let navigationBarHeight = UINavigationBar(frame: .zero).frame.size.height


let feedback = UIImpactFeedbackGenerator(style: .medium)
