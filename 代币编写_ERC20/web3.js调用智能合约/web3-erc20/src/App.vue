
<template>
  <h1>sc基本信息</h1>
  <hr>
  <p>当前账号: {{ currentAccount[0] }}</p>
  <p>代币名称: {{ name }}</p>
  <p>代币标识: {{ symbol }}</p>
  <p>发行量: {{ ts }}</p>
  <p>持有数量: {{ bo }}</p>
  <h1>转账操作</h1>
  <hr>
  <p>转入地址
    <input type="text" v-model="toAddress">
  </p>
  <p>抓出金额
    <input type="text" v-model="amount">sc
  </p>
  <button @click="send">开始转账</button>
</template>

<script setup>
import { ref, onMounted, computed } from "vue"
import Web3 from "web3";
import mtcJson from "/contracts/MyToken.json"

// 实例web3
const geerliWS = "wss://goerli.infura.io/ws/v3/9b2967006bbc48d789b3afe8d4053643";
const web3 = new Web3(Web3.givenProvider || geerliWS);

// 实例合约
const mtcContract = new web3.eth.Contract(
  mtcJson.abi,
  "0x596dB4E8f471B421D4eE80ed03Fe63c24f5f1e00" // 部署后得到的交易ID
);
console.log(mtcContract)
// 定义代币信息
const name = ref("");
const symbol = ref("");
const totalSupply = ref("");
const balanceOf = ref(0);
const currentAccount = ref("");
// 定义转账信息
const toAddress = ref("");
const amount = ref("");
// 获取代币信息
const getCoinInfo = async () => {
  const account = await web3.eth.requestAccounts();
  currentAccount.value = account;
  name.value = await mtcContract.methods.name().call();
  symbol.value = await mtcContract.methods.symbol().call();
  totalSupply.value = await mtcContract.methods.totalSupply().call();
  balanceOf.value = await mtcContract.methods.balanceOf(account[0]).call();
};
const ts = computed(() => {
  return web3.utils.fromWei(totalSupply.value, "ether");
});
const bo = computed(() => {
  return web3.utils.fromWei(String(balanceOf.value), "ether");
});
// 转账
const send = () => {
  const weiAmount = web3.utils.toWei(amount.value, "ether");
  mtcContract.methods
    .transfer(toAddress.value, weiAmount)
    .send({
      from: currentAccount.value[0],
    })
    .on("receipt", (res) => {
      console.log("交易成功");
      console.log(res);
    })
};
onMounted(() => {
  getCoinInfo();
});
// 方法
</script>

<style lang="less">
body {
  padding: 10px
}
</style>
