use actix_web::{get, HttpRequest, web::Json};
use actix_web::web::Path;
use rand::Rng;
use tokio_stream::StreamExt;

use crate::api::response::ApiResponse;
use crate::db::config;
use crate::model::{bank::Bank, offer::Offer};
use crate::utils::constants::{BANK_COL, DB_NAME, OFFER_COL};
use crate::utils::generators;

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

#[get("/common/get-customer-name-by-number/{phone_number}")]
pub async fn get_customer_name_by_number(phone_number: Path<String>) -> Json<ApiResponse<String>> {
    let phone = phone_number.into_inner().to_string();
    let names = generators::generate_random_names().await.unwrap();
    println!("get_customer_name_by => {:?}", names);
    let customer_name = names.get(rand::thread_rng().gen_range(0..names.len())).unwrap().to_string();

    return Json(ApiResponse {
        message: String::from(format!("{} account found", phone)),
        success: true,
        payload: customer_name,
    });
}
