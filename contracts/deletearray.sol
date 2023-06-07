// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract removearray{

    uint256[] public arr1=[1,2,3,4];

    function remove(uint256 index) public  returns(uint256[] memory){
        require(index<arr1.length,"index out of range");
        for (uint i= index; i<arr1.length-1; i++){
            arr1[i] = arr1[i+1];
        } // we are assiging the value at index i+1 in index no[i] to replace the value and at end to pop that value
        arr1.pop();
        return arr1;
    }

    function test() external {
        arr1=[1,2,3,4,5];    //here we update the no in array
        remove(2);
        //[1,2,4,5]
        assert(arr1[0] ==1);   //assert use to make sure thay arr[0]==1 must be same and other condition also if not meet then give error
        assert(arr1[1]==2);
        assert(arr1[2]==4);
        assert(arr1[3]==5);
        assert(arr1.length==4);

       
    }
}

contract arrayreplacefromend{

    uint[] public arr=[1,3,2,5,3];

    //deleting an element created a gap in the array
    //one trick to move the last element into the place to delete

    function remove(uint index) public {
        arr[index]=arr[arr.length -1]; //we assign arr.length -1 value in arr[index] that mean which we want to delete we replace that value and remove last so lenght will decrease
        arr.pop();
    }
}