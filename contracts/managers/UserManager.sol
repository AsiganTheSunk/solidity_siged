// Current Solidity Version
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

/**
 * @title Imports
 * Import UserRegistry Library from UserRegistry.sol
 * Import Ownable Module from cannonical-weth Library
 */

import "../registry/UserRegistry.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
/**
 * @title UserManager
 */
contract UserManager is Ownable {
    /**
      * UserRegistry: User Operators data being stored within the SIGED Service
      */
    using UserRegistry for UserRegistry.UserOperatorRegistryIndex;
    using UserRegistry for UserRegistry.UserOperator;
    
    UserRegistry.UserOperatorRegistryIndex _userOperatorRegistry;

    /**
     * @dev addOperator
     * @notice Adds a new user operator to the Siged Service
     * @param id address of the user operator
     * @param name name of the user operator
     * @param surname surname of the user operator
     * @param dni dni of the user operator
     * @return true if the addOperator is sucessfull
     */
    function addOperator(address id, string memory name, string memory surname, string memory dni) public returns (bool) {
        //require(, 'Unable to add new user operator to the registry');
        return _userOperatorRegistry._addUserOperatorToRegistry(id, name, surname, dni);
    }
    
    /**
     * @dev getOperators
     * @notice Gets all the user operator data stored within the UserRegistry
     * @return list of user operator data
     */
    function getOperators() public view returns (UserRegistry.UserOperator [] memory) {      
        return _userOperatorRegistry._getUserOperatorsData();
    }
    
    /**
     * @dev disableOperator
     * @notice Disables a user operator account by id
     * @return true if the disableOperator is sucessfull
     */
    function disableOperator(address id) public returns (bool) {
        // require(, 'Unable to disable user operator to the registry');
        return _userOperatorRegistry._disableUserOperatorFromRegistryById(id);
    }

    /**
     * @dev enableOperator
     * @notice Enables a user operator account by id
     * @return true if the enableOperator is sucessfull
     */
    function enableOperator(address id) public returns (bool) {
        // require(,'Unable to enable user operator from the registry');
        return _userOperatorRegistry._enableUserOperatorFromRegistryById(id);
    }
}
