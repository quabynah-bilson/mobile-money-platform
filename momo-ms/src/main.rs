use actix_web::{middleware::Logger, App, HttpServer};

// APIs
use api::auth;

mod api;
mod db;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    // setup logger
    std::env::set_var("RUST_LOG", "actix_web=debug,actix_server=info");
    std::env::set_var("RUST_BACKTRACE", "1");
    env_logger::init();

    // setup server
    HttpServer::new(|| {
        let logger = Logger::default();
        App::new().wrap(logger).service(auth::login)
    })
    .bind(("0.0.0.0", 9999))?
    .run()
    .await
}
