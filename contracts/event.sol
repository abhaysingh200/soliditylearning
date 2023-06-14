// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// when we use storage to store data will take more gas then store data using event.
// event declaration
// up to 3 paramters can be indexed
//indexed paramters helps you filter the logs by the indexed parameter
//we can store multiple data in event but can only use max. 3 index in event

contract Event{

    event balance(address account,string message,uint value);  //like we use uint we using event name balance with arguments

    function setdata(uint _value) public {
        emit balance(msg.sender, "has value", _value);
        
    }//When you emit an event, you are essentially adding data to the event instance. 
    //like in when we buy crypto, so their we can use event that when he buy
    //so in logs he get details crypto: name, crypto amount:,,etc. like this we can do.
    //so when we make dapp we can access these log details from here and print in front end of dapp to interact users.
}

contract chatapp{

    event chat( address indexed _from , address  _to, string indexed message, uint value, uint _total);

    function sendMessage(address to_ , string memory message_) public {
        emit chat(msg.sender, to_, message_ ,4,7);
    }
    //in this we make a chat event chat go to blockchain but what we need to sent in event we need to declare in its argument.
    //now what is indexed, its mean it takes all data of which argument we use like we use in address so with the help of indexed we can find all messages sending or receiving by this address same for other also.
    //main thing we can use maximum 3 indexed in one event.
}

contract secondevent{

    event event2(address _sender, string message);
    event event3();

    function testevent() public {
       emit event2(msg.sender,"check");
       emit event2(msg.sender, "check2");
       emit event3();
    }//in this we create 2 event in using 1 address.

}