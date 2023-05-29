// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract nftcount{

    uint public totalnft;

    function addnft() public {
        totalnft++;
    }
    function removenft() public{
        totalnft -=1;
    }
}