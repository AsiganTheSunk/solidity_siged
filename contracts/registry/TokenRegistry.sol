/**
 * @title Pragma
 */ 
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

/**
 * @title Imports
 * Import Ownable Module from cannonical-weth Library
 * Import SafeMath Module from openzeppelin Library
 */

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title TokenRegistry Params
 */
library TokenRegistry {
    struct TokenReference {
        uint _tokenId;
        bytes32 _tokenHash;
        string _caseReference;
        address _userOperator;
        bool _status;
    }

    struct TokenReferenceRegistryIndex {
        uint tokenRegistryIndex;
        mapping(uint => TokenReference) tokenReferenceData;
    }

    function _addTokenReferenceToRegistry(TokenReferenceRegistryIndex storage self, uint tokenId, bytes32 tokenHash, string memory caseReference, address userOperator) public returns (bool) {
        TokenReference memory _newTokenReference = TokenReference(tokenId, tokenHash, caseReference, userOperator, true);
        self.tokenReferenceData[self.tokenRegistryIndex++] = _newTokenReference;
        return true;
    }

    function _disableTokenReferenceFromRegistry(TokenReferenceRegistryIndex storage self, bytes32 tokenHash) public returns (bool) {
        for(uint i = 0; i < self.tokenRegistryIndex; i++) {
            if (self.tokenReferenceData[i]._tokenHash == tokenHash) {
                self.tokenReferenceData[i]._status = false;
                return true;
            }
        }
        return false;
    }

    function _enableTokenReferenceFromRegistry(TokenReferenceRegistryIndex storage self, bytes32 tokenHash) public returns (bool) {
        for(uint i = 0; i < self.tokenRegistryIndex; i++) {
            if (self.tokenReferenceData[i]._tokenHash == tokenHash) {
                self.tokenReferenceData[i]._status = true;
                return true;
            }
        }
        return false;
    }

    function _getTokenReferences(TokenReferenceRegistryIndex storage self) public view returns (TokenReference[] memory) {
        TokenReference[] memory _tokenReferenceList = new TokenReference[](self.tokenRegistryIndex);
        for(uint i = 0; i < self.tokenRegistryIndex; i++) {
            _tokenReferenceList[i] = self.tokenReferenceData[i];
        }
        return _tokenReferenceList;
    }

    function _getTokenByIndex(TokenReferenceRegistryIndex storage self, uint index) public view returns (TokenReference memory) {
        TokenReference[] memory _tokenReferenceList = new TokenReference[](self.tokenRegistryIndex);
        for(uint i = 0; i < self.tokenRegistryIndex; i++) {
            _tokenReferenceList[i] = self.tokenReferenceData[i];
        }
        return _tokenReferenceList[index - 1];
    }
}
