use std::fmt;

use mongodb::bson::DateTime;
use serde::{Deserialize, Serialize};
use strum_macros::EnumString;

#[derive(EnumString, Debug, Copy, Clone)]
pub enum TransactionType {
    Transfer,
    Payment,
    Cashout,
}

impl fmt::Display for TransactionType {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        fmt::Debug::fmt(self, f)
    }
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct Transaction {
    pub id: String,
    pub transaction_type: String,
    pub sender: String,
    pub recipient: String,
    pub amount: f32,
    pub timestamp: DateTime,
    pub reference: String,
}
