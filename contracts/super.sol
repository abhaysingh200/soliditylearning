// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract a{

    function foo() public pure returns(string memory){
        return "greeting to a";
    }
}

contract b is a{

    function checksuper() public pure returns(string memory){
        return a.foo();
    }
    
    function checksuper2() public pure returns (string memory){
        return super.foo();
    }
}
//super we use because as if their are so many contract and we know that the name of function which we want to return
// so we can use super their as super check where is the foo function print the foo
//if we dont use foo then we need to tell that a.foo() we need to tell that contract a has foo.