
// Current Solidity Version
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

/**
 * @title Imports
 * Import Ownable Module from openzeppeling Library
 */

import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title SigedService Params
 * SigedToken - Value Defining the Current SigedToken Taxonomy for the System.
 */

library UserRegistry {
    struct UserOperator {
        address _id; // id of the user operator
        string _name;
        string _surname;
        string _dni;
        bool _status;
    }

    struct UserOperatorRegistryIndex {
        uint userOperatorIndex;
        mapping(uint => UserOperator) userOperatorData;
    }

    /**
     * @dev _addUserOperatorToRegistry
     * @notice Adds a new user operator to the Siged Service
     * @param id address of the user operator
     * @param name name of the user operator
     * @param surname surname of the user operator
     * @param dni dni of the user operator
     * @return true if the _addUserOperatorToRegistry is sucessfull
     */
    function _addUserOperatorToRegistry(UserOperatorRegistryIndex storage self, address id, string memory name, string memory surname, string memory dni) public returns (bool) {
        UserOperator memory _newUserOperator = UserOperator(id, name, surname, dni, true);
        self.userOperatorData[self.userOperatorIndex++] = _newUserOperator;
        return true;
    }

    /**
     * @dev _disableUserOperatorFromRegistryById
     * @notice Disables a user operator account by id
     * @return true if the _disableUserOperatorFromRegistryById is sucessfull
     */
    function _disableUserOperatorFromRegistryById(UserOperatorRegistryIndex storage self, address id) public returns (bool) {
        for(uint i = 0; i < self.userOperatorIndex; i++) {
            if ((self.userOperatorData[i]._id) == id) {
                self.userOperatorData[i]._status = false;
                return true;
            }
        }
        return false;
    }

    /**
     * @dev _enableUserOperatorFromRegistryById
     * @notice Enables a user operator account by id
     * @return true if the _enableUserOperatorFromRegistryById is sucessfull
     */
    function _enableUserOperatorFromRegistryById(UserOperatorRegistryIndex storage self, address id) public returns (bool) {
        for(uint i = 0; i < self.userOperatorIndex; i++) {
            if ((self.userOperatorData[i]._id) == id) {
                self.userOperatorData[i]._status = true;
                return true;
            }
        }
        return false;
    }

    /**
     * @dev _getUserOperatorsData
     * @notice Gets all the user operator data stored within the UserRegistry
     * @return list of user operator data
     */
    function _getUserOperatorsData(UserOperatorRegistryIndex storage self) public view returns (UserOperator[] memory) {
        UserOperator[] memory _userOperatorList = new UserOperator[](self.userOperatorIndex);

        for(uint i = 0; i < self.userOperatorIndex; i++) {
            _userOperatorList[i] = self.userOperatorData[i];
        }
        return _userOperatorList;
    }

    /**
     * @dev _isValidUser
     * @notice verify user operator
     * @return bool
     */
    function _isValidUser(UserOperatorRegistryIndex storage self, address id) public view returns (bool){
        for(uint i = 0; i < self.userOperatorIndex; i++) {
            if ((self.userOperatorData[i]._id == id) && (self.userOperatorData[i]._status == true)) {
                return true;
            }
        }
        return false;
    }
}
