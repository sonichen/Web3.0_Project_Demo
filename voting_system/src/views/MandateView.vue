<script setup>
import { ref, onMounted } from 'vue';
import useWeb3 from "../hooks/useWeb3"

const { web3, voteContract,getAccount } = useWeb3();

// 定义变量
const host = ref(""); // 主持人
const voterAddress = ref("");// 选民地址



// 函数
// 获取主持人
const getHost = async () => {
  host.value = await voteContract.methods.host().call();
}
// 分发票权
const mandate=async() => {
  const arr=eval(voterAddress.value);//字符串转数组
  const account=await getAccount();
  console.log(account);
  voteContract.methods.mandate(arr).send({from:account})
  .on(
    "receipt",()=>{
      console.log("选票分发成功");
    }
  )
}

onMounted(async () => {
  await getHost();
});
</script>

<template>
  <div class="box1">
    <van-divider>分发票权</van-divider>
    <div class="host">
      <van-space>
        <p class="label">
          <van-icon name="manager">主持人地址</van-icon>
        </p>
        <p class="address">
          {{ host }}
        </p>
      </van-space>
    </div>

    <div>
      <van-space>
        <p class="label">
          <van-icon name="friends-o">投票人地址</van-icon>
        </p>
        <textarea class="votors" v-model="voterAddress"> </textarea>
      </van-space>
    </div>
    <div class="btn">
      <van-button block @click="mandate">开始分发选票</van-button>
    </div>
  </div>
</template>
  

<style scoped lang='less'></style>