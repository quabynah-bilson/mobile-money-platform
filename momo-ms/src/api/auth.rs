use actix_web::{post, web::Json};
use mongodb::bson::{doc, oid, to_bson, DateTime};
use serde::{Deserialize, Serialize};

use crate::api::response::ApiResponse;
use crate::db::config;
use crate::model::user::{MomoUser, MomoUserStatus};
use crate::utils::constants::{DB_NAME, USER_COL};

#[derive(Deserialize, Serialize)]
pub struct CreateUserRequest {
    phone_number: String,
    pin: String,
    display_name: String,
    network_id: String,
}

#[derive(Deserialize, Serialize)]
pub struct LoginRequest {
    phone_number: String,
    pin: String,
}

#[derive(Deserialize, Serialize)]
pub struct SendOtpRequest {
    phone_number: String,
}

#[derive(Deserialize, Serialize)]
pub struct ChangePinRequest {
    old_pin: String,
    new_pin: String,
    phone_number: String,
}

#[post("/auth/new")]
pub async fn register(request: Json<CreateUserRequest>) -> Json<ApiResponse<Option<MomoUser>>> {
    // get client
    let client = config::connect().await.unwrap();
    let collection = client.database(DB_NAME).collection(USER_COL);
    let response = collection
        .find_one(doc! {"phone_number" : request.phone_number.as_str()}, None)
        .await
        .unwrap();

    return if response.is_some() {
        Json(ApiResponse {
            message: String::from(format!(
                "An account associated with {} already exists. Please login instead",
                request.phone_number
            )),
            success: false,
            payload: None,
        })
    } else {
        let user = MomoUser {
            id: oid::ObjectId::new().to_hex(),
            display_name: request.display_name.to_string(),
            phone_number: request.phone_number.to_string(),
            pin_hash: request.pin.to_string(),
            pin: request.pin.to_string(),
            last_login: DateTime::now(),
            status: MomoUserStatus::Pending.to_string(),
        };
        collection
            .insert_one(to_bson(&user).unwrap(), None)
            .await
            .unwrap();
        Json(ApiResponse {
            message: String::from(format!("signed in as {}", user.display_name)),
            success: true,
            payload: Some(user),
        })
    };
}

#[post("/auth/login")]
pub async fn login(request: Json<LoginRequest>) -> Json<ApiResponse<String>> {
    // 1. check user info
    // 2. generate random otp and send to user's device
    // 3. return status

    return Json(ApiResponse {
        message: String::from(format!("signed in as {}", request.phone_number)),
        success: true,
        payload: String::from("This is a test login request"),
    });
}

#[post("/auth/verify-otp")]
pub async fn verify_otp(_: Json<LoginRequest>) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        message: String::from(format!("Not implemented")),
        success: false,
        payload: String::from(""),
    });
}

#[post("/auth/send-otp")]
pub async fn send_otp(_: Json<SendOtpRequest>) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        message: String::from(format!("Not implemented")),
        success: false,
        payload: String::from(""),
    });
}

#[post("/auth/change-pin")]
pub async fn change_pin(_: Json<ChangePinRequest>) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        message: String::from(format!("Not implemented")),
        success: false,
        payload: String::from(""),
    });
}
