// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./erc20token.sol";

contract ICO {

    Token public token;
    uint public avaiableToken = 1000;
    string public icoStatus = "upcoming soon";
    uint private startTime;
    uint private endTime;
    mapping (address buyer => uint token) public users;

    constructor(address Tokenaddress){
        token = Token(Tokenaddress);
        startTime = block.timestamp ;
        endTime = startTime +  30 seconds ;
    }

    function IcoStatus() public {
        if (block.timestamp > startTime && block.timestamp < endTime){
        icoStatus = "Star Now"; }
        else {
        icoStatus = "End Now"; }
    }

    function DepositEther() public payable returns(bool){
        require(block.timestamp > startTime && block.timestamp < endTime, "check ico status.");
        require( msg.value >= 1 ether ,"min.1 can deposit");
        users[msg.sender] += (msg.value * 50) / 1 ether;
        require((msg.value * 50) / 1 ether <= avaiableToken, "max supply reached.");
        avaiableToken -= (msg.value * 50) / 1 ether;
        require(users[msg.sender] <= 200, "max 200 token allows.");
        return true;
    } 

    function claimToken() public {
        require(users[msg.sender] > 49 && block.timestamp > endTime, "0 balance, wait for claim" );
        token.transfer(msg.sender, users[msg.sender]);
        users[msg.sender] = 0;
    }
}