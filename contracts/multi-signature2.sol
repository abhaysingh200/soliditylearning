// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MultiSigWallet{
    event Deposit(address indexed sender, uint amount);  //when we deposit.
    event Submit(uint indexed txId); // when transaction submitted for owner approval.
    event Approve(address indexed owner, uint indexed txId); //when owners approve the transaction.
    event Revoke(address indexed owner, uint indexed txId); //may be owner cancel the approval.
    event Execute(uint indexed txId); //when enough approval approve then transaction will executed.

    struct Transaction{
        address to;   //to whom we sent.
        uint value;   //total amount.
        bytes data;   //whats our data.
        bool executed; //once transaction executed it sets to true.
    }

    address[] public owners; //here we store the owners.
    mapping (address => bool) public isOwner; //if address is the owner then it returns true otherwise false.
    uint public required; //no. of approvals required number of owners by total no. of owners.

    Transaction[] public transactions;  //We store all transactions made by all multi-signature wallet.
    
    mapping (uint => mapping (address => bool)) public approved; //using owners(address) can approve(bool=true) any transaction by its transaction id(uint).

    modifier onlyOwner(){
        require(isOwner[msg.sender], "not a owners"); //we cant use msg.sender==owner because owner is array.
        _;
    }

    modifier txExists(uint _txId) {
        require(_txId < transactions.length, "tx not exists.");  //using tx id as less the lenght will id.
        _;
    } 

    modifier notApproved(uint txId) {
        require(!approved[txId][msg.sender], "tx already approved"); //in modifier only true always go next false give error.
        _;
    }

//using this we check struct in transaction executed is true or false.
//and transactions is array we add that index number here and his executed.
    modifier notExecuted(uint _txId) {
        require(!transactions[_txId].executed, "transaction already executed");
        _;
    }

    constructor(address[] memory _owners, uint _required){
        require(_owners.length>0, "owners required");
        require(_required >0 && _required <= _owners.length, "invalid required number of owners");

    // in this we add all the constructor address(owners) in the owners array.   
        for (uint i; i < _owners.length; i++){
            address owner = _owners[i];
            require(owner != address(0), "invalid address");
            require(!isOwner[owner], "owner is not unique"); //here we check if true comes then its fine.

            isOwner[owner] = true;  //we return the value to true to new address.
            owners.push(owner);     //and add the address to the owners.
        }
        required=_required;  //here we define the total no. confirmation required from total owners.
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);   //using this we can deposit the funds in contract with log.
    }

//using this we submit the transaction in Transactions array.
    function submit(address _to, uint _value, bytes calldata _data) external  onlyOwner {    //calldata is used when we access the data from somewhere. and in memory we create new data.
        transactions.push(Transaction({   //using this we push details of transaction in transactions array.
            to: _to, value : _value, data : _data, executed: false }));
        emit Submit(transactions.length - 1);    //when new transaction add lenght increase we do -1.
    }

    function approve(uint _txId) external onlyOwner txExists(_txId) notApproved(_txId) notExecuted(_txId) {  //using this we ensure the only owners can run, tx must be live, not approved by someone, and not executed(completed on blockchain).
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender, _txId);
    }

    function _getApprovalCount(uint _txId) private view returns(uint count) {
        for (uint i; i< owners.length; i++){
            if (approved[_txId][owners[i]]){
                count+=1;
            }
        }
    }

    function execute(uint _txId) external onlyOwner txExists(_txId) notExecuted(_txId){
        require(_getApprovalCount(_txId) >= required, " number of approvals not meet ");
        Transaction storage transaction = transactions[_txId];  //we make seperately because we cant add these info in transactions(because its only for transactions).
        transaction.executed = true;
        (bool sucess,) = transaction.to.call{value: transaction.value}(transaction.data);
        require(sucess, "tx failed");
        emit Execute(_txId);
    }

    function revoke(uint _txId) external onlyOwner txExists(_txId) notExecuted(_txId){
        require(approved[_txId][msg.sender], "tx is not approved");  //we are checking if true then go next
        approved[_txId][msg.sender] = false; //and then assign him false.
        emit Revoke(msg.sender, _txId);
    }

}