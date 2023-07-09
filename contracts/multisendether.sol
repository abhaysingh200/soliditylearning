// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract multiSend{

    constructor(uint _SalaryTime) {
        manager = msg.sender;
        salarytime = _SalaryTime;
    }

    address[] public teams;
    address manager;
    struct WorkerDetails{
        address payable addr;
        uint id;
        uint salary;
        uint JoiningDate;
        uint SalaryDate;
        string position;
        bool paid;
    }

    WorkerDetails[] public TeamsInfo;
    uint Totalworker;
    uint salarytime;

    function WorkerInfo(address payable _addr, uint _salary, uint _JoiningDate, string calldata _position) public  {
        uint salaryInether = _salary * 1 ether; //using this we have convert the amount in ether.
        require(msg.sender == manager, "you are not a manager");
        TeamsInfo.push(WorkerDetails({addr: _addr, id: Totalworker, salary: salaryInether, paid: false, position : _position, JoiningDate: _JoiningDate, SalaryDate: _JoiningDate + 30 seconds}));
        require(block.timestamp >= _JoiningDate, "Joining date not comes right now" );
        Totalworker++;
        teams.push(_addr);
    }

    function PaymentOfSalary() public  payable {
        require(block.timestamp >= TeamsInfo[0].SalaryDate, " Wait for time please.");
        require(msg.sender==manager, "only manager can call");
        for(uint i=0; i < TeamsInfo.length; i++){
            if (TeamsInfo[i].paid==false){
                TeamsInfo[i].addr.transfer(TeamsInfo[i].salary);
                TeamsInfo[i].paid = true;
            }
        }
        salarytime = block.timestamp + 30 days;
    }

}

import "./erc20token.sol";
contract multi {

    Token public token;

    constructor(address tokenAddress){
       token =  Token(tokenAddress);
    }

    function airdrop(address[] memory _adr) public {
        for (uint256 i = 0; i < _adr.length; i++){
            token.transfer(_adr[i], 10);
        }

    }
}