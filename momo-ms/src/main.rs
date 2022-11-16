use actix_web::{middleware::Logger, App, HttpServer};
use mongodb::bson::Document;
use tokio_stream::StreamExt;

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

    // initialize mongodb
    let client = db::config::connect().await.unwrap();

    // get a ref to the database
    let database = client.database("testdb");
    let test_collection = database.collection::<Document>("test");
    let mut cursor = test_collection.find(None, None).await.unwrap();
    while let Some(data) = cursor.try_next().await.unwrap() {
        println!("User -> {}", data);
    }
    // test_collection.find_one()

    // setup server
    HttpServer::new(|| {
        let logger = Logger::default();
        App::new().wrap(logger).service(auth::login)
    })
    .bind(("0.0.0.0", 9999))?
    .run()
    .await
}
