// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "./IWhitelist.sol";

contract CryptoDevs is ERC721Enumerable, Ownable {
    string _baseTokenURI;

    IWhitelist whitelist;

    bool public presaleStarted;

    uint256 public presaleEnded;
    uint256 public maxTokenIds = 20;
    uint256 public tokenIds;

    uint256 public _publicPrice=0.01 ether;
    uint256 public _presalePrice=0.005 ether;

    bool public _paused;

    modifier onlyWhenNotPaused{
        require(!_paused,"contract currently paused");
        _;
    } 



    constructor(string memory baseURI, address whitelistContract)
        ERC721("crypto Devs", "CD")
    {
        _baseTokenURI = baseURI;
        whitelist = IWhitelist(whitelistContract);
    }

    function startPresale() public onlyOwner {
        presaleStarted = true;
        presaleEnded = block.timestamp + 5 minutes;
    }

    function presaleMint() public payable onlyWhenNotPaused{
        require(
            presaleStarted && block.timestamp < presaleEnded,
            "presale has ended :<("
        );
        require(
            whitelist.whitelistedAddresses(msg.sender),
            "you are not whitelisted"
        );
        require(tokenIds < maxTokenIds, "excedded the limit");
        require(msg.value >= _presalePrice, "ether value sent is not corrcect");

        tokenIds += 1;

        _safeMint(msg.sender, tokenIds);
    }

    function mint() public payable onlyWhenNotPaused{
        require(
            presaleStarted && block.timestamp >= presaleEnded,
            "Presale has not ended yet"
        );
        require(tokenIds < maxTokenIds, "Exceed maximum Crypto Devs supply");
        require(msg.value >= _publicPrice, "Ether sent is not correct");

        tokenIds += 1;

        _safeMint(msg.sender, tokenIds);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }
    function setPaused(bool val) public onlyOwner{
        _paused=val;
    }

    function withdraw() public onlyOwner {
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent, ) = _owner.call{value: amount}("amount sent");
        require(sent, "failed to send");
    }

    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}
}
