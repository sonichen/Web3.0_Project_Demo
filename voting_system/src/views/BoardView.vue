<script setup>
import { ref,onMounted} from 'vue';
import useWeb3 from "../hooks/useWeb3"
const { web3, voteContract,getAccount } = useWeb3();
 
// 定义变量
const account=ref(""); //当前账号
// 看板信息
const board=ref([])
const getBoardInfo=async()=>{
  const result=await voteContract.methods.getBoardInfo().call();
  board.value=result;
}
// 投票
const vote=async(index)=>{
  account.value=await getAccount();
  const result=await voteContract.methods.vote(index).send({from:account.value});
  console.log(result);
};
const initEventListen=()=>{
  voteContract.events.votoSuccess({ fromBlock:0},(err,event)=>{
    console.log("监听执行");
    console.log(event);
  }).on("data",(event)=>{
    console.log("合约触发的事件: ",event);
  })
}
onMounted(async()=>{
    await getBoardInfo();
})

</script>
<template>
    <div class="box3" >

      <van-divider>投票看板</van-divider>
      <van-cell :title="item.name" icon="shop-o" v-for="(item,index) in board">
        <template #right-icon>
          <van-button @click="vote(index)">{{item.totalAmount}}</van-button>
        </template>
      </van-cell>
    </div>
  </template>
  

  <style scoped lang='less'>
  </style>