// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//rules:  participate must have a wallet.
// a participant can transfer ether more than one time but the transfered ether must be 2 ether.
//as the participant will transfer ether its address will be registered.
//manager will have full control over the lottery.
//the contract will be reset once a round is completed.

contract Lottery{
    address public manager;
    //use array because so many user so we need to make all to them payable to give rewards.
    address payable[] public participants;  
    address payable public winner;

    constructor(){
        //now manager is deployer of our contract.
        manager=msg.sender;
    }

    receive() external payable {
        require(msg.value>=2 ether,"fine");
        //here we add the ether sender in participants, and make it payable so he can send ether, if we dont use it then cant send ether.
        participants.push(payable(msg.sender));
    }

    function getbalance() public view returns(uint){
        //check that only manager can run this function.
        require(msg.sender==manager,"sorry");
        return address(this).balance;
    }


//latter check this
    //function getparticipantbalance() public view returns(uint){
      //  return participantBalances[msg.sender];
    //}

    function random() internal view returns(uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, block.number)));   
    }
    //using internal its not visible in deploy, if we do it external then other contract can see random().

    function selectwinner() public {
        require(msg.sender==manager,"not you are manager");
        require(participants.length>=3);
        uint r=random(); //in this we take the random number giving in random function 213213213245447435....

        //in this index we take uint r and divide it with participant lenght, and % always gives reminder
        //like 432432434 % 4, always gives reminder less than 4 like 0,1,2,3 so these are the index of participants lenght which we want.
        //this will gives us any no. of which we consider it index and assign it winner.
        uint index = r % participants.length;
        winner=participants[index];
        winner.transfer(4 ether);
        //in this we send 2 ether to winner
        //we can also do more thing like (address(this).balance)/2;

            delete participants;
            //this will remove all participants from array.
    }

//note if use in metamask then take the contract address and use other wallet and send ether on contract address and send the ether.
//and when we run the select winner 
}