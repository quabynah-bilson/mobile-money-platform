use actix_web::{delete, post, web::Json};
use mongodb::bson::{DateTime, doc, Document, oid, to_bson};
use serde::{Deserialize, Serialize};

use crate::api::response::ApiResponse;
use crate::db::config;
use crate::model::sms::VerificationCode;
use crate::model::user::{MomoUser, MomoUserStatus};
use crate::utils::constants::{DB_NAME, SMS_COL, USER_COL};
use crate::utils::generators::generate_random_code;

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
pub async fn login(request: Json<LoginRequest>) -> Json<ApiResponse<Option<MomoUser>>> {
    // get client
    let client = config::connect().await.unwrap();
    let collection = client.database(DB_NAME).collection::<MomoUser>(USER_COL);
    let response = collection
        .find_one(doc! {"phone_number" : request.phone_number.as_str()}, None)
        .await
        .unwrap();

    return if response.is_some() {
        let user = response.unwrap();
        Json(ApiResponse {
            message: String::from(format!("signed in as {}", request.phone_number)),
            success: true,
            payload: Some(user),
        })
    } else {
        Json(ApiResponse {
            message: String::from(format!(
                "Login failed for {}. Try again",
                request.phone_number
            )),
            success: false,
            payload: None,
        })
    };
}

#[post("/auth/verify-otp")]
pub async fn verify_otp(request: Json<LoginRequest>) -> Json<ApiResponse<String>> {
    let client = config::connect().await.unwrap();
    let collection = client.database(DB_NAME).collection::<Document>(SMS_COL);
    let response = collection
        .find_one(doc! {"phone_number" : request.phone_number.as_str()}, None)
        .await
        .unwrap();

    return if response.is_some() {
        let code = response.unwrap().get("code").unwrap().to_string().replace("\"", "");
        let message;
        if code.eq(&*request.pin) {
            message = "Verification completed successfully".to_string();
            // delete verification
            collection
                .delete_one(
                    doc! {"phone_number" : request.phone_number.to_string()},
                    None,
                )
                .await
                .unwrap();
        } else {
            message = "Verification failed. Try again".to_string();
        }

        Json(ApiResponse {
            message,
            success: code == request.pin,
            payload: "".to_string(),
        })
    } else {
        Json(ApiResponse {
            message: format!(
                "Verification code does not exist for {}",
                request.phone_number.to_string()
            ),
            success: false,
            payload: "".to_string(),
        })
    };
}

#[post("/auth/send-otp")]
pub async fn send_otp(request: Json<SendOtpRequest>) -> Json<ApiResponse<String>> {
    let client = config::connect().await.unwrap();
    let collection = client.database(DB_NAME).collection(SMS_COL);
    let response = collection
        .find_one(doc! {"phone_number" : request.phone_number.as_str()}, None)
        .await
        .unwrap();

    return if response.is_some() {
        // let doc = from_document::<VerificationCode>(response.unwrap()).unwrap();
        // println!("found otp: {}", doc.code);

        Json(ApiResponse {
            message: String::from(format!(
                "A verification code has already been sent to {}",
                request.phone_number
            )),
            success: false,
            payload: "".to_string(),
        })
    } else {
        let code = generate_random_code(6);
        let verification_code = VerificationCode {
            id: oid::ObjectId::new().to_hex(),
            code,
            phone_number: request.phone_number.to_string(),
            timestamp: DateTime::now(),
        };
        println!("created otp: {}", verification_code.code);
        collection
            .insert_one(to_bson(&verification_code).unwrap(), None)
            .await
            .unwrap();
        Json(ApiResponse {
            message: format!(
                "Verification code has been sent to {}",
                request.phone_number
            ),
            success: true,
            payload: "".to_string(),
        })
    };
}

#[delete("/auth/delete-otp")]
pub async fn delete_otp(request: Json<SendOtpRequest>) -> Json<ApiResponse<String>> {
    let client = config::connect().await.unwrap();
    let collection = client.database(DB_NAME).collection::<Document>(SMS_COL);
    collection
        .delete_one(doc! {"phone_number" : request.phone_number.as_str()}, None)
        .await
        .unwrap();

    return Json(ApiResponse {
        message: format!("Requests deleted successfully for {}", request.phone_number),
        success: true,
        payload: "".to_string(),
    });
}

// todo => implement later
#[post("/auth/change-pin")]
pub async fn change_pin(_: Json<ChangePinRequest>) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        message: String::from(format!("Not implemented")),
        success: false,
        payload: String::from(""),
    });
}
