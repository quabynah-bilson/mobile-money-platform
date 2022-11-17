use actix_web::web::Path;
use actix_web::{delete, get, post, web::Json, HttpRequest};
use mongodb::bson::{doc, oid, to_bson, Document};
use serde::{Deserialize, Serialize};
use tokio_stream::StreamExt;

use crate::api::response::ApiResponse;
use crate::db::config;
use crate::model::wallet::Wallet;
use crate::utils::constants::{DB_NAME, WALLET_COL};

#[derive(Debug, Serialize, Deserialize)]
pub struct CreateWalletRequest {
    pub account_holder: String,
    pub phone_number: String,
    pub owner: String,
}

// todo
#[post("/momo-transfer/get-airtime-reversals")]
pub async fn get_airtime_reversals(_: HttpRequest) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        success: false,
        message: String::from("not implemented yet"),
        payload: String::from(""),
    });
}

// todo
#[post("/momo-transfer/transactions/schedule")]
pub async fn schedule_transaction(_: HttpRequest) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        success: false,
        message: String::from("not implemented yet"),
        payload: String::from(""),
    });
}

// todo
#[post("/momo-transfer/transactions/allow-cashout")]
pub async fn allow_cashout(_: HttpRequest) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        success: false,
        message: String::from("not implemented yet"),
        payload: String::from(""),
    });
}

// todo
#[post("/momo-transfer/transactions/send-money")]
pub async fn send_money(_: HttpRequest) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        success: false,
        message: String::from("not implemented yet"),
        payload: String::from(""),
    });
}

// todo
#[post("/momo-transfer/transactions/buy-bundle")]
pub async fn buy_bundle(_: HttpRequest) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        success: false,
        message: String::from("not implemented yet"),
        payload: String::from(""),
    });
}

// todo
#[get("/momo-transfer/transactions/approvals/{phone_number}")]
pub async fn approvals(_: HttpRequest) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        success: false,
        message: String::from("not implemented yet"),
        payload: String::from(""),
    });
}

// todo
#[post("/momo-transfer/transactions/all")]
pub async fn get_transactions(_: HttpRequest) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        success: false,
        message: String::from("not implemented yet"),
        payload: String::from(""),
    });
}

// todo
#[post("/momo-transfer/transactions/pay-bills")]
pub async fn pay_bills(_: HttpRequest) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        success: false,
        message: String::from("not implemented yet"),
        payload: String::from(""),
    });
}

// todo
#[post("/momo-transfer/transactions/get-statement")]
pub async fn get_statement(_: HttpRequest) -> Json<ApiResponse<String>> {
    return Json(ApiResponse {
        success: false,
        message: String::from("not implemented yet"),
        payload: String::from(""),
    });
}

#[get("/momo-transfer/wallets/{user_id}")]
pub async fn get_wallets(info: Path<String>) -> Json<ApiResponse<Vec<Wallet>>> {
    let mut wallets = Vec::new();
    let owner = info.into_inner().to_string();

    // get client
    let client = config::connect().await.unwrap();
    let collection = client.database(DB_NAME).collection::<Wallet>(WALLET_COL);
    let mut cursor = collection.find(doc! {"owner" : owner}, None).await.unwrap();

    while let Some(bank) = cursor.try_next().await.unwrap() {
        wallets.push(bank);
    }

    return Json(ApiResponse {
        message: String::from(format!("{} wallets available", wallets.len())),
        success: true,
        payload: wallets,
    });
}

#[post("/momo-transfer/wallets/new")]
pub async fn create_wallet(
    request: Json<CreateWalletRequest>,
) -> Json<ApiResponse<Option<Wallet>>> {
    // get client
    let client = config::connect().await.unwrap();
    let collection = client.database(DB_NAME).collection(WALLET_COL);
    let response = collection
        .find_one(
            doc! {"phone_number" : request.phone_number.to_string()},
            None,
        )
        .await
        .unwrap();
    if response.is_some() {
        Json(ApiResponse {
            message: String::from(format!(
                "A wallet with this {} already exists",
                request.phone_number
            )),
            success: false,
            payload: None,
        })
    } else {
        let mut wallet = Wallet {
            id: oid::ObjectId::new().to_hex(),
            account_holder: request.account_holder.to_string(),
            provider: "MTN".to_string(),
            hashed_phone: "".to_string(),
            phone_number: request.phone_number.to_string(),
            balance: 0.0,
            owner: request.owner.to_string(),
        };
        wallet.hash_phone_number().unwrap();
        collection
            .insert_one(to_bson(&wallet).unwrap(), None)
            .await
            .unwrap();
        return Json(ApiResponse {
            success: true,
            message: format!("Wallet was successfully created"),
            payload: Some(wallet),
        });
    }
}

#[delete("/momo-transfer/wallets/{id}")]
pub async fn delete_wallet(id: Path<String>) -> Json<ApiResponse<String>> {
    let id_from_path = id.into_inner().to_string();
    let client = config::connect().await.unwrap();
    let collection = client.database(DB_NAME).collection::<Document>(WALLET_COL);
    collection
        .delete_one(doc! {"id" : id_from_path}, None)
        .await
        .unwrap();

    return Json(ApiResponse {
        message: format!("Wallet deleted successfully"),
        success: true,
        payload: "".to_string(),
    });
}
