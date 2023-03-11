pragma solidity ^0.8.0

contract SupplyChain {
    struct Product {
        uint id;
        string name;
        uint quantity;
        address owner;
        bool sold;
    }
    
    mapping (uint => Product) public products;
    uint public productCount;
    
    event ProductCreated(uint id, string name, uint quantity, address owner);
    event ProductPurchased(uint id, string name, uint quantity, address owner);
    
    function createProduct(string memory _name, uint _quantity) public {
        productCount++;
        products[productCount] = Product(productCount, _name, _quantity, msg.sender, false);
        emit ProductCreated(productCount, _name, _quantity, msg.sender);
    }
    
    function purchaseProduct(uint _id) public payable {
        Product storage product = products[_id];
        require(product.id > 0 && product.id <= productCount, "Invalid product ID");
        require(msg.value == product.quantity * 1 ether, "Insufficient funds");
        require(product.owner != address(0), "Product owner not found");
        require(!product.sold, "Product already sold");
        
        product.owner.transfer(msg.value);
        product.owner = msg.sender;
        product.sold = true;
        emit ProductPurchased(product.id, product.name, product.quantity, msg.sender);
    }
}
