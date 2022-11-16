pub enum TransactionType {
    Transfer,
    Payment,
    Cashout,
}

pub struct Transaction {
    pub id: String,
    pub transaction_type: String,
    pub sender: String,
    pub recipient: String,
    pub amount: double,
    pub timestamp: DateTime,
    pub reference: String,
}