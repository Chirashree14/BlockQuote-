// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BlockQuote {
    // Struct to store quote details
    struct Quote {
        string text;
        string author;
        uint256 timestamp;
    }

    // Mapping to store quotes by ID
    mapping(uint256 => Quote) private quotes;
    uint256 private nextQuoteId = 1; // Start from ID 1

    // Event emitted when a new quote is added
    event QuoteAdded(uint256 id, string text, string author, uint256 timestamp);

    // Add a new quote (only owner or public, depending on use case)
    function addQuote(string memory _text, string memory _author) public {
        quotes[nextQuoteId] = Quote({
            text: _text,
            author: _author,
            timestamp: block.timestamp
        });
        emit QuoteAdded(nextQuoteId, _text, _author, block.timestamp);
        nextQuoteId++;
    }

    // Get a quote by ID
    function getQuote(uint256 _id) public view returns (string memory, string memory, uint256) {
        require(_id < nextQuoteId, "Quote does not exist");
        Quote memory quote = quotes[_id];
        return (quote.text, quote.author, quote.timestamp);
    }

    // Get the total number of quotes
    function getTotalQuotes() public view returns (uint256) {
        return nextQuoteId - 1;
    }
}