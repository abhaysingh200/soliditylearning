// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// modifier are code that we can run before and after the function call
//mostly use for 3 reasons
//validate data, restrict access, guard against reentrancy hack.

contract modifieruses{

    address public  owner;
    uint256 public x=10;
    bool public locked;

    constructor(){
        owner=msg.sender;
    }

    modifier onlyowner(){
        require(msg.sender==owner, "you are not landlord");
        _;
    }

    modifier validaddress(address _address){
        require(_address !=address(0), "not a valid address");
        _;
    }

    function changeonwer(address newaddress) public onlyowner validaddress(newaddress) { 
        owner=newaddress;
        
    }
    //in this function we use newaddress after validaddress because in valid modifier we are taking _address so we need address to check thats why its need.
}