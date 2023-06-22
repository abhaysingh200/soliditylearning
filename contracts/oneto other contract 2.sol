// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//when you use the new keyword to create a contract instance, 
//it is deployed on the blockchain as a separate contract.

contract Car{
    string public model;
    address public owner;

    constructor(string memory _model, address _owner) payable {
        model=_model;
        owner=_owner;
    }
}

contract CarFactory{

    Car[] public cars;

        function create(string memory _model) public {
            Car car = new Car(_model,address(this));
            cars.push(car);
            //when we use create fun. new car is the instance so when we use this
            //and the contract address of that instance is obtained.
            //and store the address in array.
            
        }
        //using new we create new contract from other contract. 
        //using new we create new contract, after that give name which contract you want.

        function createandsendether(address _owner, string memory _model) public payable {
        Car newvar= new Car{value:msg.value}(_model,_owner);
        //in this we are creating new instance(duplicate) of Car contract with name "newvar". Its a local variable.
        //after we create new instance without giving its name using new Car because we want to use it only one time.
        //and we want that when we create newvar its should show model,owner and have ether also
        // for that we using car{value:msg.vakue} ,etc. so this only run one time at deploy time.
        //and using this we can send ether from this contract to newly created contract.
    }
}