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

contract MultiSigWallet{

    address[] public owners;
    uint public noOfConfirmationRequired;
    mapping (address => bool) public IsOwner;
    mapping (uint => mapping (address => bool)) public IsApproved;

    constructor(address[] memory _owner, uint noOfConfirmation){
        require(noOfConfirmation > 0);
        noOfConfirmationRequired = noOfConfirmation;
        require(noOfConfirmationRequired < _owner.length, "confirm must be less the owners length.");

        for (uint i; i < _owner.length; i++){
            address owner = _owner[i];   //this is gas optimization , using this no need to write _owner[i]
            require(owner != address(0), "invalid owner");
            require(! IsOwner[owner], "already become owner.");
            owners.push(_owner[i]); //why push, because in array if we want to add value we need to use push.
            IsOwner[_owner[i]] = true;
        }
    }

    modifier OnlyOwner(){
        require(IsOwner[msg.sender]);
        _;
    }

    modifier txExists(uint index) {
        require(index < transactions.length, "tx does not exist");
        _;
    }

    modifier NotApprove(uint index) {
        require(! IsApproved[index][msg.sender], "already approved");
        _;
    }

    modifier NotExecute(uint index) {
        require(! transactions[index].executed, "already executed.");
        _;
    }


    struct Transaction{
        address payable to;
        uint amount ;
        bool approved;
        bool executed;
        uint noOfConfirm;
    }

    Transaction[] public transactions;

    receive() external payable {

    }

    function submitTransaction(address payable _to, uint _amount) public OnlyOwner{
        transactions.push(Transaction({
            to : _to,
            amount : _amount,
            approved : false,
            executed : false,
            noOfConfirm: 0
        })
      );
    }

    function ApproveTx(uint index) external OnlyOwner txExists(index) NotApprove(index){
        require(! IsApproved[index][msg.sender], "owner already approved this.");
        Transaction storage transaction  = transactions[index];
        transaction.approved = true;
        transaction.noOfConfirm += 1;
        IsApproved[index][msg.sender] = true;
    }

    function execute(uint index) public OnlyOwner txExists(index) NotExecute(index){
        Transaction storage transaction = transactions[index]; //why we not give executed data because transaction is struct he only store data in struct only.
        require(transaction.noOfConfirm >= noOfConfirmationRequired, "more approve required.");
        transaction.executed = true;
        payable(transaction.to).transfer(transaction.amount);
    }

    function revokeConfirmation(uint index) public OnlyOwner txExists(index) NotExecute(index) {
        Transaction storage transaction = transactions[index];
        IsApproved[index][msg.sender] = false;
        transaction.noOfConfirm -= 1;
    }
}