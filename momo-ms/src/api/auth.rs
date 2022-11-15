use actix_web::{post, web::Json};

#[post("/auth/login")]
pub async fn login() -> Json<String> {
    return Json("Hello world!".to_string());
}