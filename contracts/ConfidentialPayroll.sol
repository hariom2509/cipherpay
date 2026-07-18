// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ConfidentialToken.sol";

/**
 * @title ConfidentialPayroll
 * @dev Hackathon-style payroll contract.
 * In production with Zama FHEVM, salaries would be stored as encrypted euint64.
 */
contract ConfidentialPayroll {

    struct Employee {
        address wallet;
        uint256 encryptedSalary; // Placeholder for encrypted value
        bool exists;
    }

    address public employer;
    ConfidentialToken public token;

    mapping(address => Employee) public employees;

    event EmployeeAdded(address indexed wallet);
    event SalarySet(address indexed wallet, uint256 encryptedSalary);
    event PayrollExecuted(address indexed wallet);
    event TokensWithdrawn(address indexed employer, uint256 amount);

    modifier onlyEmployer() {
        require(msg.sender == employer, "Not employer");
        _;
    }

    constructor(address tokenAddress) {
        employer = msg.sender;
        token = ConfidentialToken(tokenAddress);
    }

    function addEmployee(address wallet, uint256 encryptedSalary) external onlyEmployer {
        employees[wallet] = Employee(wallet, encryptedSalary, true);
        emit EmployeeAdded(wallet);
        emit SalarySet(wallet, encryptedSalary);
    }

    function executePayroll(address wallet, uint256 decryptedSalary) external onlyEmployer {
        require(employees[wallet].exists, "Employee not found");

        // In real FHE version, decryptedSalary would not be passed
        token.transfer(wallet, decryptedSalary);

        emit PayrollExecuted(wallet);
    }

    /**
     * @dev Allows the employer to withdraw tokens from the payroll contract (e.g. for reclaiming unused funds).
     */
    function withdrawTokens(uint256 amount) external onlyEmployer {
        require(token.balanceOf(address(this)) >= amount, "Insufficient contract balance");
        token.transfer(employer, amount);
        emit TokensWithdrawn(employer, amount);
    }
}
