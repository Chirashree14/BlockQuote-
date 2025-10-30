# BlockQuote-
# 🧱 BlockQuote – A Decentralized Quote Storage Smart Contract  
<img width="1913" height="927" alt="image" src="https://github.com/user-attachments/assets/a9800998-5fcc-47c9-a026-89d20ef16ad2" />


## 📜 Project Description  
**BlockQuote** 
is a simple and elegant Ethereum smart contract built with Solidity.  
It allows users to store, manage, and retrieve their favorite quotes directly on the blockchain — making them permanent, verifiable, and censorship-resistant.  

Whether you want to create an on-chain collection of motivational quotes or a decentralized “Quote of the Day” dApp, **BlockQuote** provides the perfect foundation.  

---

## 💡 What It Does  
- Stores quotes with their text, author, and the exact timestamp when added.
- 
- Anyone can submit a new quote using the `addQuote()` function.  
- Users can retrieve quotes by ID using the `getQuote()` function.  
- Emits an event `QuoteAdded` every time a new quote is stored — perfect for dApp front-end integration.  
- Keeps track of the total number of quotes ever added.  

---

## ✨ Features  
- **Decentralized:** Quotes are stored permanently on-chain.  
- **Timestamped:** Each quote includes the time it was created.  
- **Transparent:** All additions trigger an on-chain event (`QuoteAdded`).  
- **User-friendly:** Simple functions for adding and retrieving quotes.  
- **Upgradeable:** Easy to extend for pagination, ownership control, or IPFS integration.  

---

## 🔗 Deployed Smart Contract Link  
[View Contract](contract)


## 🧩 Smart Contract Code  
```solidity
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
