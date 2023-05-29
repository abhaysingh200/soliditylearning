// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ifelse{

    uint256 public mynum=10;
    string public mynum2;

    function get(uint256 no) public {
        if(no==10){
            mynum2="greater than 10";
        }
        else if(no==0){
            mynum2="equal to zero";
        }//both they gives zero but this is upper so first it check this end here.
        else{
            mynum2="less than 10";
        }
    }

    function shortmethod(uint256 no) public returns (string memory){
        return (no==5 ? mynum2="equal to 5" : (no>5 ? mynum2="ok" : mynum2="less then5"));       
    }

// get function takes low gas 31435 
// shortmethod function takes more gas than get function 52572 

}