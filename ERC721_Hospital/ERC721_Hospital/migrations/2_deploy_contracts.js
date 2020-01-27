const ConvertLib = artifacts.require("ConvertLib");
const MetaCoin = artifacts.require("MetaCoin");
const Hospital =artifcats.require("Hospital");
const Patient = artifacts.require("Patient");
const Doctor = artifacts.require("Doctor");
const Drug   = artifacts.require("Drug");

module.exports = function(deployer) {
  deployer.deploy(Hospital, "Toronto General Hospital","TSH","800");
  deployer.deploy(Doctor, "Dr. Eric Ruppert", "40");
  deployer.deploy(Patient,"Mr. John Snow", "32");
  deployer.deploy(Drug, "Paracetemol");

};
