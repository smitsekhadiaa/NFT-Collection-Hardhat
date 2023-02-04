# NFT-Collection-Hardhat

To SetUp Hardhat in your local enviornment run the following commands:
```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```

## This Repo contains the following implemented things:

1) There should only exist 20 Crypto Dev NFT's and each one of them should be unique.

2) User's should be able to mint only 1 NFT with one transaction.

3) Whitelisted users, should have a 5 min presale period before the actual sale where they are guaranteed 1 NFT per transaction.

4) Website for your NFT Collection

Refer ERC721 code for viewing inbuilt functionalities: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721Enumerable.sol