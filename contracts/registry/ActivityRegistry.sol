
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
library ActivityRegistry {

    struct ActivityReference {
        bytes32 tokenHash;
        string operationType;
        string evidenceHash;
        bool operationStatus;
        uint blockNumber;
    }

    struct RegistryActivityIndex {
        uint indexOfActivityRegistry;
        mapping(uint => ActivityReference) activity_data;
    }

    function addEntryToActivityIndex(RegistryActivityIndex storage self, bytes32 tokenHash, string memory operationType, string memory evidenceHash, bool operationStatus, uint blockNumber) public {
        ActivityReference memory _new_activity = ActivityReference(tokenHash, operationType, evidenceHash, operationStatus, blockNumber);
        self.activity_data[self.indexOfActivityRegistry++] = _new_activity;
    }

    function getMappingActivityValue(RegistryActivityIndex storage self) public view returns (ActivityReference[] memory) {
        ActivityReference[] memory memoryArray = new ActivityReference[](self.indexOfActivityRegistry);
        for(uint i = 0; i < self.indexOfActivityRegistry; i++) {
            memoryArray[i] = self.activity_data[i];
        }
        return memoryArray;
    }
    
    function getRegistryFromTokenHash(RegistryActivityIndex storage self, bytes32 tokenHash) public view returns (ActivityReference[] memory) {
        ActivityReference[] memory memoryArray = new ActivityReference[](self.indexOfActivityRegistry);
        for(uint i = 0; i < self.indexOfActivityRegistry; i++) {
            if (self.activity_data[i].tokenHash == tokenHash) {
                memoryArray[i] = self.activity_data[i];
            }
            
        }
        return memoryArray;
    }
}
