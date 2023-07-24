// SPDX-License-Identifier: MIT
pragma solidity ^ 0.8.19;

contract ZombieGame {

    mapping (uint => address) internal ZombieOwner;
    mapping (address => uint) internal ZombieCount;

    struct zombieDetails{
        string plan;
        string name;
        uint dna;
        uint level;
        uint xp;
        uint TotalMatch;
        uint MatchLeft;
        uint Wins;
        uint Looses;
    }

    struct botDetails{
        uint level;
    }

    uint dnaLength = 10 ** 16;

    zombieDetails[] internal zombies;
    botDetails[] internal bots;

//using this function user can create a zombie.  Important
//if you want to buy plan then you need to write "premium" .  
    function createZombie(string memory Plan, string memory name, uint dna, uint level, uint xp, uint TotalMatch, uint MatchLeft, uint Wins, uint Looses) internal {
        zombies.push(zombieDetails(Plan ,name ,dna ,level ,xp ,TotalMatch, MatchLeft,Wins ,Looses));
        uint currentIndex = zombies.length -1;
        ZombieCount[msg.sender]++;
        ZombieOwner[currentIndex] = msg.sender;
    }

//by this function we will generate the dna .
    function DnaGenerator(string memory name) internal view returns(uint){
        uint Dna = uint(keccak256(abi.encodePacked(name)));
        return Dna % dnaLength;
    }
}


//here we have inherited the zombieGame so we can access its functions.
contract FightZombies is ZombieGame {

//using this function a random zombie id will generate as we are getting number in the range of total zombies length.
    function randomEnemy() private view returns(uint) {
        uint TotalEnemy = zombies.length;
        uint RandomId = uint(keccak256(abi.encodePacked(TotalEnemy*block.timestamp*block.chainid*block.difficulty*block.number))) % TotalEnemy;
        return RandomId;
    }

    function ZombieVsBot() internal {
        for(uint i = 0; i < 11; i++) {
            uint RandomId = uint(keccak256(abi.encodePacked(block.timestamp*block.chainid*block.difficulty*block.number))) % 10;
            bots[i].level = RandomId;
        }
       
    }

//using this function user can fight with random zombie who is exist, user need to give his zombie id by which he want to fight.
    function ZombieVsZombie(uint yourZombie) internal returns(string memory){
        uint enemyZombie = randomEnemy();
        require(zombies[yourZombie].MatchLeft >= 1 , "Mine the matches.");
        require(zombies[enemyZombie].MatchLeft >= 1, "Again Try");

    //this will check if our zombie level is more than enemy when we wins.
        if (zombies[yourZombie].level > zombies[enemyZombie].level) {
            zombies[yourZombie].level++ ;
            zombies[yourZombie].TotalMatch++;
            zombies[yourZombie].MatchLeft--;
            zombies[yourZombie].Wins++;
            zombies[yourZombie].xp += 100;
            zombies[enemyZombie].level--;
            zombies[enemyZombie].TotalMatch++;
            zombies[enemyZombie].MatchLeft--;
            zombies[enemyZombie].Looses++;

        return "Congrats Wins.";    
        }

    //this check if enemy zombie is more than us then we loose.
        else if (zombies[enemyZombie].level > zombies[yourZombie].level) {
            zombies[enemyZombie].level++ ;
            zombies[enemyZombie].TotalMatch++;
            zombies[enemyZombie].MatchLeft--;
            zombies[enemyZombie].Wins++;
            zombies[enemyZombie].xp += 100;
            zombies[yourZombie].level--;
            zombies[yourZombie].TotalMatch++;
            zombies[yourZombie].MatchLeft--;
            zombies[yourZombie].Looses++;

        return "Win And Loose is the part of the Game.Try Again!." ;   
        }

    //this will check if both levels are equal then draw.
        else {
            zombies[enemyZombie].TotalMatch++;
            zombies[yourZombie].TotalMatch++;
            zombies[yourZombie].MatchLeft--;
            zombies[enemyZombie].MatchLeft--;

        return "Draw Try Again." ;    
        }
    }  

}


//this is our main contract.

contract GetZombie is ZombieGame, FightZombies {

    mapping (address => bool) public FreeNft;
    mapping (uint => bool) public onRent;  //checks zombie id is on rent or not.
    mapping (address => mapping (address => uint)) public Allowance;  //user can approve to other to transfer zombie.
    mapping (address => address) Approve; //by this we check this address is approved.
    mapping (uint => uint) public Timing;  //this checks time of zombie listing that how much timeLeft so user can remove if he want.
    mapping (uint => bool) public TakenNft;  //this will check nft is rented or still available.
    mapping (address => bool) public buyOnRent;  //this will check this address has nft on rent, 1 address alllow 1 nft only.
    mapping (uint => address) public RentedbyID; //using this we can check who have this id on rent.
    mapping (uint => uint) public rentAmount; //tells us the price of rented id.
    mapping (uint => uint) public MintTime;

    modifier OnlyOwner(uint zombieId) {
        require(ZombieOwner[zombieId] == msg.sender, "Only Owner.");
        _;
    }

    function mineTotalMatch(uint id) external OnlyOwner(id) returns(bool) {
        require(zombies[id].MatchLeft == 0 && MintTime[id] == 0, "You have chances or Already mining.");
        MintTime[id] = block.timestamp + 24 hours;
        if (block.timestamp >= MintTime[id]) {
        zombies[id].MatchLeft += 5;
        }
        return true;      
    }

//using this user can claim the free zombie id.
    function FreeZombie() external {
        require(ZombieCount[msg.sender] == 0, "Already have 1 or more nft.");
        FreeNft[msg.sender] = true;
        createZombie("Free", "FreeZombie", DnaGenerator("free"), 1, 0, 0, 2, 0, 0);
    }

//using this user can buy zombie, for that he need to type premium , then can give any name to him.
    function BuyZombie(string memory plan, string memory name) external payable returns(bool) {
        require(msg.value == 1 ether , "vlue must be 1 ether.");
        require(keccak256(bytes(plan)) == keccak256(bytes("premium")), "Correct Spelling");
        uint Dna = DnaGenerator(name);
        createZombie(plan, name, Dna, 5, 500, 0, 5, 0, 0);
        return true;
    }

//using this user can buy nft on rent.
    function BuyOnRent(uint id) external payable returns(bool) {
        require(Timing[id] > block.timestamp, "Now id is not on rent.");
        require(msg.value == rentAmount[id], "amount not match ether required.");
        require(!TakenNft[id] && !buyOnRent[msg.sender], "already taken Nft.");
        require(ZombieOwner[id] != msg.sender, "owner cant take his own id.");
        require(onRent[id] == true, "nft not listed.");

        payable(ZombieOwner[id]).transfer(msg.value);
        RentedbyID[id] = msg.sender;
        buyOnRent[msg.sender] = true;
        TakenNft[id] = true;
        return true;
    }

//using this user can see how many zombies he have.
    function ownerZombies(address _owner) public view returns (uint[] memory) {
       uint[] memory OwnerZombiesId = new uint[](ZombieCount[_owner]);  //why new because as OwnerZombiesId is the array but we need to give them the ZombieCount array.
       uint index = 0;
    
        for (uint i = 0; i < zombies.length; i++) {
            if (ZombieOwner[i] == _owner) {
            OwnerZombiesId[index] = i;
            index++;
            }
        }
        return OwnerZombiesId;
    }

//using this we can finds all details of zombie like levels, matchleft ,etc.
    function getDetails(uint zombieId) external view returns(zombieDetails memory){
        return zombies[zombieId];    
    }

    function FightWithBot(uint YourZombieId) public {
        ZombieVsBot();
        uint botId = uint(keccak256(abi.encodePacked(block.timestamp*block.chainid*block.difficulty*block.number))) % (zombies[YourZombieId].level);
        if(zombies[YourZombieId].level > bots[botId].level){
            zombies[YourZombieId].level ++;
        }
    }

//using this function user can enter hsi id and fight with random zombie id.
    function FightWithZombie(uint zombieID) external {
      
        if (RentedbyID[zombieID] == msg.sender && Timing[zombieID] > block.timestamp || FreeNft[msg.sender] == true) {
            uint beforeMatchWins = zombies[zombieID].Wins;
            ZombieVsZombie(zombieID);
                if (zombies[zombieID].Wins > beforeMatchWins && ZombieCount[msg.sender] >= 1) {
                uint[] memory renterId = ownerZombies(msg.sender);
                zombies[renterId[0]].level += 1;
            }
        }

        else {
            require(ZombieOwner[zombieID] == msg.sender, "You dont have nft.");
            ZombieVsZombie(zombieID);       
        }
    }

//using this user can convert his xp to level, when he win match he earn xp.
    function convertXP(uint id) external OnlyOwner(id) {
        require(zombies[id].xp >=500, "you need more xp");
        zombies[id].xp -= 500;
        zombies[id].level += 1;
    }

//using this user can give id on rent.
    function GiveOnRent(uint id, uint RentAmount) external OnlyOwner(id) {
        require(!onRent[id] && keccak256(bytes(zombies[id].plan)) == keccak256(bytes("premium")),"free nft cant on rent.");
        rentAmount[id] = RentAmount % (10 ** 18) ;
        onRent[id] = true;
        uint EndTime = block.timestamp + 30 seconds;
        Timing[id] = EndTime;
    }

//using this user can remove id from rent only when time exaust.
    function RemoveRent(uint id) external OnlyOwner(id) {
        require(onRent[id] == true, "not in rent.");
        require(block.timestamp >= Timing[id], "time remains.");
        onRent[id] = false;
        TakenNft[id] = false;
        RentedbyID[id] = address(0);
    }

//using this user can approve to any user to transfer his approved id.
    function approve(address to, uint id) external OnlyOwner(id) {
        Allowance[msg.sender][to] = id;
        Approve[msg.sender] = to;
    }

//using this user can transfer zombie one to other.
    function tranferFrom(address from, address to, uint id) external OnlyOwner(id) {
        require(keccak256(bytes(zombies[id].plan)) == keccak256(bytes("premium")), "free nft can sell.");
        require(! onRent[id], "This nft on rent." );
        require(ZombieOwner[id] == from || Approve[from] == msg.sender, "You dont have Nft.");
        ZombieOwner[id] = to;
        ZombieCount[from]--;
        ZombieCount[to]++;
    }

}


