// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//in this we create a voting system, in which company can create industry, and user vote to them whom they like,
//more liker got winner and that industry will get funds that voters put in contract.
contract voting{

    address public manager;
    uint totalusers;
    uint target;
    uint time;
    mapping (address=>uint) public useramount;
    mapping (address=>bool)  voted;
    mapping (uint=> createindustry) public convertuint;
    uint industryplus;

    modifier onlymanager() {
        require(msg.sender==manager);
        _;
    }

    modifier timeremaining() {
        require(block.timestamp < time);
        _;
    }

    constructor(uint _target, uint _time) {
        target=_target;
        manager=msg.sender;
        time=block.timestamp+_time;
    }

    struct createindustry{
        string name;
        string Industrytype;
        uint totalvote;
        address payable industryaddress;
    } 

    function createIn(string memory _name, string memory _type, address payable _addrindus) public timeremaining onlymanager {
        //here we use storage because if we want to give this value to createindsutry strcut then need
        //because struct is storage and if use memory then it store the value untill the function running after that value will 0.
        createindustry storage newindus = convertuint[industryplus];
        newindus.name=_name;
        newindus.Industrytype=_type;
        newindus.industryaddress = _addrindus;
        industryplus++;
    }

    function deposit() public payable timeremaining {
        require(msg.value>=100 wei,"deposit the min required amount");
        useramount[msg.sender] = msg.value;
        require(address(this).balance <= target, "you have reached to funds");
        totalusers++;
    }

    function votehere(uint _industryno) public timeremaining {
        require(voted[msg.sender]==false,"already voted");
        require(useramount[msg.sender]>=100 wei, "you are not participater");
        createindustry storage industryname = convertuint[_industryno];
        industryname.totalvote ++;
        voted[msg.sender]=true;      
    }

    function releasedpayment(uint _industryno) public payable  onlymanager{
        require(address(this).balance>=target, "minmum fund not reached");
        createindustry storage payment = convertuint[_industryno]; 
        require(payment.totalvote >= totalusers/2, "you are not eligible");
        payment.industryaddress.transfer(address(this).balance);

    }
}
