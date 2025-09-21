// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.28;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

// import "openzeppelin-contracts/token/ERC20/IERC20.sol";

contract ERC20Impl is IERC20 {
    uint private _totalSupply; // 总发行量

    // 返回某个地址的代币余额
    mapping(address user => uint amount) private _balanceOf;

    // 授权情况 owner:授权人 授权 spender:被授权人 amount:被授权的代币数量
    mapping(address owner => mapping(address spender => uint amount))
        private _allowance;

    // 交易
    function transfer(
        address to,
        uint256 value
    ) external override returns (bool) {
        require(value > _balanceOf[msg.sender], "insufficient balance");
        require(to != address(0), "invalid receiver address");

        _balanceOf[msg.sender] -= value;
        _balanceOf[to] += value;

        emit Transfer(msg.sender, to, value);

        return true;
    }

    // 授权方法
    function approve(
        address spender,
        uint256 value
    ) external override returns (bool) {}

    // 被授权人调用交易
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external override returns (bool) {}

    /* 
      get方法
     */
    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(
        address account
    ) external view override returns (uint256) {
        require(account != address(0), "invalid address");
        return _balanceOf[account];
    }

    function allowance(
        address owner,
        address spender
    ) external view override returns (uint256) {
        require(owner != address(0), "invalid owner address");
        require(spender != address(0), "invalid spender address");
        return _allowance[owner][spender];
    }
}
