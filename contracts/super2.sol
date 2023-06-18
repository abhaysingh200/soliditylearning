// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract a{

    event log(string message);

    function foo() public virtual {
        emit log("a.foo called");
    }

    function bar() public virtual {
        emit log("a.bar called");
    }
}
//in this we create two function which update the value of event log using emit

contract b is a{

    function foo() public virtual override {
        emit log("b.foo called");
        a.foo();
    }
    function bar() public virtual override {
        emit log("b.bar called");
        super.bar();
    }
}

contract c is a{
    function foo() public virtual override {
        emit log("c.foo called");
        a.foo();
    }
    function bar() public virtual override {
        emit log("c.bar called");
        super.bar();
    }
}

contract d is b,c {
    function foo() public  override (b,c){
        super.foo();
    }

    function bar() public override (c,b){
       super.bar();
    }
}

//using override are are print the function foo() used in b , c and a so when we call these three function foo value will print in log
//value will print from c-> b-> a.
//override(order not matter here d will take c first then check b then he see both using a then a.