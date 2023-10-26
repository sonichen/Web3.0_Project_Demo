# Rust实现SimpleBlockchain

## 功能

实现简单的链式结构，能够创建区块

用到序列化、反序列化、求哈希等知识点

### 运行结果

```shell
start mining...
produce a block
produce a block
++++++++++++++++++++++++++++++
Block {
    header: BlockHeader {
        time: 1698325688,
        tx_hash: "919c913797a6832bc8176dddb9b33abb2e244bcf1eea2bb81b8e5ad939ed2ce9",
        pre_hash: "",
    },
    hash: "61ebd2b76e4e41c6d63ba42292640c49ef7b7cce30c4bc1b3b072acf144bb6e8",
    data: "This is genesis block",
}

++++++++++++++++++++++++++++++
Block {
    header: BlockHeader {
        time: 1698325693,
        tx_hash: "f98146e202785394baf8e2bcf912f128a5e1462b01e22a4d613d57845e61ad58",
        pre_hash: "61ebd2b76e4e41c6d63ba42292640c49ef7b7cce30c4bc1b3b072acf144bb6e8",
    },
    hash: "ba9b5cff5c802e8eb99f97b3af9a6d0007ac1c7e7d1a72a11f71d5947ca1948b",
    data: "a=>b: 5btc",
}

++++++++++++++++++++++++++++++
Block {
    header: BlockHeader {
        time: 1698325698,
        tx_hash: "993b13cd1d16349f4ecb2e16a1265df944f9bdc511748498f2668e1cbc1ffd7c",
        pre_hash: "ba9b5cff5c802e8eb99f97b3af9a6d0007ac1c7e7d1a72a11f71d5947ca1948b",
    },
    hash: "c325b31e86490b5056f350ca8ec4e77686cdc5245eaf4a22c05751660412940d",
    data: "c=>d: 1btc",
}
```



## Reference

https://www.bilibili.com/video/BV145411t7qp
