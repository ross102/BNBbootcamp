// SPDX-License-Identifier: UNLICENSED 

pragma solidity 0.8.17;


contract DogeContract {

    uint256 totalSupply = 2000000;
    address owner;

    mapping( address => uint256) public balances;


    constructor () {
        owner = msg.sender;
        balances[owner] = totalSupply;
    }

    event Supply(address indexed owner, uint256 indexed supply);
    event Transfer(address indexed receiver, uint256 amount);
    
    struct Payment {
      uint256 amount;
      address receiver;  
    }

    mapping(address => Payment[]) payments;

    Payment myTransaction;

    modifier onlyOwner {
      require(msg.sender == owner);
      _;
    } 

    function getTotalSupply() public view returns(uint256) {
        return totalSupply;
    } 
    
    function increaseSupply() public onlyOwner {
        totalSupply += 1000;

        emit Supply(owner, totalSupply);
    }

    function transfer(uint256 amount, address receiver) public  {
        balances[msg.sender] -= amount; 
        balances[receiver] += amount;
        
        myTransaction.amount = amount;
        myTransaction.receiver = receiver;
        payments[msg.sender].push(myTransaction);

        emit Transfer(receiver, amount);
    } 

    function getPayments(address user) public view returns(Payment[] memory) {
        return payments[user];
    }
   

}