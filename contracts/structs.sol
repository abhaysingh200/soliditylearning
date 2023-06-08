// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract todos{

    struct todo{                         //Todo struct, todos variable
        string text; bool completed;}

    //an array of todo structs

    todo[] public struct1;    
    // if we want to store multiple struct in struct1 then we need to use []

    function create(string memory _text) public {
        //3 ways to initialize a struct
        //--calling it like a function
        struct1.push(todo(_text,false));// this is one method we are calling struct like we call uint.
       
       //key value mapping
   //    struct1.push(todo({text: _text, completed: false}));

       //initialize an empty struct and then update it
    //   todo memory struct2;
     //  struct2.text=_text;
       //todo.completed by default set to false

    //   struct1.push(struct2);
    }  

    //solidity automatically created a getter for struct1. so
    // you dont actually need this function.

    function get(uint _index) public view returns(string memory text,bool completed){
        todo storage localstruct = struct1[_index];
        return (localstruct.text, localstruct.completed);
    } //get function in which we are checking value in struct1

    function update(uint _index, string memory _text) public {
        todo storage localstruct = struct1[_index];
        localstruct.text= _text;

    }// localstruct and struct 1 is of same structure so both will get same values 
    // as struct is array so its can store multiple data thats why need to ask for index no

     //update completed
     //toggle when we click on it become true if again click then false then true.false, etc.

     function togglecompleted(uint256 _index) public {
         todo storage localstruct = struct1[_index];
         localstruct.completed = !localstruct.completed;
     }
     //just assign the value of sruct1 at index to localstruct then print the data of localstruct
      // just doing true or false on struct1 and localstruct struct at specified index
} 
