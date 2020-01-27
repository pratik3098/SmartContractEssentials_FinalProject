pragma solidity ^0.5.16;
import "./Person.sol";

contract Doctor is Person{
   
   bytes32 public doctor_sign;
   
    constructor (string memory _name, uint _age ) public  payable Person(_name, _age){
         doctor_sign = keccak256(abi.encodePacked(block.timestamp,name,age,block.difficulty));
    }
    function get_sign() public view returns(bytes32){
        return doctor_sign;
    }
    
}