// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//interface: how you can access the data of a different contract address through the interface.
//interface: you can interact with other contracts by declaring an interface.
//interface is used to make a common structure that mostly other contract want like we can make a function
//that every contract need so they can use our strucutre.

//interface
//1.  cannot have any function implemented
//can inherit from other interfaces
//all always or declared function must be external
//cannot declare a constructor.

contract counter{
    uint public count;

    function increment() external {
        count +=1;
    }

    function getcount() external view returns (uint){
        return count;
    }
}

interface icounter {
    function count() external view returns (uint);
    function increment1() external ;
// interface mean that if we give any contract address and he use this structure we can access the value and output of that contract address
// The benefit of using interfaces is that they provide a way to interact with external contracts without knowing their internal implementation.
// You only need to know the structure of the functions and variables you want to interact with.


}//we cant declare varibales,constructor into interface.
//in interface we cant define the implementation like we cant able to give value of function
//as we are not able to return something or giving any output to other
//we can only give a structure which other contract use that structure.


contract mycontract{
    function incrementcounter(address _counter) external{
     icounter(_counter).increment1();
    }//this means that we check this address fulfill the condition of icount increment function
    //if yes then return what he doing as counter increment function fulfill and return count +1,
    //so when we call this function count will increase by 1.

    function getCount(address _counter) external view returns (uint) {
        return icounter(_counter).count();
    }
    //if we enter the address of contract counter then we get same value of count returning in getcount 
    //function in counter so of which address we enter the value return of that.
}

//uniswap example

interface UniswapV2Factory {
    function getPair(address tokenA, address tokenB) external view returns (address pair);
}

interface UniswapV2Pair {
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
}

contract UniswapExample {
    address private factorycontract = 0x358AA13c52544ECCEF6B0ADD0f801012ADAD5eE3;
    address private daitoken = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
    address private wethtoken = 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db;

    function getTokenReserves() public view returns (uint, uint) {
        address pair = UniswapV2Factory(factorycontract).getPair(daitoken, wethtoken);
        (uint112 reserve0, uint112 reserve1, ) = UniswapV2Pair(pair).getReserves();
        return (reserve0, reserve1);
    }
}

//what is instance
//we can create a child of any parent .
//like uniswapexample child1= new uniswapexamples(); so in this we make a instance child1 of getotkwnservices
// to become interface function need to make same argument takes in interface function same implementation function name will different not matters.
//and the contract become a interface not function in contract we want same functionalitites like that contract must have 2 functions with same working like in interface.
// if the contract has four functions, and two of them match the functionality defined in the interface.
