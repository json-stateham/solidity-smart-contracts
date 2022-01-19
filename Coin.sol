// SPDX-Licence-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Coin {
  // the keyword "public" makes variables accessible
  // from other contracts
  address public minter;
  mapping(address => uint) public balances;

  // events allow clients to react to specific
  // contract changes you declare
  event Sent(address from, address to, uint amount);

  // constructor is only run when the contract is created
  constructor() {
    minter = msg.sender;
  }

  // sends an amount of newly created coins to an address
  // can only be called by the contract creator
  function mint(address receiver, uint amount) public {
    require(msg.sender == minter);
    balances[receiver] += amount;
  }

  // errors allow you to provide information about
  // why an operation failed. They are returned
  // to the caller of the function
  error InsufficientBalance(uint requested, uint available);

  // sends an amount of existing coins
  // from any caller to an address
  function send(address receiver, uint amount) public {
    if (amount > balances[msg.sender])
      revert InsufficientBalance({
        requested: amount,
        available: balances[msg.sender]
      });
    
    balances[msg.sender] -= amount;
    balances[receiver] += amount;
    emit Sent(msg.sender, receiver, amount);
  }
}
