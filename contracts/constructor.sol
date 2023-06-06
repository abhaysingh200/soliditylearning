// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//base contract x
contract x{
    string public name;

    constructor(string memory _name) {
        name= _name;
    }
}

contract y{

    string public text;

    constructor(string memory _text){
        text = _text;
    }
}

//there are 2 ways to initialize parent contract with parameters

//pass the parameters here in the inheritance list( meaning extend the contractor's attributes and properties to their derived contracts.
contract b is x("input to x"), y("input to y"){ 

} // its means we are passing the argument needs in x costructor so thats why when we call b at name we get name value input to x and similar to y

contract c is x,y{
    //pass the parameters here in the constructor,
    //similar to function modifiers.
    constructor(string memory _name, string memory _text) x(_name) y(_text){

    }// in this we access x,y and now we make constructor in which we pass argument of construcotr c to x,y arguments.
}

contract d is x,y{
    constructor() x("x was called") y("y was called"){

    }// this is another method
}

contract e is x,y{
    constructor() y("y was called") x("x was called"){
    }
}


// x and y are parent contract and other are subcontracts
