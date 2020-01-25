pragma solidity ^0.5.16;

import "./Person.sol";
import "./Drug.sol";

contract Patient is Person{
    address public emr;
    bool    public admit_status;
     struct Prescription{
        uint quantity;
        uint256 valid_till;
        bytes32 doctor_sign;
    }
    
    mapping(address => Prescription) pres_drugs;
   
    function add_drug(address drug_address, uint256 pres_qty,uint256 valid_till, bytes32 doctor_sign) public  {
        require(drug_address!=address(0),'Error: Invalid drug address');
        require(pres_qty> 0 , "Error: Invalid quantity");
        require(valid_till> block.timestamp,'Error: Prescription validity expired');
        require(doctor_sign!=0,'Error: Invalid doctor signature');
        pres_drugs[drug_address]=Prescription(pres_qty,valid_till, doctor_sign);
    }
    
    function add_emr_address(address emr_address ) public onlyOwner{
        require(emr_address!=address(0),"Error: Invalid emr address");
        emr= emr_address;
    }
    
    function change_admit_status(bool admit) public {
        admit_status=admit;
    }
    
}