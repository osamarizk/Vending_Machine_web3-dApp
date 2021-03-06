// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract VendingMachine{
    address public owner;
    mapping (address =>uint) public VMBalances;

    constructor () {
        owner=msg.sender;
        VMBalances[address(this)]=100;
    }

    function getInventoryBalance() public view returns(uint) {
        return VMBalances[address(this)];
    }

    function getBuyerBalance() public view returns(uint) {
        return VMBalances[msg.sender];
    }

    modifier onlyOwner () {
        require(msg.sender == owner, "the sender is not the owner");
        _;
    }

    function restock(uint amount) public onlyOwner {
        VMBalances[address(this)] +=amount;
    }

    function purchase(uint amount) public payable  {
        require(VMBalances[address(this)] >= amount ,"no dontus equal these amounts");
        require(msg.value >= amount * 0.1 ether ,"Value is less than donuts price");
        VMBalances[address(this)] -=amount;
        VMBalances[msg.sender] +=amount;
    }

}
