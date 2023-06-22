// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IERC20 {
    function transfer(address , uint )external;  
}

contract Token{
    function transfer(address , uint) external {

    }
}

contract abiencode{
    function test(address _contract, bytes calldata data) external {
        (bool ok,) = _contract.call(data);
        //just transfer the data to this _contract address using call.
        require(ok, "call failed");
    }

    function encodewithsignature(address to, uint amount) external pure returns(bytes memory){
        //type is not checked- "transfer*(address, uint)"
        //address we need to pass of token contract.

        return abi.encodeWithSignature("transfer(address,uint256)", to , amount);
        //using this signature we can access any contract and its functions.
    }//we use token function transfer, and pass to and amount arguments.

    function encodewithselector(address to, uint amount) external pure returns (bytes memory){
        //type is not checked- (ierc20.transfer.selector, true , amount)
        //using this selector we can access the interface.
        return abi.encodeWithSelector(IERC20.transfer.selector, to, amount);
    }

    function encodecall(address to, uint amount) external pure returns(bytes memory){
        //typo and type error will not compile
        return abi.encodeCall(IERC20.transfer,(to,amount));
    }
}

//0xa9059cbb000000000000000000000000e
//this 0x is the adress of our wallet
//5f2a565ee0aa9836b4c80a07c8b32aad7978e220000000000000000
//this 5f is the contract address which we pass to argument
//000000000000000000000000000000000000000000000041
//41 is the number which we pass