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
    mapping(address=>address)   doctor_assigned; 
    mapping(address => bool)    admitted_status;
    mapping(address=> bool)     doctor_status;
    
    
    constructor(string memory _name, string memory _symbol,uint256 capacity) public payable ERC721Token(_name,_symbol) {
        require(capacity>0,"Error: Invalid capacity");
        max_capacity = capacity;
        patients = new Patient[](max_capacity);
        doctors = new Doctor[](max_capacity);
    }
    
    function admitPatint(Patient P) external onlyOwner{
        require(patients.length<max_capacity,"Error: Hospital capacity full");
        require(!this.patientAlreadyExists(P.getAddress()),"Error: Patient already exists");
        patients.push(P);
        admitted_status[P.getAddress()]=true;
        
    }
    function prescribeDrug(address patient,address drug_address, uint256 qty, uint256 valid_till) external {
        require(doctor_assigned[patient]==msg.sender,"Error: Doctor not assigned to patient");
        for(uint i =0; i< patients.length; i++){
            if (patients[i].getAddress()== patient)
            {   
                 for(uint i =0; i< doctors.length; i++){
                 if (doctors[i].getAddress()== msg.sender)
                {  
                     patients[i].add_drug(drug_address, qty, valid_till, doctors[i].get_sign());
                 }
        }
               
            }
        }
        
    }
    function assignDoctor(address P, address D) external onlyOwner{
        require(admitted_status[P]==true,"Error: Patient not admitted");
        require(doctor_status[D]==true, "Error: Doctor does not exists");
        doctor_assigned[P]=D;
    }
   function addDoctor(Doctor D) external onlyOwner{
       require(!this.doctortAlreadyExists(D.getAddress()),"Error: Doctor already exists");
       doctors.push(D);
       doctor_status[D.getAddress()]=true;
   }
   function removeDoctor(address D) external onlyOwner{
        require(this.doctortAlreadyExists(D),"Error: Doctor does not  exists");
        for(uint i=0; i< patients.length;i++){
            if(doctor_assigned[patients[i].getAddress()]==D)
            {
                doctor_assigned[patients[i].getAddress()]=address(0);
            }
        }
        for(uint i=0; i< doctors.length;i++){
            if(doctors[i].getAddress()==D){
            delete doctors[i];
            doctors.length--;
            }
        }
        doctor_status[D]=false;
    }
    function disChargePatient(Patient P) external onlyOwner{
        require(this.patientAlreadyExists(P.getAddress()),"Error: Patient does not  exists");
        for(uint i=0; i< patients.length;i++){
            if(patients[i].getAddress()==P.getAddress()){
            delete patients[i];
            patients.length--;
            }
        }
    }
    function patientAlreadyExists(address P) external returns(bool){
        return admitted_status[P];
    }
    function doctortAlreadyExists(address D) external returns(bool){
        return doctor_status[D];
    }
}