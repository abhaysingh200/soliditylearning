// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


contract array{

     //dyanmic sized array
    uint256[] public arr;
    uint[] public arr2=[1,2,4];

    //fixed sized array

    uint256[10] public array1;

    function get(uint256 i) public view returns (uint256){
        return (arr2[i]);
    }

    // in solidity we can return entire array but this function should avoid for that
    // array that can grow unlimite in lenght takes so many gas which not a good practise

    function get1() public view returns (uint256[] memory){
        return arr;
    }

    function add(uint i) public {
        arr.push(i);
    }// append to array
    //this will increase the array lenght by 1

    function remove() public {
        arr.pop();
    }

    function lenght() public view returns (uint256) {
       return arr.length;
    }

    function remove(uint256 index) public {
        //delete does not change the array lenght
        //it resets the value at index to its default value
        delete arr[index];
    }

}