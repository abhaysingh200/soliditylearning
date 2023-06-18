// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//visibility
//public: all variables and functions can access internal and external contracts. everyone can use.
//private: only inside the contract that defines the function.
//internal:  the internal visibility modifier allows access to internal variables and functions within the same contract and any derived contracts that inherit from it.
//external: only other contracts and accounts can call.

contract base{

//1. private function can only be called inside this contract.
         //contract that inherit this contract cannot call this function.

    function privatefunc() private pure returns (string memory){
        return "private function called";
    }

    function testprivatefun() public pure returns (string memory){
        return privatefunc();
    }


//2.    internal function can be called inside the contract,
    //and inside the contract that inherit this contract.

    function internalfun() internal pure returns (string memory){
        return "this is internal use.";
    }
    function internaltest() public pure virtual returns (string memory){
        return internalfun();
    }


//3.     public function can be called
       //inside this contract
       //inside contract that inherit this contract by other contracts and accounts.

    function publicfun() public pure returns (string memory){
        return "public function called";
    }

//4.    external function can only be called by other contracts and accounts.

    function externalfunc() external pure returns (string memory){
        return "external function called";
    }
    //this function cant called by public keyword also it can only called outside the contract.

    //state variables
    string private privatevar = "my private variable";
    string public publicvar = "my public variable";
    string internal internalvar= "my internal variable";
 
    // variables cannot be external so this code wont compile.
    //private and internal not have visibility.
}

contract child is base{
    function test2() public pure returns (string memory){
        return internalfun();
    }
}
// in this we can check we cant access private function from outside the contract, inside the contract we can use.
//in inherited we can access the internal function.
//we cant access private  function or variables.
//we can access external(not use is and address must use there), internal and public function or variables.