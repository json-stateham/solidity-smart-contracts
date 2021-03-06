pragma solidity ^0.8.11;

contract AccountsDemo {
    address public whoDeposited;
    uint256 public depositAmt;
    uint256 public accountBalance;

    function deposit() public payable {
        whoDeposited = msg.sender;
        depositAmt = msg.value;
        accountBalance = address(this).balance;
    }
}
