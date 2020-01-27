pragma solidity ^0.5.16;


contract Person{
    address public owner;
    string public name;
    uint public age;
   
    
    constructor (string memory _name, uint _age ) public{
        require(_age>=0,"Error: Invalid age");
        owner=msg.sender;
        name =_name;
        age = _age;
    }
    function increamentAge() public onlyOwner {
        age++;
    }
    function getAddress() external returns (address){
        return owner;
    }
    
    modifier onlyOwner{
        require(msg.sender==owner, "Error: Only owner authorised");
        _;
    }
    
}