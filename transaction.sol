pragma solidity ^0.8.0;

contract UserValues {

  struct User {
    string name;
    uint age;
    string email;
  }

  mapping(address => User) public users;

  function setUserValues(string memory _name, uint _age, string memory _email) public {
    users[msg.sender] = User(_name, _age, _email);
  }

  function getUserValues() public view returns (string memory, uint, string memory) {
    User memory user = users[msg.sender];
    return (user.name, user.age, user.email);
  }

  function sendEther(address payable _recipient, uint _amount) public {
    require(msg.sender.balance >= _amount, "Not enough funds");
    _recipient.transfer(_amount);
  }
  

}
