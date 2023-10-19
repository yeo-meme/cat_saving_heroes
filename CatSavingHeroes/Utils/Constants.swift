//
//  Constants.swift
//  CatSavingHeroes
//
//  Created by yeomim kim on 2023/10/05.
//

import Foundation
import Firebase
import FirebaseFirestore

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
