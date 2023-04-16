// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";



contract LegendsOfLegends is ERC1155, Ownable, ERC1155Supply{
    constructor(string memory uri_) ERC1155(uri_) {
    // add any other initialization code here
  }
string public baseURI;
uint public totalSupply;
uint public max_strength;

enum ContestStatus{
    PENDING,STARTED,ENDED
}

struct GameToken{
    string name;
    uint id;
}

struct Player {
    address playerAddress;
    string playerName;
    bool inContest;
}

  struct Contest {
        ContestStatus contestStatus;
        bytes32 contestHash;
        string name;
        address[] players;
        address winner;  
    }


mapping(address => uint256) public playerInfo;
mapping(address => uint) public playerTokenInfo;
mapping(string => uint256) public contestInfo;

Player[] public player;
GameToken[] public gameTokens;
Contest[] public contests;

function isPlayer(address addr) public view returns(bool){
     if (playerInfo[addr] == 0) {
            return false;
        } else {
            return true;
        }
}

  function getPlayer(address addr) public view returns (Player memory) {
        require(isPlayer(addr), "Player doesn't exist!");
        return player[playerInfo[addr]];
    }

    function getAllPlayers() public view returns (Player[] memory) {
        return player;
    }

    function isPlayerToken(address addr) public view returns (bool) {
        if (playerTokenInfo[addr] == 0) {
            return false;
        } else {
            return true;
        }
    }
event NewContest(
        string contestName,
        address indexed player1,
        address indexed player2
    );
    function getPlayerToken(
        address addr
    ) public view returns (GameToken memory) {
        require(isPlayerToken(addr), "Game token doesn't exist!");
        return gameTokens[playerTokenInfo[addr]];
    }

    function getAllPlayerTokens() public view returns (GameToken[] memory) {
        return gameTokens;
    }

     function updateContest(
        string memory _name,
        Contest memory _newContest
    ) private {
        require(isContest(_name), "Contest doesn't exist");
        contests[contestInfo[_name]] = _newContest;
    }

    function isContest(string memory _name) public view returns (bool) {
        if (contestInfo[_name] == 0) {
            return false;
        
        }
        else {
            return true;

        }
    }

    function getContest(string memory _name) public view returns (Contest memory){
        require(isContest(_name),"Contest Doesnt exists!");
        return contests[contestInfo[_name]];
    }

function getAllContests() public view returns (Contest[] memory){
    return contests;
}

 /// @param _name player name; set by player
    function registerPlayer(
        string memory _name,
        string memory _gameTokenName
    ) external {
        require(!isPlayer(msg.sender), "Player already registered"); // Require that player is not already registered

        uint256 _id = player.length;
        player.push(Player(msg.sender, _name,  false)); // Adds player to players array
        playerInfo[msg.sender] = _id; // Creates player info mapping

        createRandomGameToken(_gameTokenName);

        emit NewPlayer(msg.sender, _name); // Emits NewPlayer event
    }

     function _createRandomNum(
        uint256 _max,
        address _sender
    ) internal view returns (uint256 randomValue) {
        uint256 randomNum = uint256(
            keccak256(
                abi.encodePacked(block.difficulty, block.timestamp, _sender)
            )
        );

        randomValue = randomNum % _max;
        if (randomValue == 0) {
            randomValue = _max / 2;
        }

        return randomValue;
    }

       function createRandomGameToken(string memory _name) public {
        require(!getPlayer(msg.sender).inContest, "Player is in a Contest"); // Require that player is not already in a Contest
        require(isPlayer(msg.sender), "Please Register Player First"); // Require that the player is registered

       
    }
    event NewPlayer(address indexed owner, string name);
    function getTotalSupply() external view returns (uint256) {
        return totalSupply;
    }

 /// @param _name Contest name; set by player
    // function createContest(
    //     string memory _name
    // ) external returns (Contest memory) {
    //     require(isPlayer(msg.sender), "Please Register Player First"); // Require that the player is registered
    //     require(!isContest(_name), "Contest already exists!"); // Require Contest with same name should not exist

    //     bytes32 contestHash = keccak256(abi.encode(_name));

    //     Contest memory _contest = Contest(
    //         ContestStatus.PENDING, // Contest pending
    //         contestHash, // Contest hash
    //         _name, // Contest name
    //         player = new address[](0),
    //         winner = address(0) // winner address; empty until Contest ends
    //     );

    //     uint256 _id = contests.length;
    //     contestInfo[_name] = _id;
    //     contests.push(_contest);

    //     return _contest;
    // }

    function createContest(string memory _name) public returns (Contest memory) {
        require(isPlayer(msg.sender), "Please Register Player First"); // Require that the player is registered
        require(!isContest(_name), "Contest already exists!"); // Require Contest with same name should not exist
        bytes32 contestHash = keccak256(abi.encode(_name));
        Contest memory _contest = Contest(
            ContestStatus.PENDING,
            contestHash,
            _name,
            new address[](0),
            address(0)
        );
        uint256 _id = contests.length;
        contestInfo[_name] = _id;
        contests.push(_contest);
        contests.push(_contest);
    }

    /// @dev Player joins Contest
    /// @param _name Contest name; name of Contest player wants to join
    function joinContest(string memory _name) external returns (Contest memory) {
        Contest memory _contest = getContest(_name);

        require(
            _contest.contestStatus == ContestStatus.PENDING,
            "Contest already started!"
        ); // Require that Contest has not started
        require(
            _contest.players[0] != msg.sender,
            "Only player two can join a Contest"
        ); // Require that player 2 is joining the Contest
        require(!getPlayer(msg.sender).inContest, "Already in Contest"); // Require that player is not already in a Contest

        _contest.contestStatus = ContestStatus.STARTED;
        _contest.players[1] = msg.sender;
        updateContest(_name, _contest);

        player[playerInfo[_contest.players[0]]].inContest = true;
        player[playerInfo[_contest.players[1]]].inContest = true;

        emit NewContest(_contest.name, _contest.players[0], msg.sender); // Emits NewContest event
        return _contest;
    }

       function uintToStr(
        uint256 _i
    ) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint256 k = len;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - (_i / 10) * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }


        // Token URI getter function
    function tokenURI(uint256 tokenId) public view returns (string memory) {
        return
            string(abi.encodePacked(baseURI, "/", uintToStr(tokenId), ".json"));
    }

    // The following functions are overrides required by Solidity.
    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal override(ERC1155, ERC1155Supply) {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
}


}
