use rand::Rng;
use reqwest::{get, StatusCode};
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Debug)]
struct GetNamesResponse {
    pub contents: NamesContent,
}

#[derive(Serialize, Deserialize, Debug)]
struct NamesContent {
    pub names: Vec<String>,
}


// generate random code between 0 to 10 of length  ->`length`
pub fn generate_random_code(length: i32) -> String {
    let mut original: String = "".to_owned();
    for _ in 0..length {
        let num = rand::thread_rng().gen_range(0..10);
        original.push_str(&*num.to_string());
    }
    return original;
}

// https://api.fungenerators.com/name/generate?category=indian&limit=10
// 5 calls a day
pub async fn generate_random_names() -> Result<Vec<String>, std::io::Error> {
    let mut names: Vec<String> = Vec::new();
    let response: reqwest::Response = get(" https://api.fungenerators.com/name/generate?category=indian&limit=10").await.unwrap();
    if response.status() == StatusCode::OK {
        let payload = response.json::<GetNamesResponse>().await.expect("Failed to get names");
        for name in payload.contents.names {
            names.push(name)
        }
    } else {
        names.push("Eli Jones".to_string());
        names.push("John Smith".to_string());
        names.push("Eva Doe".to_string());
        names.push("Amanda Bullocks".to_string());
        names.push("Christian Brooks".to_string());
    }
    Ok(names)
}
