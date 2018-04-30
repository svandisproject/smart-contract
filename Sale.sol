pragma solidity ^0.4.21;

import "./Svandis.sol";

contract Sale is Svandis {
    
    address owner;
    
    constructor() {
        owner = msg.sender;
        balances[this] = totalSupply;
    }
    
    modifier onlyOwner {
        require(owner == msg.sender);
        _;
    }
    
    function addToWhitelist(address _whitelisted, uint256 _quantity) public onlyOwner returns (bool success) {
        require(_quantity < balances[this]);
        allowed[this][_whitelisted] = _quantity;
        return true;
    }
    
    function removeFromWhitelist(address _whitelisted) public onlyOwner returns (bool success) {
        allowed[this][_whitelisted] = 0;
        return true;
    }
}