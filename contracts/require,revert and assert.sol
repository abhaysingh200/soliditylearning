// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//there are three method to hanlde error 
// require, assert, and revert.

contract requireuse1{
    function checkinput(uint256 value) public pure returns(string memory){
        require(value>5,"not more than 5");
        require(value<=255,"not required value");
        return "input is uint8";
    }
    //require check both required statement if fulfill then it print return if not then error revert the transaction
    // value>5 is the condition if not fulfilled then not more than 5

    function oddschecks(uint256 value) public pure returns (bool){
        require(value % 2 !=0,"this is even no");
        return true;
    }
    //assert refund the gas fees if transaction failed
}


contract assertuse2{

    bool public result; //by default bool is false

    function checkoverflow(uint256 no1, uint256 no2) public {
        uint256 sum=no1+no2;
        assert(sum>=10);
        result= true;
        //return(sum);
    }
    //in return we are assigning message if condition false but not in assert it will give just error not message
    // in this we are updating the result, we no need to write returns.
    //and its not returning any value so value not showing in transaction.
    //when transaction failed or return : 3000000 gas
    //when success :50940 
    //assert never refund gas fees thats why require is more gas efficient but both have different usecases 

    function get() public view returns(string memory) {
        if (result==true) {
           return "no overflow";
        }
        else{
            return "overflow exist";
        }
    }
    
}

contract revertuses{

    bool public result;

    function check(uint256 no1, uint256 no2) public pure returns(string memory){
        uint256 sum= no1+no2;

        if(sum>6 || sum>100){
            revert("under 100");
        }

        else{
            return("errpr giving");
        }

    }
}

//overall:
//dont use assert and revert only use require as where we can enter the condition and also write message in error occurs.