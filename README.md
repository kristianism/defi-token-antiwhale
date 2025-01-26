## Anti-whale ERC20 Token
This is a simple ownable token contract that has the basic mint and burn function, and anti-whale settings.

### Solidity Version:
- 0.8.20

### Imports:
- @openzeppelin/contracts/access/Ownable.sol
- @openzeppelin/contracts/token/ERC20/ERC20.sol

### Constructor Arguments:
- _name: The full name of the token
- _symbol: The short name for the token or the ticker
- _initialSupply: The number of tokens to be pre-minted or pre-created to the deployer address
- _maxWalletHolding: Maximum number of tokens that a user can hold.
- _maxTransferAmount: Maximum number of tokens that can be transferred to another user.

### Functions:
- mint: Privileged function to create or mint an X amount of token/s to a specified address
- burn: External function to destroy an X amount of tokens from sender address
- updateMaxWalletHolding: External function to update the maximum tokens a user can hold.
- updateMaxTransferAmount: External function to update the maximum tokens that can be transferred at a time.
- Openzeppelin default Ownable functions
- Openzeppelin default ERC20 functions
