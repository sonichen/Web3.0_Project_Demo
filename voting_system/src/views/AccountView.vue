<script setup>
import { ref , onMounted } from 'vue';
import useWeb3 from "../hooks/useWeb3"
const { web3, voteContract,getAccount } = useWeb3();
 
// 定义变量
const account=ref(""); //当前账号
const voterInfo=ref({});// 选民信息
const delegatorAddress=ref("");// 受托人信息
 const getVoteInfo=async ()=>{
    account.value=await getAccount();
    voterInfo.value=await voteContract.methods.voters(account.value).call();
 }
 
 const delegate=async ()=>{
    voteContract.methods.delegate(delegatorAddress.value).send({from:account.value})
    .on(
    "receipt",()=>{
      console.log("委托成功");
    }
  )
 };
 onMounted(async()=>{
    await getVoteInfo();
  })
</script>

<template>
<div class="box2">
    <van-divider>账户信息</van-divider>
    <van-space>
        <p class="label">当前账户</p>
        <p class="address">{{ account }}</p>
    </van-space>
    <br/>
    <van-space>
        <p class="label">账户票数</p>
        <p class="address">{{ voterInfo.amount }}</p>
    </van-space>
    <br/>
    <van-space>
        <p class="label">委托账户</p>
        <p class="address">{{ voterInfo.delegator }}</p>
    </van-space>
    <br/>
    <van-space>
        <p class="label">是否已投票</p>
        <p class="address">{{ voterInfo.isVoted }}</p>
    </van-space>
    <br/>
    <van-space>
        <p class="label">投票ID</p>
        <p class="address">{{ voterInfo.targetId }}</p>
    </van-space>
    <br/>
    <div class="btn">
        <van-cell-group insert>
            <van-field v-model="delegatorAddress" label="受托人地址" placeholder="请输入受托人地址">
            </van-field>
            <van-button block @click="delegate"> 委托他人带投</van-button>
        </van-cell-group>
    </div>
</div>
</template>


<style scoped lang='less'>
</style>