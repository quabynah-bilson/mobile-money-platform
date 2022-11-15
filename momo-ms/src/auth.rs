use actix_web::{App, get, HttpResponse, HttpServer, post, Responder, web};

#[post("/")]
async fn login(req_body: String) -> impl Responder {
    HttpResponse::Ok().body(req_body)
}