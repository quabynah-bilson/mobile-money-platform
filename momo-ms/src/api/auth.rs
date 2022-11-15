use actix_web::{post, web::Json};
use serde::{Deserialize, Serialize};

#[derive(Deserialize, Serialize)]
pub struct LoginRequest {
    username: String,
    password: String,
}

#[post("/auth/login")]
pub async fn login(request: Json<LoginRequest>) -> Json<String> {
    return Json(format!("Signing with username: {} & password: {}", request.username, request.password));
}