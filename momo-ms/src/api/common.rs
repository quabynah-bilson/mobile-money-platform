use actix_web::{get, web::Json, HttpRequest};
use tokio_stream::StreamExt;

use crate::api::response::ApiResponse;
use crate::db::config;
use crate::model::{bank::Bank, offer::Offer};
use crate::utils::constants::{BANK_COL, DB_NAME, OFFER_COL};

#[get("/common/offers")]
pub async fn get_offers(_: HttpRequest) -> Json<ApiResponse<Vec<Offer>>> {
    let mut offers = Vec::new();

    // get client
    let client = config::connect().await.unwrap();
    let collection = client.database(DB_NAME).collection::<Offer>(OFFER_COL);
    let mut cursor = collection.find(None, None).await.unwrap();

    while let Some(offer) = cursor.try_next().await.unwrap() {
        offers.push(offer);
    }

    return Json(ApiResponse {
        message: String::from(format!("{} offers available", offers.len())),
        success: true,
        payload: offers,
    });
}

#[get("/common/banks")]
pub async fn get_banks(_: HttpRequest) -> Json<ApiResponse<Vec<Bank>>> {
    let mut banks = Vec::new();

    // get client
    let client = config::connect().await.unwrap();
    let collection = client.database(DB_NAME).collection::<Bank>(BANK_COL);
    let mut cursor = collection.find(None, None).await.unwrap();

    while let Some(bank) = cursor.try_next().await.unwrap() {
        banks.push(bank);
    }

    return Json(ApiResponse {
        message: String::from(format!("{} banks available", banks.len())),
        success: true,
        payload: banks,
    });
}
