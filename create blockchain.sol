pragma solidity ^0.8.0;

contract MyBlockchain {
    uint public chainLength;
    uint public difficulty;
    
    struct Block {
        uint timestamp;
        bytes32 previousBlockHash;
        bytes32 blockHash;
        string data;
    }
    
    mapping (uint => Block) public chain;
    
    constructor(uint _difficulty) {
        difficulty = _difficulty;
        addBlock("Genesis Block");
    }
    
    function addBlock(string memory _data) public {
        bytes32 _previousBlockHash = chain[chainLength].blockHash;
        bytes32 _blockHash = calculateBlockHash(chainLength, _data, _previousBlockHash, block.timestamp);
        
        chain[chainLength+1] = Block(block.timestamp, _previousBlockHash, _blockHash, _data);
        chainLength++;
    }
    
    function calculateBlockHash(uint _index, string memory _data, bytes32 _previousBlockHash, uint _timestamp) public view returns (bytes32) {
        bytes memory _blockHeader = abi.encodePacked(_index, _data, _previousBlockHash, _timestamp);
        bytes32 _blockHash = keccak256(_blockHeader);
        
        return _blockHash;
    }
    
    function validateBlock(uint _index) public view returns (bool) {
        Block memory _block = chain[_index];
        bytes32 _expectedBlockHash = calculateBlockHash(_index, _block.data, _block.previousBlockHash, _block.timestamp);
        
        if (_block.blockHash != _expectedBlockHash) {
            return false;
        }
        
        return true;
    }
    
    function validateChain() public view returns (bool) {
        for (uint i = 1; i <= chainLength; i++) {
            if (!validateBlock(i)) {
                return false;
            }
        }
        
        return true;
    }
}
