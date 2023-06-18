// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//sending ether using three methods
//1. transfer(2300 gas, throws error)
//2. send(2300 gas, return bool)
//3. call(forward all gas or set gas, return bool)


contract receiveether{
    /*
    which function is called, fallback() or receive()?

    send ether
       /
       msg.data is empty?
       /    \
    yes    no
    /          \
receive()      fallback()
  exists?         \
  /                \
               
    */

    event bottomlog(string text, address sender, uint value, bytes data );

    //function to receive ether. msg.data must be empty
    receive() external payable {
        //emit bottomlog("receive", msg.sender, msg.value, "");
    }

    //fallback function is called when msg.data is not empty
    fallback() external payable {
        emit bottomlog("fallback", msg.sender, msg.value, msg.data);
    }

    function getbalance() public view returns (uint){
        return address(this).balance;
    }

}

contract sendether{
    function sendviatransfer(address payable _to) public payable {
        //this function is no longer recommended for sending ether.
        _to.transfer(msg.value);
    }

    function sendviasend(address payable _to) public payable {
        //send returns a boolean value indicating success or failure.
        //this function is not recommended for sending ether.
        bool sent= _to.send(msg.value);
        require(sent,"not sended");
    }

    function sendviavcall(address payable _to) public payable {
        //call returns a boolean value indicating success or failure.
        //this is the current recommended method to use.
        (bool sent,) = _to.call{value:msg.value}("");
        require(sent,"failed to send ether");
    }

    //in this fallback and receive funtion taking more then 2300 gas thats why sendviasend and trasfer
    //not working thats why these are not recommended
    //sendvia call is working there is not gas limit.
}