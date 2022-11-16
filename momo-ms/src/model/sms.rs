use mongodb::bson::DateTime;
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct VerificationCode {
    pub id: String,
    pub code: String,
    pub phone_number: String,
    pub timestamp: DateTime,
}
