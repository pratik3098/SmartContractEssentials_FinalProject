pragma solidity ^0.5.16;

import "./Person.sol";
import "./Drug.sol";

contract Patient is Person{
    address public emr_address;
    mapping(address => uint) pres_drugs;
    struct Prescription{
        uint quantity;
        uint256 valid_till;
        bytes32 doctor_sign;
    }
    
    function add_drug(address drug_address, uint256 valid_till, bytes32 doctor_sign) public onlyOwner {
        require(drug_address!=address(0),'Error: Invalid drug address');
        require(valid_till> block.timestamp,'Error: Prescription validity expired');
        require(doctor_sign!=0,'Error: Invalid doctor signature');
    }
    
}