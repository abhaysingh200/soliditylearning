// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Foo{
    address public owner;

    constructor(address _owner){
       // require(_owner !=address(0),"invalid address");
        //assert(_owner != 0x0000000000000000000000000000000000000001);
        require(_owner != address(0), "invalid address");
        require(_owner != address(1), "invalid address");
        //this require return the gas if invalid address and assert never return gas so best is require.

        owner=_owner;
    }

    function myfunc(uint x) public pure returns(string memory){
        require(x !=0 ,"require failed");
        return "my func was called";
    }
}

contract Bar{
    event Log(string message);
    event LogBytes(bytes data);

    Foo public foo;
    //It means that other contracts or external entities can access this variable and retrieve its value.

    constructor (){
        //this Foo contract is used for example of try catch with external call
        foo = new Foo(msg.sender);
        //we are making owner to those who call this.
        //new are creating a separate duplicate contract of Foo so all things or same format now we have in new contract.
        //and assign that contract address to foo.
        //so if we made any change it will change in foo content it will not update in Foo contract.
    }

    //example of try / catch with external call
    //trycatchexternalcall(0) => log("external call failed")
    //trycatchexternalcall(1) => Log("my func was called")
    function trycatchexternalcall(uint _i) public {
        try foo.myfunc(_i) returns(string memory result){
            emit Log(result);
        }//The result variable is automatically assigned the return value of the myfunc function. 
        catch {
            emit Log("external call failed");
        }
    }

    //example of try/catch with contract creation
    //trycatchnewcontract(0x0000000000000000000000000000) = >Log("invalid address")
    //trycatchnewcontract((0x0000000000000000000000000001) = >Log("invalid address")
    //trycatchnewcontract((0x0000000000000000000000000002) = >Log("invalid address")

    function tryCatchNewContract(address _owner) public {
        try new Foo(_owner) returns(Foo newfoo){   //if logic is successfull then address  of instance assigned to foo variable type of Foo.
            //you can use variable foo here
            emit Log("Foo created");
        }
        catch Error(string memory reason) {
            //catch failig revert() and require()
            //its auto check that if function not fulfill then he runs the return and use the require function() and print its data.
            emit Log(reason);
        }
        catch (bytes memory reason){
            //catch failing assert()
            //this catch the assert and print it data.
            emit LogBytes(reason);
        }
    }
}