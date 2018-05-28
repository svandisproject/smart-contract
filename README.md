# Svandis Smart Contract

## ERC20

Svandis is an ERC20 contract, which main functionality is described in Svandis.sol contract.
The tokens quantity is 400000000.

## The standard ERC20 contract is extended by Sale.sol

It gives the following functionality:
1. Controlling of the whitelist of the contract using addToWhitelist, addMultipleToWhitelist, removeFromWhitelist, checkWhitelisted functions.
2. Buying tokens from the contract using the buyTokens function. Is a payable function, so the tokens are purchased when using buyTokens.
3. The eth from the buyToken function is transffered to the withdrawWallet which can be set using setWithdrawWallet.
4. The amount can be withdrawn out of the contract using the withdraw function.
5. Controlling of the company whitelist of the contract using addToCompanyWhitelist, removeFromCompanyWhitelist, checkCompanyWhitelisted functions.
6. Taking the company tokens with the takeCompanyTokensOwnership function. Is not a payable function.
7. The contract has Presale and 2 Tiers for sale. In fact their difference is the rate of the token. The tiers are set using setTiers function and can be switched using switchTiers function.
8. The sale can be disabled anytime and cannot be reenabled using disableSale function.



