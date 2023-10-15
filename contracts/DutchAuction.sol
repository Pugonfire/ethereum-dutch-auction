// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract DutchAuction is Ownable {
    uint256 public startingPrice;
    uint256 public reservePrice;
    uint256 public auctionEndTime;
    uint256 public initialSupply;
    uint256 public currentPrice;
    uint256 public totalTokens;
    uint256 public tokensSold;
    bool public auctionClosed;
    address public highestBidder;
    uint256 public highestBid;

    event BidPlaced(address bidder, uint256 amount);
    event AuctionClosed(address winner, uint256 amountPaid, uint256 tokensPurchased);

    modifier onlyBeforeAuctionEnd() {
        require(block.timestamp < auctionEndTime, "Auction has ended");
        _;
    }

    constructor() {}

    function startAuction(uint256 _startingPrice, uint256 _reservePrice, uint256 _duration, uint256 _supply) public onlyOwner {
        startingPrice = _startingPrice;
        reservePrice = _reservePrice;
        auctionEndTime = block.timestamp + _duration;
        initialSupply = _supply;
        totalTokens = _supply;
        currentPrice = _startingPrice;
        auctionClosed = false;
    }

    function placeBid() external payable onlyBeforeAuctionEnd {
        require(!auctionClosed, "Auction has ended");
        require(msg.value >= currentPrice, "Bid amount must be at least the current price");

        uint256 tokensToPurchase = msg.value / currentPrice;
        require(tokensToPurchase > 0, "Bid amount is not sufficient to purchase any tokens");
        require(tokensToPurchase <= totalTokens, "Not enough tokens left for purchase");

        highestBidder = msg.sender;
        highestBid = msg.value;
        tokensSold += tokensToPurchase;
        totalTokens -= tokensToPurchase;
        currentPrice = (totalTokens == 0) ? reservePrice : highestBid / totalTokens;

        emit BidPlaced(msg.sender, msg.value);

        // Check if the auction is now closed
        if (totalTokens == 0 || block.timestamp >= auctionEndTime || currentPrice == reservePrice) {
            auctionClosed = true;
            endAuction();
        }
    }

    function endAuction() internal {
        if (highestBidder != address(0)) {
            uint256 tokensPurchased = initialSupply - totalTokens;
            emit AuctionClosed(highestBidder, highestBid, tokensPurchased);
        }
    }

    function isAuctionClosed() public view returns (bool){
        return auctionClosed;
    }
}
