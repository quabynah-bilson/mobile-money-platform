use actix_web::{App, HttpServer, middleware::Logger};

use api::auth::login;

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
            .service(login)
    })
        .bind(("0.0.0.0", 9999))?
        .run()
        .await
}
