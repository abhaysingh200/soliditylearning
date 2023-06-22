// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Car{
    address public owner;
    string public model;
    address public carAddr;

    constructor(address _owner,string memory _model) payable {
        owner=_owner;
        model=_model;
        carAddr= address(this);
        //this is the address of this contract you can check
       //caraddr(0x93f8dddd876c7dBE3323723500e83E202A7C96CC)
      //contract(0x93f8dddd876c7dBE3323723500e83E202A7C96CC)
    }
}

contract CarFactory{
    Car[] public cars;
    //this car gives the contract address of new car.

    function create(address _owner, string memory _model) public {
        Car car = new Car(_owner,_model);
        cars.push(car);
    }//new create new contract and of which we want we use Car, and what variable
    //name we need to assign we use Car car(name)

    function createAndSendEther( string memory _model) public payable {
        Car car= new Car{value : msg.value}(address(this),_model);
        cars.push(car);
    }

    function getCar(uint _index) public view returns(address owner, string memory model, address carAddr, uint balance) {
        Car car = cars[_index];
        return (car.owner(), car.model(), car.carAddr(), address(car).balance);
    }
}