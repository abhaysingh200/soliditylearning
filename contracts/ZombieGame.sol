// SPDX-License-Identifier: MIT
pragma solidity ^ 0.8.19;

contract ZombieGame{

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

    uint dnaLength = 10 ** 16;

    zombieDetails[] internal zombies;

    function createZombie(string memory Plan, string memory name, uint dna, uint level, uint xp, uint TotalMatch, uint MatchLeft, uint Wins, uint Looses) internal {
        zombies.push(zombieDetails(Plan ,name ,dna ,level ,xp ,TotalMatch, MatchLeft,Wins ,Looses));
        uint currentIndex = zombies.length -1;
        ZombieCount[msg.sender]++;
        ZombieOwner[currentIndex] = msg.sender;
    }

    function DnaGenerator(string memory name) internal view returns(uint){
        uint Dna = uint(keccak256(abi.encodePacked(name)));
        return Dna % dnaLength;
    }

}


contract ZombieOnRent is ZombieGame {

    mapping (uint => bool) onRent;
    mapping (address => mapping (address => uint)) Allowance;
    mapping (address => address) Approve;
    mapping (uint => uint) Timing;

    function GiveOnRent(uint id) internal  {
        require(ZombieOwner[id] == msg.sender);
        onRent[id] = true;
        uint EndTime = block.timestamp + 30 seconds;
        Timing[id] = EndTime;
    }

    function RemoveRent(uint id) internal {
        require(onRent[id] == true);
        require(block.timestamp >= Timing[id]);
        onRent[id] = false;
    }

    function approve(address to, uint id) internal {
        Allowance[msg.sender][to] = id;
        Approve[msg.sender] = to;
    }

    function tranferFrom(address from, address to, uint id) internal {
        require(! onRent[id], "This nft on rent." );
        require(ZombieOwner[id] == from && ZombieOwner[id] == msg.sender || Approve[from] == msg.sender, "You dont have Nft.");
        ZombieOwner[id] = to;

    }
    
}

contract FightZombies is ZombieGame {

    function randomEnemy() private view returns(uint) {
        uint TotalEnemy = zombies.length;
        uint RandomId = uint(keccak256(abi.encodePacked(TotalEnemy,block.timestamp))) % TotalEnemy;
        return RandomId;
    }

    function ZombieVsZombie(uint yourZombie) public returns(string memory Result){
        uint enemyZombie = randomEnemy();

        zombieDetails storage YourZombie = zombies[yourZombie];
        zombieDetails storage EnemyZombie = zombies[enemyZombie];

        if (YourZombie.level > EnemyZombie.level) {
            YourZombie.level++ ;
            YourZombie.TotalMatch++;
            YourZombie.MatchLeft--;
            YourZombie.Wins++;
            YourZombie.xp += 100;
            EnemyZombie.level--;
            EnemyZombie.TotalMatch++;
            EnemyZombie.MatchLeft--;
            EnemyZombie.Looses++;

        return "Congrats Wins.";    
        }

        else if (EnemyZombie.level > YourZombie.level) {
            EnemyZombie.level++ ;
            EnemyZombie.TotalMatch++;
            EnemyZombie.MatchLeft--;
            EnemyZombie.Wins++;
            EnemyZombie.xp += 100;
            YourZombie.level--;
            YourZombie.TotalMatch++;
            YourZombie.MatchLeft--;
            YourZombie.Looses++;

        return "Win And Loose is the part of the Game.Try Again!." ;   
        }

        else {
            EnemyZombie.TotalMatch++;
            YourZombie.TotalMatch++;
            YourZombie.MatchLeft--;
            EnemyZombie.MatchLeft--;

        return "Draw Try Again." ;    
        }

    }
    
}


contract GetZombie is ZombieGame, ZombieOnRent, FightZombies {

    mapping (address => uint) RentedNft;

    function FreeZombie() public {
        require(ZombieCount[msg.sender] == 0, "Already have 1 nft.");
        createZombie("Free", "FreeZombie", DnaGenerator("free"), 1, 0, 0, 2, 0, 0);
    }

    function BuyZombie(string memory plan, string memory name) public {
        require(keccak256(bytes(plan)) == keccak256(bytes("premium")) || keccak256(bytes(plan)) == keccak256(bytes("Diamond")),"Correct Spelling");
        uint Dna = DnaGenerator(name);
        createZombie(plan, name, Dna, 5, 500, 0, 5, 0, 0);
    }

    function BuyOnRent(uint id) public {
        require(onRent[id] == true);
        RentedNft[msg.sender] = id;
        onRent[id] = false;
    }

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

    function Fight(uint zombieID) public {

        if (RentedNft[msg.sender] == zombieID) {

        uint beforeMatchWins = zombies[zombieID].Wins;
        ZombieVsZombie(zombieID);
        require(zombies[zombieID].Wins > beforeMatchWins && ZombieCount[msg.sender] >= 1);
        uint[] memory renterId = ownerZombies(msg.sender);
        zombies[renterId[0]].level += 1;
        }

        else {
            ZombieVsZombie(zombieID);
        }
    }

}