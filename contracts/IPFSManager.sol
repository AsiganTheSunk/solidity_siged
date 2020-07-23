// Current Solidity Version
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;


/**
 * @dev Imports
 * Import Ownable Module from cannonical-weth Library
 * Import SafeMath Module from openzeppelin Library
 */
import "./registry/IPFSRegistry.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title IPFSManager Params
 * # - Value Defining the Current
 */    
contract IPFSManager is Ownable {
    
    using IPFSRegistry for IPFSRegistry.IPFSRegistryIndex;
    using IPFSRegistry for IPFSRegistry.IPFSEvidence;
    IPFSRegistry.IPFSRegistryIndex ipfs_data;
    
    /**
     * @dev addEvidenceToIPFS
     * @notice Adds a new File to the IPFSRegistry
     * @param caseReference reference number to a case
     * @param ipfsHash ipfs hash
     * @param title title
     * @param description description
     * @param tags tags
     * @return list of files from a case The uploaded timestamp
     */
    function addEvidenceToIPFS(string memory caseReference, string memory ipfsHash, string memory title, string memory description, string memory tags) public onlyOwner returns (bool) {
        require(bytes(ipfsHash).length == 46);
        require(bytes(title).length > 0 && bytes(title).length <= 256);
        require(bytes(description).length < 1024);
        require(bytes(tags).length > 0 && bytes(tags).length <= 256);

        uint256 uploadedOn = now;
        ipfs_data.addEvidenceToRegistry(caseReference, ipfsHash, title, description, tags, uploadedOn);
        return true;
    }

    /** 
    * @notice Returns the files from a case
    * @param caseReference reference number to a case
    * @return list of files from a case The uploaded timestamp
    */
    function getEvidecenFromIPFS(string memory caseReference) public view onlyOwner returns (IPFSRegistry.IPFSEvidence[] memory) {
        return ipfs_data.getIPFSRegistryFromCaseRef(caseReference);
    }
}
