pragma solidity ^0.4.21;

import "./Svandis.sol";

contract Sale is Svandis {
    
    address owner;
    uint256 public tier1Rate;
    uint256 public tier2Rate;
    bool public tiersSet = false;
    uint8 public currentTier = 0;
    uint256 public preSaleRate;
    
    function Sale() {
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

    function checkWhitelisted(address _whitelisted) public onlyOwner returns (uint256 quantity) {
        return allowed[this][_whitelisted];
    }

    function setPreSaleRate(uint256 _preSaleRate) public onlyOwner returns (bool success) {
        preSaleRate = _preSaleRate;
        return true;
    }

    function setTiers(uint256 _tier1Rate, uint256 _tier2Rate) public onlyOwner returns (bool success) {
        require (tiersSet == false);
        tier1Rate = _tier1Rate;
        tier2Rate = _tier2Rate;
        tiersSet = true;
        return true;
    }

    function switchTiers(uint8 _tier) public onlyOwner returns (bool success) {
        require(_tier == 1 || _tier == 2);
        currentTier = _tier;
        return true;
    }

    function () public payable {
        revert();
    }

    function buyTokens() public payable returns (bool success){
        uint256 quantity = (msg.value * preSaleRate)/10^18;
        require(quantity <= allowed[this][msg.sender]);
        transfer(this, msg.sender, quantity);
        Transfer(this, msg.sender, quantity);
    }
}