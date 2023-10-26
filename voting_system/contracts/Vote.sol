// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract Vote{
    // 构建投票人数据结构体
    struct Voter{
        uint256 amount; //可以投的票数
        bool isVoted; //是否投过票
        address delegator; // 代理人地址
        uint256 targetId; // 目标ID
    }

    // 投票看板结构体
    struct Board{
        string name; // 目标名字
        uint256 totalAmount; // 票数
    }

    // 主持人信息
    address public host;

    // 投票人集合
    mapping (address=>Voter) public voters;

    // 主题集合
    Board [] public board;

    // 数据初始化
    constructor(string[]memory nameList){
        host=msg.sender;

        // 给主持人初始化一票
        voters[host].amount=1;

        // 初始化board
        for(uint i=0;i<nameList.length;i++){
            Board memory item=Board(nameList[i],0);
            board.push(item);
        }
    }
    
    // 返回看板合集
    function getBoardInfo() public  view returns (Board[]memory){
        return board;
    }

    //给地址赋予选票
    function mandate(address[] calldata addressList) public {
        // 只有主持人可以调用
        require(msg.sender==host,"Only the owner has permissions.");
        for (uint256 i=0; i<addressList.length;i++){
            //如果地址投票过，不做处理
            if(!voters[addressList[i]].isVoted){
                voters[addressList[i]].amount=1;
            }
        }
    }
    // 将投票权委托给别人
    function delegate(address to) public {
        // 获取委托人的地址
        Voter storage sender=voters[msg.sender];

        // 如果委托人投票了，不能再委托
        require(!sender.isVoted,"You have already voted");

        // 不能委托给自己
        require(msg.sender!=to, "cannot delegate to yourself");

        // 避免循环委托
        while (voters[to].delegator!=address(0)){
            to=voters[to].delegator;
            require(to==msg.sender,"Non-cyclic authorization");
        }

        // 开始授权
        sender.isVoted=true;
        sender.delegator=to;

        //代理人的数据修改
        Voter storage delegator_=voters[to];
        if(delegator_.isVoted){
            //追票
            board[delegator_.targetId].totalAmount+=sender.amount;

        }else{
            delegator_.amount+=sender.amount;
        }

    }
    // 投票
    function vote(uint256 targetId) public {
        Voter storage sender=voters[msg.sender];
        require(sender.amount!=0,"Have no right to vote");
        require(!sender.isVoted,"Already Voted");

        sender.isVoted=true;
        sender.targetId=targetId;
        board[targetId].totalAmount+=sender.amount;
        emit voteSuccess(unicode"投票成功");
    }
    // 投票成功事件
    event voteSuccess(string);
}
/**
主持人：0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
张三：0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
李四：0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
王五：0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB
赵六：0x617F2E2fD72FD9D5503197092aC168c91465E7f2
牛七：0x5c6B0f7Bf3E7ce046039Bd8FABdfD3f9F5021678
马八：0x03C6FcED478cBbC9a4FAB34eF9f40767739D1Ff7
["0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2", "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db", "0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB"]
["路人甲","路人乙","路人丙","路人丁"]
*/
