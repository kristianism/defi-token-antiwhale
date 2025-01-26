//SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// This is a simple ownable token contract that has the basic mint and burn function, and anti-whale settings.
contract TokenAntiwhale is ERC20, Ownable {

    // Contract Variables.
    uint256 public maxWalletHolding; // Maximum number of tokens that a user can hold.
    uint256 public maxTransferAmount; // Maximum number of tokens that can be transferred to another user.
    
    // Events for listeners.
    event MaxWalletHoldingUpdated (address indexed owner, uint256 previousAmount, uint256 newAmount);
    event MaxTransferAmountUpdated (address indexed owner, uint256 previousAmount, uint256 newAmount);

    // Constructor arguments for the TokenSimple contract.
    // Ability to determine the name of your token
    // Ability to determine an X amount of token to create or mint to the deployer's address.
    // Number inputs should be according to its decimal format. Default is 18 decimals or in wei.
    constructor (

        string memory _name, // Full name of the token
        string memory _symbol, // Short name of the token
        uint256 _initialSupply, // Number of tokens to be minted. 
        uint256 _maxWalletHolding, // Maximum number of tokens that a user can hold.
        uint256 _maxTransferAmount // Maximum number of tokens that can be transferred to another user. 

    ) ERC20(_name, _symbol) Ownable (msg.sender) {

        _mint(msg.sender, _initialSupply);
        maxWalletHolding = _maxWalletHolding;
        maxTransferAmount = _maxTransferAmount;

    }
    
    // External privileged function to create or mint an X amount of tokens to a specified address.
    // Input should be according to its decimal format. Default is 18 decimals or in wei.
    function mint(address _to, uint256 _amount) external onlyOwner {
        _mint(_to, _amount);
    }

    // External function to burn or destroy an X amount of tokens.
    // Input should be according to its decimal format. Default is 18 decimals or in wei.
    function burn(uint256 _amount) external {
        _burn(msg.sender, _amount);
    }

    // External function to update the maximum tokens a user can hold.
    // Input should be according to its decimal format. Default is 18 decimals or in wei.
    function updateMaxWalletHolding(uint256 _amount) external onlyOwner {
        
        uint256 previousAmount = maxWalletHolding; // Records the previous amount for event use.
        maxWalletHolding = _amount; // Stores the new max wallet holding amount.

        emit MaxWalletHoldingUpdated(owner(), previousAmount, maxWalletHolding); // Emit the event.
    }

    // External function to update the maximum tokens that can be transferred at a time.
    // Input should be according to its decimal format. Default is 18 decimals or in wei.
    function updateMaxTransferAmount(uint256 _amount) external onlyOwner {

        uint256 previousAmount = maxTransferAmount; // Records the previous amount for event use.
        maxTransferAmount = _amount; // Stores the new max transfer amount.

        emit MaxTransferAmountUpdated(owner(), previousAmount, maxTransferAmount); // Emit the event.
    }

    function _update(address from, address to, uint256 value) internal virtual override {
        
        // If the from address is not the owner or the to address is not the owner
        if (from != owner() && to != owner()) {
            
            // Then require the value to be less than the maximum transfer amount.
            require(value <= maxTransferAmount, "Transfer value exceeds the maximum transfer amount.");

            // Computes for the total balance after transfer.
            uint256 toBalance = balanceOf(to);
            uint256 toBalanceAfter = toBalance + value;

            // Require also that the total balance does not exceed the maximum holding amount.
            require(toBalanceAfter <= maxWalletHolding, "Recipient balance cannot exceed the maximum wallet amount.");

            // If all are satisfied, proceed the transfer as usual.
            super._update(from, to, value);

        } else {

            // If the from address or to address is the owner, proceed the transfer as usual.
            super._update(from, to, value);
        }
           
    }

    /* Contracts by: Kristian
     * Any issues and/or suggestions, you may reach me via:
     * Github: https://github.com/kristianism,
     * X (Twitter): https://x.com/defimagnate
    */

}
