// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Hostel{

    address payable tenant;
    address payable landlord;

    uint public no_of_room =0;
    uint public no_of_aggrement =0;
    uint public no_of_rent=0;

    struct Room{     //struct is simple a structure used to define a specific value we have to add like room details
        uint roomid;   // so we can use room as a struct like we use uint when we use struct it will provide use all format.
        uint aggrementid;
        string roomname;
        string roomaddress;
        uint rent_per_month;
        uint securitydeposit;
        uint timestamp;
        bool vacant;
        address payable landlord;
        address payable currentTenant;

    }

    mapping (uint => Room) public room_by_no;  //mapping is just defining room by uinque value here we are defining it by no.

    struct RoomAgreement{
        uint roomid;
        uint agreementid;
        string roomname;
        string roomaddress;
        uint rent_per_month;
        uint securitydeposit;
        uint lockinperiod;
        uint timestamp;
        address payable tenantaddress;
        address payable landlordaddress;

    }

    mapping (uint => RoomAgreement) public roomagreement_byno;    //we can define different agreement by different no. 
    //    room_by_no[roomNo] = newRoom; as when we create new room we define its identity using mapping by no.

    struct rent{  //when some one pay rent these all values assign to that user.
        uint rentno;
        uint rentid;
        uint agreementid;
        string roomname;
        string roomaddress;
        uint rent_per_month;
        uint timestamp;
        address payable tenantaddress;
        address payable landlordaddress;
    }

    mapping (uint => rent) public rent_by_no;  // it will give us details of that room we mentioned in uint

    modifier onlylandlord(uint index) { //modifiers we can use in any function to run the function before some requirements by which we dont need to wrtie code again and again
        require(msg.sender == room_by_no[index].landlord,"only landlord can  access this");//means [index] room can only access by landlord
        _;
        //this modfiers we make for malik as unrented house can only access by landlord
    }

      modifier notlandlord(uint index) {
    require(msg.sender == room_by_no[index].currentTenant, "only tenant can access this");  // as we are checking room that room which we have created is of tenant or landlord this check only currenttenant can access this.
    _; // Add this line to indicate where the modified function should be executed
    }

    modifier onlywhilevacant(uint _index){
        require(room_by_no[_index].vacant==true, "room is currently occupied");  // this modifier check that room is occupied or not only those want to buy on rent can run this
        _;
    }

    modifier enoughrent(uint _index){
        require(msg.value >= uint(room_by_no[_index].rent_per_month),"not enough rent you have");// its check deployer must have balance greater or equal then the required rent per month of that house
        _;
    }

    modifier enoughagrrementfees(uint _index){
        require(msg.value>=uint(room_by_no[_index].rent_per_month) + uint(room_by_no[_index].securitydeposit),"you dont have enough balance");
        _;
    }// this modifier check that value of both rent and secuirty depost equal or greater then balance of that owner



}