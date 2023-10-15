// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CodePanther is ERC20, ERC20Burnable, Ownable {
    // Have to input a wallet address of the initialOwner when deploying the token
    constructor(address initialOwner) 
        ERC20("CodePanther", "CPT") 
    {
        transferOwnership(initialOwner);
        _mint(initialOwner, 1000000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}