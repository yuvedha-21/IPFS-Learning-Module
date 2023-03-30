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

    PatientProfile[] public pat_profile;
    PrescriberProfile[] public pres_profile;

    mapping(uint => bool) public CheckDocAddress;


    function addPatient(address Address,string calldata _name) public {
        require(bytes(_name).length>0,"Please enter valid UserName");
        // pat_profile[PatientId].profileAddress=Address;
        // pat_profile[PatientId].profileName=_name;
        PatientProfile memory newPatient=PatientProfile(Address,_name,PatientId);
        pat_profile.push(newPatient);
        PatientId++;
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
        CheckDocAddress[docId]=true;
        docId++;
        
    }
    
    function viewDoctor()view public returns(PrescriberProfile[] memory){

        require(pres_profile.length>0,"No Doctor have been added to the list, please try after adding details to view patient's data");
        return pres_profile;

    }

}

