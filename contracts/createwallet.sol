// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./erc20token.sol";

contract TokenWallet {
    Token public token;
    mapping (address => uint) public tokenbalance;

//If we dont use this constructor tx. will reverts because, by default it point on 0x000 which is not a contract address of Token in which any one make any Token
//when we use it without it so token point at 0x000 because token is contract and we make instance of contract obv. he also a contract address
//so by default its address is 0x00000. so he check on this address, he find all variables and function but not runned because 0x000 is not a contract address of any token.
//as Token is just like library(openzipplin) so if we access that we get 0.
//and if we want to update and access of other contract and update the values on that Token then obviousally we need to assign that token contract address
//which we are doing in constructor.

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