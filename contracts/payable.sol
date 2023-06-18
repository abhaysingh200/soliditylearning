// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


contract payableuse{
//payable address can receive ether
    address payable public owner;

    //payable contrcutor can receive ether.
    constructor() payable  {
        owner=payable(msg.sender);
    }//constructor never be visible.

    //function to deposit ether into this contract.
    //call this function along with some ether.
    //the balance of this contract will be automatically updated.
    function deposit() public payable {}

    //call this function along with some ether.
    //the function will throw an error since this function is not payable
    function nonpayablE() public {}

    //function to withdraw all ether from this contract.
    function withdraw() public  {
        //get the amount of ether stored in this contract
        uint amount = address(this).balance;  

        //send all ether to owner
        //owner can receive ether since the address of owner is payable
        (bool sucess,) = owner.call{value: amount}("");
        require(sucess, "failed to send ether");   
    }

    //function to transfer ether from this contract to address from inpit
    function withdrawinput(address payable _to, uint _amount) public {
        //note that "to" is declared as payable
        (bool sucess,) = _to.call{value:_amount}("");
        require(sucess, "failed to send ether");
    }

    //why we dont use _; in require because this is the place from their function will run when condition fulfill
    // but we already use require in function then why need
    //in modifier we need because we need to run modifier in function due to that we need to write
    //so when require complete _; will run the function 

    
}
