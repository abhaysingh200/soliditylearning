// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract constantsuses{

//constant saves our lot of gas fees and we can only use those variable which value we not change in future as we cant change its value
//only update the value from here, not from other variable or function

    uint256 public abhay=7;            //this cost 2429 gas
    uint256 public constant ABHAY=7;   //this cost 307 gas
    uint256 public abhay1=ABHAY;       //this cost 2429 gas

    function print() public pure returns(uint256){       //this cost 2415 gas
        return ABHAY;
    //Since the function is not accessing any state variables and is only returning the value of the constant state variable ABHAY, you can mark it as pure.    
    //pure can access constant state variables
    }

       
}
