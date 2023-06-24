// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//keccak256 takes input bytes and he returns the hash of 32 byest
//sha256 takes input bytes and he returns the hash of 32 bytes.
//ripemd160 takes input bytes and he returns the hash of 20 bytes.

//Hash: A hash function is a mathematical algorithm that takes an input (data) and produces a fixed-size output, known as a hash.
//Hash always give same hash for same input.
//it give you different hash is their is any minor change in hash.
//its not possible to return the value from hash.

//Hash usecase:  securely store passwords, contract signatures, and ensure the authenticity of messages or files.
//But how to convert our data to bytes:
//there are 2 inbuilt function that convert any data to bytes
//1. abi.encode  2. abi.encodepacked.  then we gives this bytes to sha, keccak or ripemd to convert it to hash.
//the size of hash bytes is 32, 32 and 20. We can give unlimited bytes of data to convert it into hash.

//These three cryptographic has own different algorithm to change the hash
//thats why after same input they are showing different hash.


contract hashfunc{

//here we use abo.encodepacked.

    function hashkeccak256(uint _x, string memory name, address _add) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_x,name,_add));
    }

    function hashsha256(uint _x, string memory name, address _add) public pure returns(bytes32){
        return sha256(abi.encodePacked(_x,name,_add));
    }

    function hashripemd160(uint _x, string memory name, address _add) public pure returns(bytes20){
        return ripemd160(abi.encodePacked(_x,name,_add));
    }

//here we use abi.encode.

    function hashkeccak(uint _x, string memory name, address _add) public pure returns(bytes32){
        return keccak256(abi.encode(_x,name,_add));
    }

    function hashsha(uint _x, string memory name, address _add) public pure returns(bytes32){
        return sha256(abi.encode(_x,name,_add));
    }

    function hashripemd(uint _x, string memory name, address _add) public pure returns(bytes20){
        return ripemd160(abi.encode(_x,name,_add));
    }

//both abi.encode and abo.encodepacked gives different hash as both have other method so hash will also be different.    

//hash collision can occur when you pass more than one dyanmic data type to abi.encodepacked.

function collision(string memory _text, string memory _anothertext) public pure returns(bytes32){
    //encodepacked(AAA, BBB) -> AAABBB
    //WHEN we enter the input abhi takes input in this format. and output in this AAABBB format.
    //encodepacked(AA, ABBB) -> AAABBB if giving like this then again giving us in same format.
    return keccak256(abi.encodePacked(_text, _anothertext));
   } //in this  i take abc,def gives hash 0xacd0c377fe36d5b209125185bc3ac41155ed1bf7103ef9f0c2aff4320460b6df .

   function collision1(string memory _text, string memory _anothertext) public pure returns(bytes32){
    return keccak256(abi.encodePacked(_text, _anothertext));
   } //in this i take ab,cdef gives same hash 0xacd0c377fe36d5b209125185bc3ac41155ed1bf7103ef9f0c2aff4320460b6df
//thats why dont use two datatype argument in single function.
}

contract guessthemagicword{
    bytes32 public answer;

    function foo1() public returns(bytes32){
       return answer=keccak256(abi.encodePacked("Solidity"));
    }

    function foo(string memory _name) public view returns(bool){
       return keccak256(abi.encodePacked(_name))==answer;
    }
}