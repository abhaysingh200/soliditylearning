// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract EtherWallet{

    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {

    }

//external means other can access and see this function, if we write private or internal then in deploy it will not shown.
    function withdraw(uint amount) external {
        uint value = amount / 1 ether;
        require(msg.sender == owner, "only owner can withdraw");
        payable(msg.sender).transfer(amount);
    }

    function getbalance() private view returns(uint){
        return address(this).balance;
    }
}