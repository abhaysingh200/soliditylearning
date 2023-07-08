// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


contract Token {

//these state variables makes the tokens so its name, symbol make sure spelling should be same.
    string public name;
    string public symbol;
    uint256 public totalSupply;  //make sure S must be capital otherwise totalsupply will not display.
    uint8 public decimals;
    address manager;
    uint256 public burnbalance;
    uint256 public mintbalance;

    mapping (address => uint) public balances;   //determine the balance of address.
    mapping (address => mapping (address => uint)) private allowances;  //determine the allowed balance to user.
    mapping (address => address) private rightallower;
    mapping (address => uint) private faucetusers; 

    event Transfer(address indexed from, address indexed to, uint256 value);


//using this we can display the token details.
    constructor(string memory _name,string memory _symbol,uint8 _decimals, uint256 _initialsupply){
        manager = msg.sender; 
        name = _name;
        symbol = _symbol;
        decimals = _decimals ;
        totalSupply = _initialsupply;
        burnbalance = ((10 * totalSupply)/100);
        mintbalance = ((3 * totalSupply)/100);
        balances[msg.sender] = _initialsupply;
        emit Transfer(address(this), msg.sender, totalSupply);
    }
//this will show the balance of token in metamask when we import without it not visible balance.
//spelling must be same.
    function balanceOf(address account) public view returns(uint){
        return balances[account];
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        require(balances[msg.sender] >= amount,"low balance");
        require(to != address(0), "invalid address");
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
        
    }

//in this we check that condition 
    function transferFrom(address from, address to, uint256 amount) external returns(bool) {
       
        require(from != address(0) && to != address(0) && amount > 0, "invalid imput");
        require(allowances[from][msg.sender] >= amount, "lack of funds");
        require(balances[from] >= amount,"no funds");
        allowances[from][msg.sender] -= amount;
        balances[from] -= amount;
        balances[to] += amount;
        emit Transfer(from, to, amount);
        return true;
    }

    //this approve is just a technique to make assurance that this is my partner using mapping. like a condition we make.
    function approve(address to, uint256 amount) external returns(bool){
        require(to != address(0), "invalid address");
        require(amount <= balances[msg.sender] && to != rightallower[msg.sender] , "low balance or already approve this address");        
        if (rightallower[msg.sender] == address(0)){
            allowances[msg.sender][to] = amount;
            rightallower[msg.sender] = to;
        }

        else
        {
            allowances[msg.sender][rightallower[msg.sender]] = 0;
            allowances[msg.sender][to] = amount;
            rightallower[msg.sender] = to;
        }

        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function allowance(address owner, address spender) external view returns (uint256) {
        return allowances[owner][spender];
    }

    function increaseAllowance(uint amount, address to) external returns(bool){
        require(amount > 0 && to != address(0), "wrong address");
        require(to == rightallower[msg.sender], "not old allower");
        allowances[msg.sender][to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function decreaseAllowance(uint amount, address to) external returns(bool){
        require(amount > 0 && to != address(0), "wrong address");
        require(to == rightallower[msg.sender], "not old allower");
        allowances[msg.sender][to] -= amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function burn(uint256 amount) external returns(bool){
        require(msg.sender==manager, "only owner ");
        require(amount<= burnbalance, "max. limit");
        require(balanceOf(msg.sender) >= amount && amount != 0, "Insufficient balance");
        burnbalance -= amount;
        balances[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount); 
        return true;
    }

    function faucet(uint256 amount) external returns(bool){
        require(amount<=100,"only 10 tokens/user.");
        faucetusers[msg.sender] += amount;
        require(faucetusers[msg.sender]<=100, "already faucet");
        balances[msg.sender] += amount;
        balances[manager] -= amount;
        emit Transfer(manager, msg.sender, amount);
        return true;
    }

    function minting(uint amount) external returns(bool) {
        require(msg.sender==manager && amount <= mintbalance, "ensure you are manager or decrease the amount.");
        balances[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0),manager, amount);
        return true;
//why emit written before return because after return no value consider.         
    }



}
     
