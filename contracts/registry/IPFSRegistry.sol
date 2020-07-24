// Current Solidity Version
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

/**
 * @title Imports
 * Import Ownable Module from cannonical-weth Library
 * Import SafeMath Module from openzeppelin Library
 */

import "@openzeppelin/contracts/access/Ownable.sol";
/**
 * @title IPFSEvidenceRegistry Params
 * SigedToken - Value Defining the Current SigedToken Taxonomy for the System.
 */
library IPFSRegistry {

    /** 
    * @title Represents a file which is owned by the admin. 
    */
    struct IPFSEvidence {
        string _caseReference;   // Reference to the Case
        string _ipfsHash;        // IPFS hash
        string _title;           // File title
        string _description;     // File description
        string _tags;            // File tags in comma separated format
        uint256 _uploadedOn;     // Uploaded timestamp
        address _uploadedBy;     // Uploader addresss
    }

    struct IPFSRegistryIndex {
        uint indexOfIPFSEvidenceRegistry;
        mapping(uint => IPFSEvidence) registryData;
    }

    /**
    * @dev Indicates that a user has uploaded a new image
    * @param caseReference The case reference for the evidence
    * @param ipfsHash The IPFS hash
    * @param title The image title
    * @param description The image description
    * @param tags The image tags
    * @param uploadedOn The upload timestamp
    * @param uploadedBy The owner of the image
    */
    event LogFileAdmision(string caseReference ,string ipfsHash, string title, string description, string tags, uint256 uploadedOn, address uploadedBy);

    /**
    * @dev Indicates that a user has requested a file
    * @param userOperator The uploader of the evidence
    * @param caseReference The case reference for the evidence
    */
    event LogFileRequest(address userOperator, string caseReference);

    /**
     * @notice _addEvidenceToRegistry
     * @dev Add a new IPFS Evidence to the IPFS Registry
     * @param caseReference The case reference for the evidence
     * @param ipfsHash The IPFS hash
     * @param title The image title
     * @param description The image description
     * @param tags The image tags
     * @param uploadedOn The upload timestamp
     */
    function _addEvidenceToIPFSRegistry(IPFSRegistryIndex storage self, string memory caseReference, string memory ipfsHash, string memory title, string memory description, string memory tags, uint256 uploadedOn) public returns (bool) {
        IPFSEvidence memory _new_evidence_data = IPFSEvidence(caseReference, ipfsHash, title, description, tags, uploadedOn, msg.sender);
        self.registryData[self.indexOfIPFSEvidenceRegistry++] = _new_evidence_data;

        emit LogFileAdmision(caseReference, ipfsHash, title, description, tags, uploadedOn, msg.sender);
        return true;
    }

    /**
     * @notice _getIPFSEvidenceFromRegistryByHash
     * @dev get a file based on the hash
     * @param ipfsHash The IPFS hash
     */
    function _getIPFSEvidenceFromRegistryByHash(IPFSRegistryIndex storage self, string memory ipfsHash) public view returns (IPFSEvidence[] memory) {
        IPFSEvidence[] memory _referenceList = new IPFSEvidence[](self.indexOfIPFSEvidenceRegistry);
        for(uint i = 0; i < self.indexOfIPFSEvidenceRegistry; i++) {
            if (keccak256(bytes(self.registryData[i]._ipfsHash)) == keccak256(bytes(ipfsHash))) { 
                 _referenceList[i] = self.registryData[i];
            }
        }
        return _referenceList;
    }


    /**
     * @notice _getIPFSEvidences
     * @dev get a file based on the hash
     */
    function _getIPFSEvidences(IPFSRegistryIndex storage self) public view returns (IPFSEvidence[] memory) {
        IPFSEvidence[] memory _referenceList = new IPFSEvidence[](self.indexOfIPFSEvidenceRegistry);
        for(uint i = 0; i < self.indexOfIPFSEvidenceRegistry; i++) {
                _referenceList[i] = self.registryData[i];
        }
        return _referenceList;
    }


    /**
     * @notice _getIPFSEvidenceFromRegistryByCaseRef
     * @dev get a file based on the casereference
     * @param caseReference The case reference for the evidence
     */
    function _getIPFSEvidenceFromRegistryByCaseRef(IPFSRegistryIndex storage self, string memory caseReference) public view returns (IPFSEvidence[] memory) {
        IPFSEvidence[] memory _referenceList = new IPFSEvidence[](self.indexOfIPFSEvidenceRegistry);
        for(uint i = 0; i < self.indexOfIPFSEvidenceRegistry; i++) {
            if (keccak256(bytes(self.registryData[i]._caseReference)) == keccak256(bytes(caseReference))) { 
                _referenceList[i] = self.registryData[i];
            }
        }
        //emit LogFileRequest(msg.sender, caseReference);
        return _referenceList;
    } 
}
