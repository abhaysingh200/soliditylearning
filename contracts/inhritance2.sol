// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract a{

    function foo() public pure virtual returns (string memory){
        return "a";
    }
     function foo1() public pure virtual returns (string memory){
        return "g";
    }
}

contract b is a{
    function foo() public pure override virtual  returns (string memory){
        return "b";
    }
}

contract c is a{
    function foo() public pure virtual override returns (string memory){
        return "c";
    }
}

contract d is c,b{
    //d. foo() returns "c"
    //since c is on the right side so parent contract with function foo c
    //as both have same data but c is on right side so it takes value of c

   function foo() public pure override(b,c) returns (string memory){
        return super.foo();
   } 
}

contract e is c,b{
    //e.foo() returns "b"
    //since b is the right most parent contract with function foo()
    function foo() public pure override (c,b) returns (string memory){
        return super.foo();
    }
}

//swapping the order of a and b will throw a compilation error.
contract f is a,b{
    function foo() public pure override(b,a) returns (string memory){
        return super.foo();
    }
}

contract Parent {
    uint public value;

    function setValue(uint _newValue) public virtual  {
        value = _newValue;
    }
}

contract Child is Parent {
    function setValue(uint _newValue) public override {
        super.setValue(_newValue * 2);
    }
}

// The purpose of super is to enable the child contract to build upon the functionality defined in the parent contract. It provides a way
// to extend or modify the behavior of the parent contract while maintaining access to its original logic.