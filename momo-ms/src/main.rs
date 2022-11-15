use actix_web::{App, HttpServer, middleware::Logger};

// APIs
use api::auth;
use api::money_transfer;

mod api;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    // setup logger
    std::env::set_var("RUST_LOG", "debug");
    std::env::set_var("RUST_BACKTRACE", "1");
    env_logger::init();

    // setup server
    HttpServer::new(|| {
        let logger = Logger::default();
        App::new()
            .wrap(logger)
            .service(auth::login)
    })
        .bind(("0.0.0.0", 9999))?
        .run()
        .await
}
