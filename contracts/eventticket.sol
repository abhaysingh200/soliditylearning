// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract eventticket{
    uint256 public totalticket;
    uint256 public noofticket;
    uint256 public ticketprice;
    uint256 public totalamount;
    uint256 public startat;
    uint256 public endat;
    uint256 public timestamp;
    string public message="buy your ticket";

    constructor (uint256 ticketpric){
        ticketprice= ticketpric;
        startat=block.timestamp;
        endat=block.timestamp + 7 days;
        message;
        timestamp=(endat-startat)/60/60/24;
        // the resulting value of "timestamp" will be in days first 60 convert in minutes, then hours,then days,
    }

    function addticket(uint256 value) public returns(uint256 ticketid) {
        noofticket++;
        totalticket+=value;
        ticketid=noofticket;
        totalamount=totalticket*ticketprice;
    } 

    function removeticket(uint256 value) public {
        totalticket-=value;
        totalamount=totalticket*ticketprice;
    }
}