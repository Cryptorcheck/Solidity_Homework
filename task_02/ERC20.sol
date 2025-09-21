// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.28;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// import "openzeppelin-contracts/token/ERC20/IERC20.sol";

contract ERC20Impl is IERC20 {
    uint private _totalSupply; // 总发行量
    address private _owner;

    constructor() {
        _owner = msg.sender;
    }

    // 返回某个地址的代币余额
    mapping(address user => uint amount) private _balanceOf;

    // 授权情况 owner:授权人 授权 spender:被授权人 amount:被授权的代币数量
    mapping(address owner => mapping(address spender => uint amount))
        private _allowance;

    modifier onlyOwner() {
        require(msg.sender == _owner, "access forbidden");
        _;
    }

    function mint(uint256 value) public onlyOwner {
        _totalSupply += value;
    }

    // 直接转账
    function transfer(address to, uint256 value) external returns (bool) {
        require(value > _balanceOf[msg.sender], "insufficient balance");
        require(to != address(0), "invalid receiver address");

        _balanceOf[msg.sender] -= value;
        _balanceOf[to] += value;

        emit Transfer(msg.sender, to, value);

        return true;
    }

    // 授权方法
    function approve(address spender, uint256 value) external returns (bool) {
        require(value > _balanceOf[msg.sender], "insufficient balance");
        require(spender != address(0), "invalid spender address");

        _allowance[msg.sender][spender] = value;

        emit Approval(msg.sender, spender, value);

        return true;
    }

    // 被授权人调用交易
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool) {
        require(from != address(0), "invalid address");
        require(to != address(0), "invalid address");
        require(
            _allowance[from][msg.sender] >= value,
            "allowable insufficient balance"
        );
        require(_balanceOf[from] > value, "insufficient balance");

        _allowance[from][msg.sender] -= value;
        _balanceOf[from] -= value;
        _balanceOf[to] += value;

        emit Transfer(from, to, value);

        return true;
    }

    /* 
      get方法
     */
    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        require(account != address(0), "invalid address");
        return _balanceOf[account];
    }

    function allowance(
        address owner,
        address spender
    ) external view returns (uint256) {
        require(owner != address(0), "invalid owner address");
        require(spender != address(0), "invalid spender address");
        return _allowance[owner][spender];
    }
}
