// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract viewuses{

    uint256 public sum=25;
    uint256 public sum1=30;

    function add() public view returns (uint256,uint256){
        uint256 no1=5;
        uint256 no2=6;
        uint256 product=sum*sum1;
        uint256 total=no1*no2;
        return(total,product);
        
    }
    //when we want to just reading or using the value from state variable or making any changes in local variables we use view.
    //in this we are not defining in returns so that why we need to define the uint256 before the product and total
}

contract withoutviewandpure{                
    uint256 public abhay;
    function get() public returns (uint){
        uint256 aman=54;
        abhay=aman+1;
        return aman;
    }
    //important:
    //as this function make changes in state variables so it have green tick means it store in blockchain and we have hash which represent it store in blockchain
    // other those dont have green tick and hash means they store in storage or memory
    // as we are access or viewing the state variable thats why its not give us green tick
}
contract pureuses{

    function getresults() public pure returns(uint256 product, uint256 total){
        uint256 num1=5;
        uint256 num2=6;
        product=num1*num2;
        total=num1+num2;
        
    }
    //if we are only make changes in local variables and not using the values from outside the function then we use pure.
    //in this we are defining the product in uint256 , so thats why we dont need to add uint before product and total
}