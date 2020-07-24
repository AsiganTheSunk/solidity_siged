/**
 * @title Pragma
 */ 
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

/**
 * @title Imports
 * Import ActivityRegistry Library from ActivityRegistry.sol
 * Import Ownable Module from cannonical-weth Library
 */

import "../registry/ActivityLogRegistry.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title ActivityManager
 */
contract ActivityManager is Ownable {
    /**
      * ActivityManager: Activity Log  data being stored within the SIGED Service
      */
    using ActivityLogRegistry for ActivityLogRegistry.ActivityLogRegistryIndex;
    using ActivityLogRegistry for ActivityLogRegistry.ActivityReference;
    ActivityLogRegistry.ActivityLogRegistryIndex _activityLogRegistry;
    
    /**
     * @dev addCase
     * @notice Adds a new user operator to the Siged Service
     * @param tokenHash string identifier for the case reference
     * @return true if the addCase is sucessfull
     */
    function addTokenActivityLog(bytes32 tokenHash, string memory operationType, string memory evidenceHash, bool operationStatus, uint blockNumber) public returns (bool) {
        // require(, 'Unable to add new case reference to the registry');
        _activityLogRegistry._addEntryToActivityLog(tokenHash, operationType, evidenceHash, operationStatus, blockNumber);
        return true;
    }

    /**
     * @dev getTokenActivityLog
     * @notice Gets all the  stored within the ActivityLogRegistry
     * @return list of case reference metadata
     */
    function getTokenActivityLog() public view returns (ActivityLogRegistry.ActivityReference [] memory) {      
        return _activityLogRegistry._getActivityLog();
    }

    /**
     * @dev getCases
     * @notice Gets all the token data stored within the ActivityLogRegistry
     * @return list of token metadata
     */
    function getTokenActivityLog(bytes32 tokenHash) public view returns (ActivityLogRegistry.ActivityReference [] memory) {      
        return _activityLogRegistry._getTokenFromActivityLogByTokenHash(tokenHash);
    }
}
