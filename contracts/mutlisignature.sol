// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import "./erc20token.sol" ;

contract multisign{

//here we make pointer token which point the Token contract.
    Token public token;
    address owner;

//In this we assign the contract address of Token which we want to use. 
    constructor (address tokenAddress) {
        token = Token(tokenAddress);
        owner = msg.sender;
    }

// here we design the struct in which we store the managers addresses and names.
    struct Managers{
        string name;
        address adr;
    }
// here we make a array of Manager(structs) in this we store struct details and in this pointer is managers.   
    Managers[] public managers;
    
// using this we can only owner can add new managers. Which details we add in managers which is type of struct.
    function addManagers(string[] memory name, address[] memory adr) external  {
        require(msg.sender == owner);
        for (uint i =0; i < adr.length; i++){
            managers.push(Managers(name[i], adr[i]));
        }
    }

// here we make a approval mapping, in ths we map address( manager) to (=>) address( approval address).
    mapping (address => address ) public Approval;

    uint index;

//in this manager will approve to any manager or address whom they want to run the airdrop function.    
    function approve(address to) external  {
        Approval[managers[index].adr] = to;
        index ++;
    }

//using this airdrop function we can transfer our token to airdrop user addresses, and
//it will run when all manager will approve the caller of this function.
    function airdrop(address[] memory _adr , uint amount) external {
        for (uint i =0; i < _adr.length; i++){
            require(Approval[managers[i].adr] == msg.sender, "all manager not allow");
        }

        for (uint i =0; i < _adr.length; i++){
            token.transfer(_adr[i], amount);
        }
    }

//using this function only owner can change the name and address of manager.
    function resetmanager(uint index1, address NewManager, string memory Name) external {
        require(msg.sender == owner, "you are't owner");
        Approval[managers[index1].adr] = address(0);
        managers[index1].adr = NewManager;
        managers[index1].name = Name;
    }
}