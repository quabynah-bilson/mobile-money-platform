use serde::Serialize;
use strum_macros::{Display, EnumString};

pub enum MomoUserStatus {
    Suspended,
    Active,
    Blocked,
    Pending,
}

#[derive(Serialize)]
pub struct MomoUser {
    pub id: String,
    pub display_name: String,
    pub phone_number: String,
    pub pin_hash: String,
    pub pin: String,
    pub last_login: String,
}