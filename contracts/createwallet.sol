// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./erc20token.sol";

contract TokenWallet {
    Token public token;
    mapping (address => uint) public tokenbalance;

    constructor(address tokenAddress) {
        token = Token(tokenAddress);
    }

    function balance() public view returns (uint256) {
        return token.balanceOf(msg.sender);
    }

    function deposit(uint amount) public {
        token.transferFrom(msg.sender, address(this), amount);
        tokenbalance[msg.sender] += amount;
    }

    function withdraw(uint amount, address to) public {
        token.transfer(to, amount);
    }

}    