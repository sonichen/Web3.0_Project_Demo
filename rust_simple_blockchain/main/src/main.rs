use core::blockchain;
use std::time::Duration;
use std::thread;
fn main() {
    let mut blockchain = blockchain::BlockChain::new_blockchain();

    println!("start mining...");

    thread::sleep(Duration::from_secs(5)); // 模拟时间间隔
    blockchain.add_block(String::from("a=>b: 5btc"));
    println!("produce a block");

    thread::sleep(Duration::from_secs(5)); // 模拟时间间隔
    blockchain.add_block(String::from("c=>d: 1btc"));
    println!("produce a block");

    for item in blockchain.blocks {
        println!("++++++++++++++++++++++++++++++");
        println!("{:#?}", item);
        println!();
    }
}
