// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract functions{

    uint256 public a=10;
    uint public b=10;
    function getadd(uint d, uint c) public {
        uint sum=d+c;
        uint sum2=a+b;
        b=sum2+sum;


    }
}

contract statevariables{

    bytes public stringname="abhay";
    bytes public stringempt;
    uint256[] public aman;
    uint256 public abhay=6;                         //variable create outside the function and inside the contract are state variable

}

contract localvariables{

    uint public NO;
    function get() public pure returns (uint){      // get is the function so its not showing value
        uint256 abhay=4;                            //local variable define in the functions, and its not store in blockchain
        uint256 abhayt1=3;
        uint256 sum=abhay+abhayt1;                  //if we only edit localvariabe then we can get the value of sum
        //NO=sum;                                   //we are editing the state variable that why function not giving us the value
        return(sum);
           }
}

// IMPORTANT:
// if we update the value using function so it will create a transaction as it store in the blockchain
//if function only changes in the local variable then the transaction not created and not store in blockchain

 
contract globalvariables{

    address public owner;

    constructor (){  
        owner=msg.sender;
    }
}
 // we are using contructor as it takes value at a time of deployment and cant change its value later, but we can change value using function.   
//when we call constructor so by which address we are deploy contract msg.sender make him the owner.
//their are so many global variables like

contract globalvariables1{     
    address public owner1;
    address public myblockhash;
    uint256 public gaslimit;
    uint256 public timestamp;
    uint256 public gasprice;

    constructor (){
        owner1=msg.sender;
        myblockhash= block.coinbase;
        gaslimit=block.gaslimit;
        timestamp= block.timestamp;
        gasprice= tx.gasprice;
// these are the few example there are so many global variables 
    }

} 