use actix_web::{delete, get, post, web::Json, HttpRequest};

use crate::api::response::ApiResponse;

#[post("/momo-transfer/get-airtime-reversals")]
pub async fn get_airtime_reversals(_: HttpRequest) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        success: false,
        message: String::from("not implemented yet"),
        payload: String::from(""),
    });
}

#[post("/momo-transfer/transactions/schedule")]
pub async fn schedule_transaction(_: HttpRequest) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        success: false,
        message: String::from("not implemented yet"),
        payload: String::from(""),
    });
}

#[post("/momo-transfer/transactions/allow-cashout")]
pub async fn allow_cashout(_: HttpRequest) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        success: false,
        message: String::from("not implemented yet"),
        payload: String::from(""),
    });
}

#[post("/momo-transfer/transactions/send-money")]
pub async fn send_money(_: HttpRequest) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        success: false,
        message: String::from("not implemented yet"),
        payload: String::from(""),
    });
}

#[post("/momo-transfer/transactions/buy-bundle")]
pub async fn buy_bundle(_: HttpRequest) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        success: false,
        message: String::from("not implemented yet"),
        payload: String::from(""),
    });
}

#[get("/momo-transfer/transactions/approvals/{phone_number}")]
pub async fn approvals(_: HttpRequest) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        success: false,
        message: String::from("not implemented yet"),
        payload: String::from(""),
    });
}

#[post("/momo-transfer/transactions/all")]
pub async fn get_transactions(_: HttpRequest) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        success: false,
        message: String::from("not implemented yet"),
        payload: String::from(""),
    });
}

#[post("/momo-transfer/transactions/pay-bills")]
pub async fn pay_bills(_: HttpRequest) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        success: false,
        message: String::from("not implemented yet"),
        payload: String::from(""),
    });
}

#[post("/momo-transfer/transactions/get-statement")]
pub async fn get_statement(_: HttpRequest) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        success: false,
        message: String::from("not implemented yet"),
        payload: String::from(""),
    });
}

#[get("/momo-transfer/wallets/{user_id}")]
pub async fn get_wallets(_: HttpRequest) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        success: false,
        message: String::from("not implemented yet"),
        payload: String::from(""),
    });
}

#[post("/momo-transfer/wallets/new")]
pub async fn create_wallet(_: HttpRequest) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        success: false,
        message: String::from("not implemented yet"),
        payload: String::from(""),
    });
}

#[delete("/momo-transfer/wallets/{id}")]
pub async fn delete_wallet(_: HttpRequest) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        success: false,
        message: String::from("not implemented yet"),
        payload: String::from(""),
    });
}
