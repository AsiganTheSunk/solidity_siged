
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
library ActivityLogRegistry {
    struct ActivityReference {
        bytes32 _tokenHash;
        string _operationType;
        string _evidenceHash;
        bool _operationStatus;
        uint _blockNumber;
    }

    struct ActivityLogRegistryIndex {
        uint activityLogIndex;
        mapping(uint => ActivityReference) _activityLogData;
    }

    function _addEntryToActivityLog(ActivityLogRegistryIndex storage self, bytes32 tokenHash, string memory operationType, string memory evidenceHash, bool operationStatus, uint blockNumber) public {
        ActivityReference memory _newActivityLog = ActivityReference(tokenHash, operationType, evidenceHash, operationStatus, blockNumber);
        self._activityLogData[self.activityLogIndex++] = _newActivityLog;
    }

    function _getActivityLog(ActivityLogRegistryIndex storage self) public view returns (ActivityReference[] memory) {
        ActivityReference[] memory _activityLogList = new ActivityReference[](self.activityLogIndex);
        for(uint i = 0; i < self.activityLogIndex; i++) {
            _activityLogList[i] = self._activityLogData[i];
        }
        return _activityLogList;
    }
    
    function _getTokenFromActivityLogByTokenHash(ActivityLogRegistryIndex storage self, bytes32 tokenHash) public view returns (ActivityReference[] memory) {
        ActivityReference[] memory _activityLogList = new ActivityReference[](self.activityLogIndex);
        for(uint i = 0; i < self.activityLogIndex; i++) {
            if (self._activityLogData[i]._tokenHash == tokenHash) {
                _activityLogList[i] = self._activityLogData[i];
            }
            
        }
        return _activityLogList;
    }
}
