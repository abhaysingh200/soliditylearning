// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract datatypes{

    bool public bool1; //by default it false
    bool public bool2= true;

    uint8 public aman;// range is 255[1 to 255 no.] //why we use different as it saves our gas fees
    uint16 public aman1l;
    uint public aman2; // uint default value is 256
    uint256 public aman3; //uint only for positives no

    int256 public ama1 =12; //its range from -2** 255 to 2**255 -1
    int8 public ama2= -43;

    int public minint = type(int).min;
    int public maxint = type(int).max; //gives us max value we can use in int

    //bytes will more efficient than string it takes low fees at a time of deployment
    // but if dont have specfic value then bytes take high gas so bytes who usefull for gas fees as we have a defined data type
    bytes1 public   check1 = 0xbb;
    bytes1 public check2 =0x56;

    address public address1;
    address public address2= 0xCD38D2eF21f029C5d5ac65E30a1EB22fc8BabE59;

}