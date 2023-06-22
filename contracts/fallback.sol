// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//in this we are using gasleft to check how much gas we are using.
//and also we are receiving funds in fallback

contract fallbacK{

    event bottom(string func, uint gas);

    //fallback function must be declared as external.
    fallback() external payable {
        //send / transfer(forwards 2300gas to this fallback funcyion)
        //call (forwards all of the gas)
        emit bottom("fallback", gasleft());
    }//in this we are using less emit so less gas we find, so tranfer is sucess. same for send also.

    //receive is a variant of fallback that is triggered when msg.data is empty
    receive() external payable {
        emit bottom("receive", gasleft());
    }

    //helper function to check the balance of this contract
    function balancw() public view returns (uint){
        return address(this).balance;
    }

    
}

contract sendtofallback{
    function transfertofallback(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function callfallback(address payable _to) public payable {
        (bool sent,) = _to.call{value: msg.value,gas:5000}("");
        require(sent, "failed to send ether");
    }
}