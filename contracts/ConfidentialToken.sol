// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title ConfidentialToken (Mock ERC-7984 style token)
 * @dev Simplified confidential-style token for demo purposes.
 * In production, replace with real ERC-7984 implementation.
 */
contract ConfidentialToken {

    string public name = "Cipher Confidential Token";
    string public symbol = "cFHE";
    uint8 public decimals = 18;

    mapping(address => uint256) private balances;

    event Transfer(address indexed from, address indexed to, uint256 amount);

    constructor() {
        balances[msg.sender] = 1_000_000 * 10**decimals;
    }

    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
        return true;
    }
}
