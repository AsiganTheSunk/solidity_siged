/**
 * @title Pragma
 */ 
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

/**
 * @title Imports
 * Import Ownable Module from cannonical-weth Library
 */

import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title CaseRegistry Params
 */
library CaseRegistry {

    /**
     * @notice CaseReference
     */
    struct CaseReference {
        string _id; // id of the case reference
        string _name; // name of the case reference
        string _description; // description of the case reference
        bool _status;
    }

    /**
     * @notice CaseReferencesRegistryIndex
     */
    struct CaseReferencesRegistryIndex {
        uint caseReferenceIndex;
        mapping(uint => CaseReference) _caseReferenceData;
    }

    /**
     * @dev _addCaseReferenceToRegistry
     * @notice Adds a new user operator to the Siged Service
     * @param id address of the user operator
     * @param name name of the user operator
     * @param description description of the case
     * @return true if the _addCaseReferenceToRegistry is sucessfull
     */
    function _addCaseReferenceToRegistry(CaseReferencesRegistryIndex storage self, string memory id, string memory name, string memory description) public returns (bool) {
        for(uint i = 0; i < self.caseReferenceIndex; i++) {
            if (keccak256(bytes(self._caseReferenceData[i]._id)) == keccak256(bytes(id))) {
                return false;
            }
        }
        CaseReference memory _newCaseReference = CaseReference(id, name, description, true);
        self._caseReferenceData[self.caseReferenceIndex++] = _newCaseReference;
        return true;
    }

    /**
     * @dev _disableCaseReferenceFromRegistryByIndex
     * @notice Disables a user operator account by id
     * @return true if the _disableUserOperatorFromRegistryByIndex is sucessfull
     */
    function _disableCaseReferenceFromRegistryById(CaseReferencesRegistryIndex storage self, string memory id) public returns (bool){
        for(uint i = 0; i < self.caseReferenceIndex; i++) {
            if (keccak256(bytes(self._caseReferenceData[i]._id)) == keccak256(bytes(id))) {
                self._caseReferenceData[i]._status = false;
                return true;
            }
        }
        return false;
    }

    /**
     * @dev _enableCaseReferenceFromRegistryById
     * @notice Enable a user operator account by id
     * @return true if the _enableCaseReferenceFromRegistryById is sucessfull
     */
    function _enableCaseReferenceFromRegistryById(CaseReferencesRegistryIndex storage self, string memory id) public returns (bool) {
        for(uint i = 0; i < self.caseReferenceIndex; i++) {
            if (keccak256(bytes(self._caseReferenceData[i]._id)) == keccak256(bytes(id))) {
                self._caseReferenceData[i]._status = true;
                return true;
            }
        }
        return false;
    }

    /**
     * @dev _getCaseReferencesData
     * @notice Gets all the case reference data stored within the UserRegistry
     * @return list of case reference data
     */
    function _getCaseReferencesData(CaseReferencesRegistryIndex storage self) public view returns (CaseReference[] memory) {
        CaseReference[] memory _caseReferenceList = new CaseReference[](self.caseReferenceIndex);

        for(uint i = 0; i < self.caseReferenceIndex; i++) {
            _caseReferenceList[i] = self._caseReferenceData[i];
        }
        return _caseReferenceList;
    }
}
