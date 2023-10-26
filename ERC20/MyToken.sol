// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "./Context.sol";

contract MyToken is Context {
    /**
    - 规范 -
    function name() public view returns (string)
    function symbol() public view returns (string)
    function decimals() public view returns (uint8)
    function totalSupply() public view returns (uint256)
    function balanceOf(address _owner) public view returns (uint256 balance)
    function transfer(address _to, uint256 _value) public returns (bool success)
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success)
    function approve(address _spender, uint256 _value) public returns (bool success)
    function allowance(address _owner, address _spender) public view returns (uint256 remaining)

    event Transfer(address indexed _from, address indexed _to, uint256 _value)
    event Approval(address indexed _owner, address indexed _spender, uint256 _value)
    **/
    // - 1. 代币信息 -
    // 代币名称 name
    string private _name;
    // 代币标识 symbol
    string private _symbol;
    // 代币小数数位 decimals
    uint8 private _decimals;
    // 代币的总发行量 totalSupply
    uint256 private _totalSupply;
    // 代数量 balance
    mapping(address => uint256) private _balances;
    // 授权代币数量 allowance
    mapping(address => mapping(address => uint256)) private _allowances;

    // - 2.初始化 -
    constructor() {
        _name = "sonichen";
        _symbol = "sc";
        _decimals = 18;
        // 初始化货币值
        _mint(_msgSender(), 100 * 10000 * 10**_decimals);
    }

    // - 3.取值器 -
    // 返回代币的名字 name()
    function name() public view returns (string memory) {
        return _name;
    }

    // 返回代币标识
    function symbol() public view returns (string memory) {
        return _symbol;
    }

    //返回代币小数位数
    function decimals() public view returns (uint8) {
        return _decimals;
    }

    //返回代币总发行量
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    //返回某个账户拥有的代币数量
    function balanceOf(address account) public view returns (uint256 balance) {
        return _balances[account];
    }

    //返回授权代币数量
    function allowanceOf(address owner, address spender)
        public
        view
        returns (uint256 balance)
    {
        return _allowances[owner][spender];
    }

    // - 4. 函数 -
    // 代币转发
    function transfer(address to, uint256 amount) public returns (bool) {
        address owner = _msgSender();
        // 实现转账
        _transfer(owner, to, amount);
        return true;
    }

    // 授权代币
    function approve(address spender, uint256 amount) public returns (bool) {
        // 银行授权给我(用户贷款给我)
        address owner = _msgSender();
        // owner是授权人
        // spender 被授权人
        _approve(owner, spender, amount);
        return true;
    }

    // 授权代币转发
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public returns (bool) {
        // approve授权,现在要提款,要有一个转账操作
        address owner = _msgSender();

        // 更新授权账户信息
        _spendAllowance(from, owner, amount);

        // 执行转账
        // from: 银行
        // to: 自己/中介公司/买房人
        _transfer(from, to, amount);
        return true;
    }

    // - 5.事件-
    event Transfer(address _from, address _to, uint256 amount);
    event Approval(address _owner, address _spender, uint256 amount);

    // - 6. 合约内部函数 -
    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to thge zero address");
        // 初始化货币数量
        _totalSupply += amount;
        //给某个账号注入起始资金
        unchecked {
            _balances[account] += amount;
        }
    }

    // 转账操作
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal {
        // 检查地址
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERO20: transfer to the zero address");
        // 检查余额是否足够
        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, unicode"ERC20: 余额不足.");
        // 转账
        unchecked {
            _balances[from] = fromBalance - amount;
            _balances[to] += amount;
        }
        emit Transfer(from, to, amount);
    }

    //授权代币的转发
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve from the zero address");
        // 执行授权
        _allowances[owner][spender] = amount;

        emit Approval(owner, spender, amount);
    }

    // 执行授权代币转发
    function _spendAllowance(
        address owner,
        address spender,
        uint256 amount
    ) internal {
        uint256 currentAllowance = allowanceOf(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, unicode"ERC20: 余额不足");
            // 修改余额
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }

}
