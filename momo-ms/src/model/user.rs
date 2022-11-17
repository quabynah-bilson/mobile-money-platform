use std::fmt;
use std::io::ErrorKind;

use argon2::Config;
use mongodb::bson::DateTime;
use rand::Rng;
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
    #[serde(skip_serializing, skip_deserializing)]
    pub pin_hash: String,
    pub pin: String,
    pub last_login: DateTime,
    pub status: String,
}

impl MomoUser {
    pub fn hash_pin(&mut self) -> Result<(), std::io::Error> {
        let salt: [u8; 32] = rand::thread_rng().gen();
        let config = Config::default();

        self.pin = argon2::hash_encoded(self.pin.as_bytes(), &salt, &config).map_err(|e| {
            std::io::Error::new(ErrorKind::InvalidData, format!("Failed to hash pin: {}", e))
        })?;

        Ok(())
    }

    pub fn verify_pin(&self, pin: &[u8]) -> Result<bool, std::io::Error> {
        argon2::verify_encoded(&self.pin, pin).map_err(|e| {
            std::io::Error::new(
                ErrorKind::InvalidData,
                format!("Failed to verify pin: {}", e),
            )
        })
    }
}
