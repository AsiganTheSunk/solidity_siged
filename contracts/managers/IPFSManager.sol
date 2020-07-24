// Current Solidity Version
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;


/**
 * @dev Imports
 * Import Ownable Module from cannonical-weth Library
 */
import "../registry/IPFSRegistry.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title IPFSManager Params
 * # - Value Defining the Current
 */    
contract IPFSManager is Ownable {
    
    using IPFSRegistry for IPFSRegistry.IPFSRegistryIndex;
    using IPFSRegistry for IPFSRegistry.IPFSEvidence;
    IPFSRegistry.IPFSRegistryIndex _ipfsData;
    

    /**
     * @notice addEvidence
     * @dev Add a new IPFS Evidence to the IPFS Registry
     * @param caseReference The case reference for the evidence
     * @param ipfsHash The IPFS hash
     * @param title The image title
     * @param description The image description
     * @param tags The image tags
     */
    function addEvidence(string memory caseReference, string memory ipfsHash, string memory title, string memory description, string memory tags) public onlyOwner returns (bool) {
        //require(bytes(ipfsHash).length == 46);
        require(bytes(title).length > 0 && bytes(title).length <= 256);
        require(bytes(description).length < 1024);
        require(bytes(tags).length > 0 && bytes(tags).length <= 256);

        uint256 uploadedOn = now;
        _ipfsData._addEvidenceToIPFSRegistry(caseReference, ipfsHash, title, description, tags, uploadedOn);
        return true;
    }

    /** 
     * @notice getGroupEvidence
     * @param caseReference reference number to a case
     * @return list of files from a case The uploaded timestamp
     */
    function getGroupEvidenceData(string memory caseReference) public view onlyOwner returns (IPFSRegistry.IPFSEvidence[] memory) {
        return _ipfsData._getIPFSEvidenceFromRegistryByCaseRef(caseReference);
    }

    /** 
     * @notice getEvidences
     * @return list of files from a case The uploaded timestamp
     */
    function getEvidenceData() public view onlyOwner returns (IPFSRegistry.IPFSEvidence[] memory) {
        return _ipfsData._getIPFSEvidences();
    }

    /** 
     * @notice getEvidenceDataByHash
     * @return list of files from a case The uploaded timestamp
     */
    function getEvidenceDataByHash(string memory ipfsHash) public view onlyOwner returns (IPFSRegistry.IPFSEvidence[] memory) {
        return _ipfsData._getIPFSEvidenceFromRegistryByHash(ipfsHash);
    }
}
