// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract mappinguse{


    mapping (address=>uint) public mymap;  // we are defining address with unique value 

    function get(address _add) public view returns(uint256){
       return mymap[_add];  // we can only return address because when we input address it gives value and we are also mapping address to uint, so how we can take address with uint.
    }

    function set(address _add, uint256 _no) public {
        mymap[_add]=_no;
    }

    function remove(address _add) public {
        delete mymap[_add];
    }
}

contract nestedmapping{

    //nested mapping means mapping from address to another mapping

    mapping (address=>mapping (uint=>bool)) public mymap; // in this address map in bool

    function get(address _address1, uint256 _i) public view returns(bool) {
        return mymap[_address1][_i]; 
        //why here we take both address and i becuase address can convert in uint but not in bool thats why we need both as first address to uint to bool.
        // address1 is first mapping address then i is second mapping uint so at end address convert to bool
    } 

    function set(address _add, uint256 _no, bool _bol) public {
        mymap[_add][_no]= _bol;
        
    } // we are taking two mapping with two type of keys thats why we need here two keys and value 1 which one is bool

    function del(address _add, uint256 _no) public {
        delete mymap[_add][_no];
    }
}