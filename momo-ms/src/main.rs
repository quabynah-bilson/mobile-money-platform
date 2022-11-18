extern crate core;

use actix_web::{middleware::Logger, App, HttpServer};

// APIs
use api::{auth, common, money_transfer};

mod api;
mod db;
mod model;
mod utils;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    // setup logger
    std::env::set_var("RUST_LOG", "actix_web=debug,actix_server=info");
    std::env::set_var("RUST_BACKTRACE", "1");
    env_logger::init();

    // setup server
    HttpServer::new(|| {
        let logger = Logger::default();
        App::new()
            .wrap(logger)
            // auth
            .service(auth::login)
            .service(auth::change_pin)
            .service(auth::verify_otp)
            .service(auth::send_otp)
            .service(auth::delete_otp)
            .service(auth::register)
            // common
            .service(common::get_offers)
            .service(common::get_banks)
            .service(common::get_customer_name_by_number)
            // money transfer
            .service(money_transfer::get_airtime_reversals)
            .service(money_transfer::schedule_transaction)
            .service(money_transfer::allow_cashout)
            .service(money_transfer::send_money)
            .service(money_transfer::buy_bundle)
            .service(money_transfer::approvals)
            .service(money_transfer::get_transactions)
            .service(money_transfer::pay_bills)
            .service(money_transfer::get_statement)
            .service(money_transfer::get_wallets)
            .service(money_transfer::create_wallet)
            .service(money_transfer::delete_wallet)
    })
    .bind(("192.168.0.170", 9999))?
    .bind(("0.0.0.0", 9999))?
    .run()
    .await
}
