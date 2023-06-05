// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// modifier are code that we can run before and after the function call
//mostly use for 3 reasons
//validate data, restrict access, guard against reentrancy hack.

contract modifieruses{

    address public  owner;
    uint256 public x=10;
    bool public locked;

    constructor(){
        owner=msg.sender;
    }

    modifier onlyowner(){
        require(msg.sender==owner, "you are not landlord");
        _;
    }

    modifier validaddress(address _address){
        require(_address !=address(0), "not a valid address");
        _;
    }

    function changeonwer(address newaddress) public onlyowner validaddress(newaddress) { 
        owner=newaddress;
        
    }

    modifier noretrency(){
        require(!locked, "no retrency");
        locked=true;
        _;
        locked=false;

    //the assignment locked = true used to prevent from user if he tries to run the function again during the execution, as if he tries then locked is true which gives !locked to false and error; The assignment locked = false; afterward is used to unlock the contract for subsequent calls.
      //in this modifier we are not assiging anything like if (i>2,"bd") if we write this then require check if condition is false then its give bd
      //but right now we are using !locked that mean !locked=? if true come then go down if false then give error
      //here require check by using true or false, as we are assiging here that !locked which means if !locked we get true then executes next code if false then stop here
      //(true,"no retrency") overall condition is this as !locked check and he get true as locked is false, if locked is true then its check that !locked is false so (false," noreetrency") which print error. 
    } // _; represent that before this modifier run before function call when modifier complete function call and exeutes after that any query written will run in modifiers.

    function decrement(uint256 i) public noretrency{
        x-=1;
        if(i>1){
            decrement(i-1);
        }
    }
    // as 5>1 check its need to run the code again, so code will start from decrement(uint256 i) which we assign value in below decrement(i-1) which one 4 so its not ask for new value then go to modifier
    //now modifier have locked value true so now condition !locked gives false, which mean false gives us error/
    //in this function we use newaddress after validaddress because in valid modifier we are taking _address so we need address to check thats why its need.
    // when we deploy then need to copy the other address and come in default(msg.sender address) and run the function because we are using modifiers in function so it check when function run.
}