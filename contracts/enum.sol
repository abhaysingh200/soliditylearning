// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract enumuse{

    //enum representing shipping status
    //enum is like a struct, in which we assign enum data and use then in other functions,variables,etc.
    //

    enum status{
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled}
    

    status public status1; // we are using enum status
    //return uint
    //pending-0
    //shipped-1, accepted-2, rejected-3,canceled-4
    //this datatype is in array

    function get() public view returns (status){
         return status1;
     }

     //like we returns uint,string in this we return enum becuase enum is same using method like uint,string datatypes

    function set(status _statuswe) public {
        status1=_statuswe;
    }

    function cancel() public {
        status1=status.Canceled;
    }

    function set2() public {
        delete status1;
    }

    function set3(uint256 _index) public {
        require(_index<5,"invalid index");

        if (_index==0){
            status1=status.Pending;
        }
         else if (_index==1){
            status1=status.Shipped;
        }
         else if (_index==2){
            status1=status.Accepted;
        }
         else if (_index==3){
            status1=status.Rejected;
        }
         else if (_index==4){
            status1=status.Canceled;
        }

    }
}    
