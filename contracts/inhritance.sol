// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//using inheritance we can access any contract properties, like in b is a,
//that mean b is become a child of a so he can access all data and modify the data on his contract not in a.
//using virtual we give access to child contract to edit the value on his contract,
//and using override we can change the child contract data.
//when we change data in b its not affect on a data.
//The child contract can directly access and modify the inherited data state variable without any special modifiers or the use of the virtual keyword.

contract a{

    uint256  public no=10;
    address public  OWNER =msg.sender;

    function fun1() public pure returns (string memory){
        return ("i am fun1");
    } //by default it store in memory if we not assign

     function fun2() public pure returns (string memory){
        return ("i am fun1");
    }

    function fun3() public pure virtual returns (string memory){
        return ("i am fun1");
    }

    function fun4() public pure virtual returns (string memory){
        return ("i am fun1");
    }
}

contract b is a{

    function fun3() public pure virtual override returns (string memory){
        return ("i am funb");
    }

    function fun4() public pure  virtual override returns (string memory){
        return ("i am funb");
    }
}

contract c is b{

     function fun4() public pure virtual override returns (string memory){
        return ("i am fun c");
    }
}

contract d is a{

    function set(uint _data) public {
        no=_data;
    }
}






