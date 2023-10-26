 
use bincode;
use serde::{Deserialize, Serialize};
use crypto::digest::Digest;
use crypto::sha3::Sha3;
/// 序列化
pub fn serialize_rs<T:?Sized>(value:&T)->Vec<u8> where T:Serialize{
     bincode::serialize(value).unwrap()
    
}
/// 反序列化
pub fn deserialize_rs<'a,T>(bytes:&'a[u8])->T where T:Deserialize<'a>{
       bincode::deserialize(bytes).unwrap()
}

/// 求hash
pub fn get_hash(value:&[u8])->String{
    let mut hasher=Sha3::sha3_256();
    hasher.input(value);
    hasher.result_str()
}
// 单元测试
#[cfg(test)]
mod tests {
    use super::*;
    #[derive(Debug,Deserialize, Serialize,PartialEq)]
    struct Point{
        x:i32,
        y:i32
    }
    #[test]
    fn test_coder() {
        let point=Point{x:1,y:1};
        let se=serialize_rs(&point);
        let de:Point=deserialize_rs(&se);
        assert_eq!(de,point);
    }
}
