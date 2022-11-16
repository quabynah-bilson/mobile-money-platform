use actix_web::{post, web::Json};
use serde::{Deserialize, Serialize};

#[derive(Deserialize, Serialize)]
pub struct LoginRequest {
    phone_number: String,
    pin: String,
}

#[post("/auth/login")]
pub async fn login(request: Json<LoginRequest>) -> Json<String> {
    // 1. check user info
    // 2. generate random otp and send to user's device
    // 3. return status
    return Json(format!(
        "Signing with username: {} & password: {}",
        request.phone_number, request.pin
    ));
}

#[post("/auth/verify-otp")]
pub async fn verify_otp(request: Json<LoginRequest>) -> Json<String> {
    return Json(format!(
        "Signing with username: {} & password: {}",
        request.phone_number, request.pin
    ));
}
