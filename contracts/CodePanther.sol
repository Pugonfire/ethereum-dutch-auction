// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CodePanther is ERC20 {
    constructor(uint256 initialSupply) ERC20("CodePanther", "CPT") {
        _mint(msg.sender, initialSupply * (10 ** uint256(decimals())));
    }
}