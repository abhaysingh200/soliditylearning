// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

//in this project we make a crowdfunding in which company can create their organization for funding(like charity, for hospital,etc.)
//in which user can vote to their liked project and send amount in contract. After that those have more vote will get funding.


contract crowdfundind{
    mapping (address=>uint)  public contributors;  //this create a gatter function, so it allow to give us our uint when we put address.
    address public manager;
    uint public minimumcontribution;
    uint public deadline;
    uint public target;
    uint public raisedamount;
    uint public noofcontributors;

    constructor(uint _target, uint _deadline){
        target=_target;
        //time stamp show time in sec.
        deadline= block.timestamp + _deadline;//10sec(pe deploy hua) + 3600(60*60 1hour deadline).
        minimumcontribution= 100 wei;
        manager=msg.sender;
    }
    
        //we are not using receive() function thats why we cant send ether using transact, 
        //so we made sendether to payable so we can make payment through it.
        //any function or state varibale we make payable, we can send ether by them.
    function sendether() public payable {
        require(block.timestamp< deadline, "deadline has passed");
        require(msg.value >= minimumcontribution, "you need to add minimum contribution");

        //mapping always print values in array type thats why use [].
        //by default value of uint is 0, so we check that value(balance) of that address==0, then add the contributor++.
        if (contributors[msg.sender]==0){
            noofcontributors++;
        }
        //here we increase the msg sender(mapping to uint) and assign its uint to amount he send to raisefunds.
        contributors[msg.sender] += msg.value;
        raisedamount += msg.value;

        //why we do this: because like we need total noofcontributors 5 and if this user come 5 time and deposit 5 times so noofcontributors increase, but we want different users.
        //thats why we enter condition==0, if he is alread a user then if not works then he go to contributors and its value will increased. 
        //now when second user comes its uint value will also zero, so then same process will go for it also.        
    }

    function getcontractbalance() public view returns(uint){
        return address(this).balance;
    }

    function refund() public {
        require(block.timestamp > deadline && raisedamount<target, "you are late");
        require(contributors[msg.sender]>=100 wei ,"you are not contributors");
        //to give user address we need to assign that address paayable to set address in user.
        address payable user = payable (msg.sender);
        //when we use mapping it looks[ address : uint, address : uint] like this means assign value to address.
        //here we access that uint by address contributors[msg.sender] : uint] gives us uint.
        user.transfer(contributors[msg.sender]);
        raisedamount -= contributors[msg.sender];
        noofcontributors -=1;
        contributors[msg.sender]=0;

    }

    struct Request{
        string description;
        address payable receipient;
        uint value;
        bool votingcompleted;
        uint noofvoters;
        mapping (address=>bool) voters;
    }

        //here we map uint to Request struct, because there may be different charity program like some for child , hospital,
        //elders users, foods, etc. so we assign like this 0 : charity, 1:foods like this.
    mapping (uint => Request) public requests;
    uint public numrequests;

    modifier onlymanager(){
        require(msg.sender==manager,"only manager can call");
        _;
    }

    function createRequests(string memory _discription, address payable _receipient, uint _value ) public onlymanager{
        //here we have access of structure of Request in usestruct.
        //we use requests mapping and right now numrequests value is 0, so assign usetruct data in requests[0],
        //that means now usestruct data fills in 0 number using mapping(uint=>Request);
        Request storage usestruct = requests[numrequests];
        //then we increase the number, so when new create so value of numrequests is 1, then 2 and we gives this number to mapping.
        //why use these things: because we have used mapping, in which struct is stored.
        numrequests++;
        usestruct.description=_discription;
        usestruct.receipient=_receipient;
        usestruct.value=_value;
        usestruct.votingcompleted=false;
        usestruct.noofvoters=0;
    }

    function voterequest(uint _requestNo) public  {
        require(contributors[msg.sender]>0 , "you must participate for voting");
        require(_requestNo < numrequests);
        //its works like pointer thisrequest point the requests[2] like health, mean now we have access of that struct data.    
        Request storage thisrequest = requests[_requestNo];
        //here we check in thisrequest struct those who run this struct check voter[msg.sender] ==false, if yes then go next, if not then show error.        
        require(thisrequest.voters[msg.sender]==false, "you have already voted");
        //here we convert voter[msg.sender] =true.
        thisrequest.voters[msg.sender]=true;
        thisrequest.noofvoters++;
  }

  function makepayment(uint _requestNo) public onlymanager{
      require(block.timestamp >= deadline  && raisedamount >=target , "wait for time end or target not reached.");
      //in this we point that struct which manager say to give money.
      Request storage thisrequest = requests[_requestNo];
      //here we check voting is completed or not if not then go next.
      require(thisrequest.votingcompleted==false, "already completed");
      //here we check thisrequest(struct) noofvoter must be greater than half of total contributors(user).
      require(thisrequest.noofvoters>= noofcontributors/2,"majority not meets more thn 50% vote not for this");
      //here we transfer money to receipient address with struct(thisrequest) value.
      thisrequest.receipient.transfer(thisrequest.value);
      thisrequest.votingcompleted=true;
//using true this now manager cant send money again to same struct.
  }

  
}