use chrono::prelude::*;
use utils::coder;
use serde::{Deserialize, Serialize};
/// 区块头
 #[derive(Debug,Deserialize, Serialize,PartialEq)]
pub struct BlockHeader {
    // 时间戳
    pub time: i64,
    // 根hash
    // transactions data merkle root hash
    pub tx_hash: String,
    // 父区块hash
    pub pre_hash: String,
}

/// 区块
#[derive(Debug,Deserialize, Serialize,PartialEq)]
pub struct Block {
    // 区块头
    pub header: BlockHeader,
    pub hash: String,
    pub data: String,
}

impl Block {
    fn set_hash(&mut self) {
        self.header.time = Utc::now().timestamp();
        let header = coder::serialize_rs(&self.header);
        self.hash = coder::get_hash(&header[..]);
    }
    pub fn new_block(data: String, pre_hash: String) -> Block {
        let transactions = coder::serialize_rs(&data);
        let tx_hash = coder::get_hash(&transactions[..]);
        let time= Utc::now().timestamp();
        let mut block = Block {
            header: BlockHeader {
                time,
                tx_hash,
                pre_hash,
            },
            hash:"".to_string(),
            data,
        };
        block.set_hash();
        block
    }
}
