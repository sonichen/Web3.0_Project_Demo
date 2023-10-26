import { createApp } from 'vue'
import App from './App.vue'
import router from './router'  // 引入路由模块
import "./style.less"
createApp(App).use(router).mount('#app');
 


if(typeof window.ethereum !="undefined"){
    console.log("MetaMask is installed")
}

 
 
