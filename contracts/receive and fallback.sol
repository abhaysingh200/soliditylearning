// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//if we want to test this contract can receive ether or not we can deploy it
//and enter the ether amount and click on transact
//In order to receive Ether transfer the contract should have either 'receive' or payable 'fallback' function
//this error comes

contract receive_fallback{

    event log(string fun, address sender, uint _value, bytes _data);

    //fallback always external, so receive ether we need to make it payable.
    fallback() external payable {
        emit log("fallback", msg.sender, msg.value, msg.data);
    }
    //using fallback we can receive the data or ether if any one send us

    receive () external payable {
       emit log("receive", msg.sender, msg.value,"");

    }//receive used for receiving ether.
    
    function checkbalance() public view returns (uint){
        return address(this).balance;
    }
}
//if we have both fallback and receive in contract.
//then we get eth + message then he go to fallback.
//if only eth then in receive.
//if only data then in fallback.

//if we have only fallback then
//fallback will receive both data and eth.

//if we have only receive then
//receive will only get eth, not data.

//Both the fallback function and receive function are used to handle incoming Ether transfers, 
//but the main difference lies in how they are triggered. 
//The fallback function is called when a contract receives a message that doesn't match any other function signature, while the receive function is called specifically when a contract receives a direct Ether transfer without any data.
