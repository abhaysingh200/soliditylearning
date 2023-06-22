// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//libaray same like a contract, but i have some restrictons
//only pure and view function in libaray can used in outside contract
//library cannot have a state variables
//a library cannot inherit any element.
//a library cannot be inherited.


library mylibrary{
    struct player{
        uint score;
    }
    function incrementscore(player storage _player, uint points ) public {
        _player.score += points;
    }// we use player in argument to make changes in struct and use storage
    //because data will be permanent in struct otherwise its discard after sucessfull run.
    
    function add10(uint a) public pure returns(uint){
        return a+10;
    }
}

contract mycontract{
    //external takes low fees compared to public.
    function foo() external pure returns(uint){
        uint result = mylibrary.add10(11);
        return result;
    }
}

library array{
    function remove(uint [] storage arr, uint index ) public {
       require(arr.length > 0, "cant remove from empty arra");
       arr[index] = arr[arr.length-1];
       //we just assign the index to length same then then remove last value.
       //arr[1]=arr[3-1]=2, so arr[1]=arr[2] so now arr2 value print samein arr[1], arr[0,2,2]
       arr.pop(); //using this we pop last so we get arr[1,2].
    }
}
contract testarray{
    using array for uint[];
    //using this we can assign function of array library
    uint[] public arrj;

    function testarrayremove() public {
        for (uint i =0; i<5; i++){
            arrj.push(i);
        }

        arrj.remove(4);
        //assert(arrj.length==2);
      //  assert(arrj[0]==0);
       // assert(arrj[1]==2);
    }

    function arrw() public view returns(uint){
        return arrj.length;
    }
}