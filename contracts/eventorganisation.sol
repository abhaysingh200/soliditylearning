// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//in this there is a organizer and attendee, so organizer will create event and its ticket
//and attendee atend the event and buy the ticket.


contract Eventorganization{
    struct eventlist{
        string eventname;
        address organizer;
        uint date;
        uint price;
        uint totalnoofticket;
        uint ticketremain;
    }
    mapping (uint=>eventlist) public eventbynumber;
    mapping (address=>mapping (uint=>uint)) public tickets;
    uint public nextid;

//why not use ticketremain because when we create new event so if totalticket is 100 then remaining also 100.
    function createEvent(string memory _name, uint _date, uint _price, uint _totalnoofticket) external {
        require(_date>block.timestamp,"data is not correct");
        require(_totalnoofticket>0,"please increase the totalticketno");
        
        //here we use totalticket 2 times because ticketremain is also equal to totalnoofticket when we create new event.
        eventbynumber[nextid] = eventlist(_name, msg.sender, _date, _price, _totalnoofticket,_totalnoofticket);
        nextid++;
    }

    function buyticket(uint id, uint quantity) external payable {
        require(eventbynumber[id].date!=0, "event date is end");
        require(block.timestamp <= eventbynumber[id].date , "event not started yet");
        eventlist storage _event = eventbynumber[id];
        require(msg.value==(_event.price*quantity),"your amount not matching with total expenditure");
        require(_event.ticketremain>=quantity, " not enough tickets");
        _event.ticketremain-=quantity;

        //here we use nested mapping, because user may be buy for multiple event ticket then we need to
        //also assign that this address(user) has this id(event name) these ticket(quantity).
        tickets[msg.sender][id]+=quantity;    
    }

    function transferticket(uint eventid, uint quantity, address to) external  {
        require(eventbynumber[eventid].date!=0, "event date is end");
        require(block.timestamp >= eventbynumber[eventid].date , "event not started yet");
        require(tickets[msg.sender][eventid] >= quantity, "you do not have enough tickets");
        //here we remove ticket from this account.
        tickets[msg.sender][eventid]-=quantity;
        //and add the ticket in that transfer friend address.
        tickets[to][eventid]+=quantity;
    }

}