// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockERC20 is ERC20 {
    constructor(uint256 initialSupply) ERC20("Test", "T") {
        _mint(msg.sender, initialSupply);
    }

    receive() external payable {}
    fallback() external payable{}
}