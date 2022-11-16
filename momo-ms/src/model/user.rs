use std::fmt;

use mongodb::bson::DateTime;
use serde::{Deserialize, Serialize};
use strum_macros::EnumString;

#[derive(EnumString, Copy, Clone, Debug)]
pub enum MomoUserStatus {
    Suspended,
    Active,
    Blocked,
    Pending,
}

impl fmt::Display for MomoUserStatus {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        fmt::Debug::fmt(self, f)
    }
}

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct MomoUser {
    pub id: String,
    pub display_name: String,
    pub phone_number: String,
    pub pin_hash: String,
    pub pin: String,
    pub last_login: DateTime,
    pub status: String,
}
