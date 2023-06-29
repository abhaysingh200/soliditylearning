// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract lockedcrypto{

    struct userdetails{
        address payable user;
        uint amount;
        uint lockedperoid;
        uint id;
        uint orderid;
    }

    mapping (address => mapping(uint=> uint)) public lockedtime;
    mapping (address => mapping(uint=> uint)) public usersamount;
    mapping (address => uint[]) usersid;
    mapping (address => uint[]) ordersid;

    userdetails[] public Alldetails;  //this is the struct array it just like a medium in which we assign struct array, using this we can access that.
    uint latestusers;
    uint latestorder;

    event userdetailss(address user, uint depositamount, uint lockdate, uint userid, uint orderid);

    function deposit(uint _lockedperoid) public payable { 
        require(msg.value > 0 ether, "deposit must be more than 0 ether");
        Alldetails.push(userdetails({user: payable(msg.sender), amount: msg.value, lockedperoid: _lockedperoid, id: latestusers, orderid: latestorder}));

        lockedtime[msg.sender][latestorder] = block.timestamp + (_lockedperoid + 30 seconds);
        usersamount[msg.sender][latestorder]= msg.value;
        usersid[msg.sender].push(latestusers);
        ordersid[msg.sender].push(latestorder);

        emit userdetailss(msg.sender, msg.value, _lockedperoid, latestusers, latestorder);
        latestusers += 1;      
        latestorder +=1;       
    }

    function withdraw(uint orderid) public payable  {
        require(usersamount[msg.sender][orderid] > 0, "you are not a member");
        require(block.timestamp >= lockedtime[msg.sender][orderid], "locked time remains right now");
        payable(msg.sender).transfer(usersamount[msg.sender][orderid]);
        delete Alldetails[orderid];
    }

    function getUserOrders(address userAddress) public view returns (uint[] memory) {
        return ordersid[userAddress];
    }

    function getUserid(address userAddress) public view returns (uint[] memory) {
        return usersid[userAddress];
    }


}