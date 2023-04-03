//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;
contract Access{
    address owner;
    uint PatientId=1;
    uint docId=1;

    constructor(){
        owner=msg.sender;
    }

    struct PatientProfile{
        address profileAddress;
        string profileName;
        uint PatientId;

    }

     struct PrescriberProfile{
        address profileAddress;
        string profileName;
        uint docId;
    }

    struct EditPatientData{
        address patientAddress;
        address docAddress;
        string X_ray_Report;
        string scan_report;
        string healthProgressDescription;

    }
    
    EditPatientData[]public editPatientData;
    PatientProfile[] public pat_profile;
    PrescriberProfile[] public pres_profile;

    mapping(address => bool) public CheckDocAddress;


    function addPatient(address Address,string calldata _name) public {
        require(bytes(_name).length>0,"Please enter valid UserName");
        // pat_profile[PatientId].profileAddress=Address;
        // pat_profile[PatientId].profileName=_name;
        PatientProfile memory newPatient=PatientProfile(Address,_name,PatientId);
        pat_profile.push(newPatient);
        PatientId++;
    }

    function editPatientsData(address _patAddress,address _docAddress, string calldata _X_ray_Report,string calldata scanReport,string calldata healthProgress) public {
        require(bytes(healthProgress).length>0,"Please provide the clear data on Patient's health progress");
        require(CheckDocAddress[msg.sender],"Only prescribers are allowed to alter the Health Description");
        EditPatientData memory newData=EditPatientData(_patAddress,_docAddress,_X_ray_Report,scanReport,healthProgress);
        editPatientData.push(newData);
    }

    function getPatient(uint _id)view public returns(PatientProfile memory){
        require(1000<=_id && _id<=PatientId,"sorry, You've entered ID which does not exist");
        return pat_profile[_id];
    }

    function viewPatient()view public returns(PatientProfile[] memory){
        require(pat_profile.length>0,"No Patients have been added to the list,Please try adding some and view the list");
        return pat_profile;
    }

    function addPrescriber(address Address,string calldata _name)public{

        require(bytes(_name).length>0,"Please enter valid Doctor's name");
        PrescriberProfile memory newPrescriber=PrescriberProfile(Address,_name,docId);
        pres_profile.push(newPrescriber);
        CheckDocAddress[Address]=true;
        docId++;
    }
    
    function viewDoctor()view public returns(PrescriberProfile[] memory){
        require(pres_profile.length>0,"No Doctor have been added to the list, please try after adding details to view patient's data");
        return pres_profile;
    }

    function getPrescriber(uint _id) view public returns(PrescriberProfile memory){
        require(1000<=_id && _id<=docId,"sorry, you have entered the ID which does not exist");
        return pres_profile[_id];
    }
}

