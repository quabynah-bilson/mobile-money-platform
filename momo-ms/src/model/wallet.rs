use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Debug, Clone)]
pub struct Wallet {
    pub id: String,
    pub account_holder: String,
    pub provider: String,
    pub hashed_phone: String,
    pub phone_number: String,
    pub owner: String,
    pub balance: f32,
}

impl Wallet {
    pub fn hash_phone_number(&mut self) -> Result<(), std::io::Error> {
        let start = self.phone_number.split_at(5).0;
        let end = self.phone_number.split_at(self.phone_number.len() - 3).1;
        self.hashed_phone = (start.to_owned() + "***" + end).to_string();
        println!("hashed number -> {:?}", self.hashed_phone);
        Ok(())
    }
}