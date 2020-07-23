/**
 * @title Pragma
 */ 
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

/**
 * @title Imports
 * Import UserRegistry Library from UserRegistry.sol
 * Import Ownable Module from cannonical-weth Library
 */

import "../registry/CaseRegistry.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title CaseManager
 */
contract CaseManager is Ownable {
    /**
      * CaseRegistry: Cases References data being stored within the SIGED Service
      */
    using CaseRegistry for CaseRegistry.CaseReferencesRegistryIndex;
    using CaseRegistry for CaseRegistry.CaseReference;
    CaseRegistry.CaseReferencesRegistryIndex _caseReferenceRegistry;
    
    /**
     * @dev addCase
     * @notice Adds a new user operator to the Siged Service
     * @param id string identifier for the case reference
     * @param name name of the case reference
     * @param description description of the case reference
     * @return true if the addCase is sucessfull
     */
    function addCase(string memory id, string memory name, string memory description) public returns (bool) {
        // require(case_references.addCaseToRegistry(id, name, description), 'Unable to add new case reference to the registry');
        _caseReferenceRegistry._addCaseReferenceToRegistry(id, name, description);
        return true;
    }

    /**
     * @dev getCases
     * @notice Gets all the user operator data stored within the UserRegistry
     * @return list of case reference metadata
     */
    function getCases() public view returns (CaseRegistry.CaseReference [] memory) {      
        return _caseReferenceRegistry._getCaseReferencesData();
    }
    
    /**
     * @dev disableCase
     * @notice Disables a case reference by id
     * @return true if the disableCaseReference is sucessfull
     */
    function disableCase(string memory id) public returns (bool) {
        // require(, 'Unable to disable case references from the registry');
        _caseReferenceRegistry._disableCaseReferenceFromRegistryById(id);
        return true;
    }

    /**
     * @dev enableCase
     * @notice Enables a case reference by id
     * @return true if the enableCaseReference is sucessfull
     */
    function enableCase(string memory id) public returns (bool) {
        // require(, 'Unable to enable case reference from the registrty');
        _caseReferenceRegistry._enableCaseReferenceFromRegistryById(id);
        return true;
    }
}
