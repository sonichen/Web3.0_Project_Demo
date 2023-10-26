// router/index.js

import { createRouter, createWebHistory } from "vue-router";
import ManadateView from "../views/MandateView.vue"
 

// 创建路由规则
let routes = [
    {
        path: '/', // URL 地址
        name: 'home',  // 名称
        component: ManadateView  // 渲染该组件
    },
    {
        path: '/account', // URL 地址
        name: 'account',  // 名称
        component:()=>
        import("../views/AccountView.vue")
    },
    {
        path: '/board', // URL 地址
        name: 'board',  // 名称
        component:()=>
        import("../views/BoardView.vue")
    },
]

// 创建路由
const router = createRouter({
    // 使用 history 模式
    history: createWebHistory(),
    // 路由规则
    routes
})

// 将路由对象暴露出去
export default router



