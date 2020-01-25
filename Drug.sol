pragma solidity ^0.5.16;

contract Drug{
    
    address public owner;
    string public name;
    uint public quantity;
    bool public prescribed;
    bool public generic;
    
    
    constructor (string memory _name) public{
        owner=msg.sender;
        name= _name;
        quantity=0;
        prescribed = false;
        generic= true;
    }
    
    function set_prescribed(bool _pres) public onlyOwner{
        prescribed=_pres;
    }
    
    function set_quantity(uint _quan) public onlyOwner{
        require(_quan > 0 ,"Error: Invalid quantity");
        quantity= _quan;
    }
    
    function set_generic(bool _gene) public onlyOwner{
        generic = _gene;
    }
    
    modifier onlyOwner{
        require(msg.sender==owner, "Error: Only owner authorised");
        _;
    }
    
}