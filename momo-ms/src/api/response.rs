use serde::{Deserialize, Serialize};

// API response model
#[derive(Serialize, Deserialize)]
pub struct ApiResponse<T> {
    pub success: bool,
    pub payload: T,
    pub message: String,
}
