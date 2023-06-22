// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//Callee(_addr) is used to instantiate an existing contract (Callee) based on a known address, 
//allowing interaction with its functions and state variables within the current contract (Caller).
//it assumes that there is already an existing Callee contract deployed at the specified address _addr.

contract Callee{

    uint public x;
    uint public value;

    function setX1(uint _x) public returns(uint){
        x= _x;
        return x;
    }

    function setXandSendEther1(uint _x) public payable returns(uint,uint){
        x=_x;
        value=msg.value;

        return (x,value);
    }
    function get() external view returns(uint,uint){
        return (x,value);
    }
}

contract Caller{

    function setX(Callee _callee, uint _x) external  {
        _callee.setX1(_x);
        //using return value print in logs(output).
    }

    function setXFromAddress(address _addr, uint _x) public {
        Callee callee = Callee(_addr);   
        //we make instance of Callee and assigned it to Caller variable callee(which store address), so when we want to use that contract we can use it by variable.
        //_addr should be the contract address of Callee.
        callee.setX1(_x);  
        //now here callee is now the contract address so we are using its function.
    }

    function setXandSendEther3(address _callee,uint _x) external payable {
        Callee(_callee).setXandSendEther1{value:msg.value}(_x);
        //{value:msg.value} ensure that same amount will transfer ether from this 3 function to this 1 function with _x.
    }

    function setXandSendEther2(Callee _callee,uint _x) external payable {
        _callee.setXandSendEther1{value :msg.value}( _x);
    }

    function getxandvalue(address _adr) external view returns(uint, uint){
        (uint x, uint value)= Callee(_adr).get();
        return (x , value);
    }//we are not creating our own, we upper we set in this we get so to get and print we need to make localvariables.
    
}