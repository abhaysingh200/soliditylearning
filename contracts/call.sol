// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract receiver{

    event received(address caller, uint amount,string message);

    fallback() external payable {
        emit received(msg.sender, msg.value, "fallbackcalled");
    }

    function foo(string memory _message, uint _x) public payable returns (uint){
        emit received(msg.sender, msg.value, _message);
        return _x+1;
    }
    //giving warning saying use receiver function

}
//lets imaging that contract caller does not have the source code for the
//contract receiver, but he want to know of contract receiver and the to call.

contract caller{
    event response(bool success, bytes data,uint gas);

    function testcallfoo(address payable _addr) public payable {
        //you can send ether and specify a custom gas amount
        bytes memory data = abi.encodeWithSignature("foo(string,uint256)", "call foo",123);
        (bool success, bytes memory result ) = _addr.call{value:msg.value, gas:5000}(data);
        emit response(success,data,gasleft());

    }   //abi.encodeWithSignature helps in generating the correct encoded function call data, 
       //allowing contracts to interact with each other in a standardized and compatible manner.

    //calling a function that does not exist triggers the fallback function.
    function testcallnotexist(address payable _addr) public payable {
        (bool success,bytes memory data)= _addr.call{value:msg.value}(
            abi.encodeWithSignature("doesnotexist()") );
        emit response(success, data,gasleft());
    }

}