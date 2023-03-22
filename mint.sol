pragma solidity ^0.8.0;

import "./ERC20.sol"; // import the ERC20 token standard

contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MTK") {} // initialize the token with a name and symbol
    
    function mint(address account, uint256 amount) public {
        _mint(account, amount); // call the _mint function inherited from the ERC20 standard
    }
}
