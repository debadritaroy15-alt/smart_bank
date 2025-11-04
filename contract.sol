// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleSmartBank {
    // Store each user's balance
    mapping(address => uint256) private balances;

    // Events to record deposits and withdrawals
    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    // Function to deposit Ether into the contract
    // No input needed — just send Ether with the transaction
    function deposit() external payable {
        require(msg.value > 0, "Must send ETH to deposit");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Function to withdraw all your funds
    function withdraw() external {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No balance to withdraw");
        balances[msg.sender] = 0;

        // Send Ether back to the user
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }

    // View your current balance
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

    // Contract's total balance (for transparency)
    function bankBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
