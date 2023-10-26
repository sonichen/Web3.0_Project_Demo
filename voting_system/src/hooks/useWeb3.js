import Web3 from "web3";
import VoteJson from "../contract/Vote.json"
const useWeb3 = () => {
    // 构造web3实例
    const web3 = new Web3(Web3.givenProvider || "wss://goerli.infura.io/ws/v3/9b2967006bbc48d789b3afe8d4053643");
    // 实例化合约
    const contractAddress = "0xCcC1071819d8d93Bd5bCFD10969e828A25852EBf";
    const voteContract = new web3.eth.Contract(
        VoteJson.abi,
        contractAddress
    );

    // 获取账号
    const getAccount=async()=>{
        const accounts=await web3.eth.requestAccounts();
        return accounts[0];
    };
    return {
        web3,
        voteContract,
        contractAddress,
        getAccount
    }
};

export default useWeb3;