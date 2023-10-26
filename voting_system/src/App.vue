<script setup>
import {ref} from "vue"
const active = ref(0);
</script>


<template>
  <div>
    <nav class="header">去中心化投票</nav>
    <main>
      <router-view></router-view>
    </main>

    <van-tabbar route  v-model="active" active-color="#ee742f">
      <van-tabbar-item icon="gem-o" to="/">分发票权</van-tabbar-item>
      <van-tabbar-item icon="setting-o" to="/account">账户信息</van-tabbar-item>
      <van-tabbar-item icon="setting-o" to="/board">投票看板</van-tabbar-item>
    </van-tabbar>


  </div>
</template>



<style lang="less" scoped>
.header {
  height: 44px;
  background-color: #ee742f;
  color: #fff;
  text-align: center;
  line-height: 44px;
}
</style>
<style lang="less"></style>
