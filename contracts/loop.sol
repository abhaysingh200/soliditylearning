// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract whileloop{
    //loops takes so many gas fees if we want to used that only used fixed sized array in loops not dynammic.

    uint256[] public abhay;
    uint8 public k=0;

    function get() public returns(uint256[] memory){
        while (k<4){
            k++;
            abhay.push(k);
        }
        return abhay;
    }
}

contract dowhileloop {
    uint256[] public abhay;
    uint256 public k=0;

    function get() public returns (uint256[] memory){
        do {
           k++; 
           abhay.push(k);        
        
        }
        while(k<5);
        return abhay;
    }
      
}

contract forloop{

    uint256[] public data;

    function get() public {
        for(uint256 i=1;i<6;i++){
            data.push(i);
        }
    }  
    // in this we are modifying the state variable so its value print in transaction but we are not returning any value to display the output thats why not giving value in transaction   

    function get1() public returns(uint256[] memory){
        for(uint256 i=1;i<6;i++){
            data.push(i);
        }
        return data;
    } 
    // in this we enter the returns which will return the value of that output in transaction
}