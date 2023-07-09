// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//note deploy this contract first
//delegatecall = allows the called contract to access and modify the storage of the calling contract.
//note when we use delegate _targetcontract.delegate= its called the target(setvalue) to access, use this format
//and modify the storage of caller state variable value. thats why updating the value in caller not in target.
//the value will update in upper varibale like if value in on 2 no and on 1 is like uint256 public no then the value added in no.
//thats why I place value on top then num(num have no usecase right now).

//call = operates within the context of the called contract and modifies its own storage.
//when we use call _targetcontract.call = its called to target to access and also modify the target value,
//so when we give value in caller its update in target value not in our caller value.

//abi.encode= to use the other contract function we use this thing to access the other contract function 
//to use that we need to know the name of that function with its paramter type that setvalue(uint256) and also give value
//when we give this to abi it convert the code in encoded and call will forward to target contract then this contract
//decode the code and check what he need to update so he update its storage value of value using call.

contract Caller {
    uint256 public value;
    uint256 public num;

    function setValue(address _targetContract, uint256 _value) public payable  {
        // Perform the delegatecall to set the value in the calling contract
        (bool success,) = _targetContract.delegatecall(abi.encodeWithSignature("setValue(uint256)", _value));
        require(success, "Delegatecall failed");
    }

}

contract Target {
    uint256 public value;

    function setValue(uint256 _value) public  {
        value = _value;
    }
}