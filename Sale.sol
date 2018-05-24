pragma solidity ^0.4.21;

import "./Svandis.sol";

contract Sale is Svandis {
    
    address owner;
    uint256 public tier1Rate;
    uint256 public tier2Rate;
    bool public tiersSet = false;
    uint8 public currentTier = 0;
    bool private enableSale = true;
    uint256 public preSaleRate;
    mapping(uint8 => uint256) public tierToRates;
    
    constructor() public {
        owner = msg.sender;
        balances[this] = totalSupply;
    }
    
    modifier onlyOwner {
        require(owner == msg.sender);
        _;
    }

    modifier saleOngoing {
        require(enableSale == true);
        _;   
    }

    function disableSale() public onlyOwner returns (bool success){
        enableSale = false;
        return true;
    }

    function getContractEth public onlyOwner returns (uint256 value) {
        return address(this).balance;
    }

    function withdraw(uint256 _amount) public onlyOwner returns (bool success){
        require(_amount <= address(this).balance);
        owner.transfer(_amount);
        return true;
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

    function checkWhitelisted(address _whitelisted) public view onlyOwner returns (uint256 quantity) {
        return allowed[this][_whitelisted];
    }

    function setPreSaleRate(uint256 _preSaleRate) public onlyOwner returns (bool success) {
        tierToRates[0] = _preSaleRate;
        return true;
    }

    function setTiers(uint256 _tier1Rate, uint256 _tier2Rate) public onlyOwner returns (bool success) {
        require (tiersSet == false);
        tierToRates[1] = _tier1Rate;
        tierToRates[2] = _tier2Rate;
        tiersSet = true;
        return true;
    }

    function switchTiers(uint8 _tier) public onlyOwner returns (bool success) {
        require(_tier == 1 || _tier == 2);
        require(_tier > currentTier);
        currentTier = _tier;
        return true;
    }

    function () public payable {
        revert();
    }

    function buyTokens() public saleOngoing payable {
        uint256 quantity = (msg.value * tierToRates[currentTier])/10^18;
        
        require(quantity <= allowed[this][msg.sender]);
        transfer(msg.sender, quantity);
    }
}