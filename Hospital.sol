pragma solidity ^0.5.16;
import "./ERC721Token.sol";
import "./Drug.sol";
import "./Doctor.sol";
import "./Patient.sol";

contract Hospital is ERC721Token{
    
    Patient[] patients;
    Doctor[] doctors;
    string name;
    uint256 max_capacity;
    constructor(string memory _name, string memory _symbol,uint256 capacity) public payable ERC721Token(_name,_symbol) {
        require(capacity>0,"Error: Invalid capacity");
        max_capacity = capacity;
        patients = new Patient[](max_capacity);
        doctors = new Doctor[](max_capacity);
    }
    
    function admitPatint(Patient P) external onlyOwner{
        require(patients.length<max_capacity,"Error: Hospital capacity full");
        require(!this.patientAlreadyExists(P),"Error: Patient already exists");
        patients.push(P);
        
    }
   function addDoctor(Doctor D) external onlyOwner{
       require(!this.doctortAlreadyExists(D),"Error: Doctor already exists");
       doctors.push(D);
   }
   function removeDoctor(Doctor D) external onlyOwner{
        require(this.doctortAlreadyExists(D),"Error: Doctor does not  exists");
        for(uint i=0; i< doctors.length;i++){
            if(doctors[i].getAddress()==D.getAddress()){
            delete doctors[i];
            doctors.length--;
            }
        }
    }
    function disChargePatient(Patient P) external onlyOwner{
        require(this.patientAlreadyExists(P),"Error: Patient does not  exists");
        for(uint i=0; i< patients.length;i++){
            if(patients[i].getAddress()==P.getAddress()){
            delete patients[i];
            patients.length--;
            }
        }
    }
    function patientAlreadyExists(Patient P) external returns(bool){
        for(uint i =0; i< patients.length; i++){
            if (patients[i].getAddress()== P.getAddress())
            {
                return false;
            }
        }
        return true;
    }
    function doctortAlreadyExists(Doctor D) external returns(bool){
        for(uint i =0; i< doctors.length; i++){
            if (doctors[i].getAddress()== D.getAddress())
            {
                return false;
            }
        }
        return true;
    }
}