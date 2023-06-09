// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract functionuse{
    //function can return multiple values.

    function returnmany() public pure returns (uint,bool,uint){
        return (2,true,4);
    }// in this we have to define return same orders

    function names() public pure returns (uint x, string memory y, bool z){
        x=2;
        y="aman";
        z=true;
        return (x,y,z);
    }//always need to make order when return

    function destructuringassignments() public pure returns (uint,bool,uint,uint,uint){
        (uint i, bool b, uint j)  = returnmany();

        //some values left.
        (uint x, uint y)=(3,5);
        return (i, b, j, x,y);
    }// in this we take some value from other function values and some from another.
    //also need to take that amount of no using in returnmany, like it has 3 value then we need to take 3 value from there.
  
 //important : Keep in mind that mappings cannot be passed as arguments to functions, but you can use them as local variables or return values within a function.
 
    //we can use array for input
   uint[] public arr;
    function arrayinput(uint[] memory _arr1) public {
        arr.push(_arr1[0]);
    } //in this we need to define that we want [0] index value because value come in that form.

    //we can use array for output
    
    function arrayoutput() public view returns (uint[] memory){
        return arr;
    }

}


    //call function with key-value input   

contract xyz{

    function somefunctionwithmanyinputs(uint x, uint y, uint z, address a, bool b, string memory c) public pure returns (uint){
    }
    //using value
    function callfunc() public pure returns (uint){
        return somefunctionwithmanyinputs(3,4,2,0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,true,"aman");
    }
    //using key
    function callfunwithkeyvalue() external pure returns (uint){
        return (somefunctionwithmanyinputs({x:3, y:4, z:6, a:0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, b:true, c:"aman"}));
    }

}    
