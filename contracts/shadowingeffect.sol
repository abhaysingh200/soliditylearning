// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//using this we can update the state variable value in child contract.

contract a{

    string public name="contract a";

    function getname() public view returns (string memory){
        return name;
    }
}

//shadowing is disallowed in solidity 0.6
//this will not compile
//contract b is a{
//     string public name="contract b";
// }

contract c is a{
    //this is the correct way to override inherited state variables.
    function set(string calldata _name) public {
        name=_name;
    }
}