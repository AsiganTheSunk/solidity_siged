/**
 * @title Pragma
 */
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;


/**
 * @title Imports
 * Import UserRegistry Library from UserRegistry.sol
 * Import Ownable Module from openzeppelin Library
 */

 
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./registry/TokenRegistry.sol";

contract SigedToken is ERC721, Ownable {

  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;
  /**
    * TokenRegistry:
    */
  using TokenRegistry for TokenRegistry.TokenReferenceRegistryIndex;
  using TokenRegistry for TokenRegistry.TokenReference;
  
  TokenRegistry.TokenReferenceRegistryIndex tokenReferenceRegistry;

  mapping(bytes32 => bool) registeredTokens;
  
  // Constructor
  constructor() ERC721("SigedToken", "SGDTK") public {
  }
  
  /**
    * @dev mint
    * @notice Adds a new SigedToken to the Siged Service and transfer the SigedToken to the new owner
    * @param caseReference case reference
    * @param userOperator address of the user operator
    * @return true if the addOperatorToRegistry is sucessfull
    */
  function mint(string memory caseReference, address userOperator) public returns (uint256) {
    // Calculate the Hash
    bytes32 _tokenHash = getHash(caseReference, userOperator);

    // Current Hash must be unique
    require(!registeredTokens[_tokenHash]);

    // Increment Siged TokenId counter
    _tokenIds.increment();
    uint256 _newTokenId = _tokenIds.current();
    
    // Mint, Transfer & Store the value of the Hash in the  mapping(bytes32 => bool) registeredTokens
    _mint(msg.sender, _newTokenId);
    _transfer(msg.sender, userOperator, _newTokenId);
    
    // Store Token Reference Data
    tokenReferenceRegistry._addTokenReferenceToRegistry(_newTokenId, _tokenHash, caseReference, userOperator);
    registeredTokens[_tokenHash] = true;
    return _newTokenId;
  }
  
  /**
   * @dev getHash
   * @notice Calculates the hash using caseReference & userOperator as inputs
   * @param caseReference case reference
   * @param userOperator address of the user operator
   * @return bytes32 Hash
   */
  function getHash (string memory caseReference, address userOperator) public pure returns (bytes32) {
    return keccak256(abi.encodePacked(caseReference, userOperator));
  }
  
  /**
    * @dev mint
    * @notice Adds a new SigedToken to the Siged Service and transfer the SigedToken to the new owner
    * @return true if the addOperatorToRegistry is sucessfull
    */
  function getEmisionData() public view returns (TokenRegistry.TokenReference [] memory) {
    return tokenReferenceRegistry._getTokenReferences();
  }
  
  /**
    * @dev getEmisionDataFromId
    * @notice Adds a new SigedToken to the Siged Service and transfer the SigedToken to the new owner
    * @param tokenId address of the user operator
    * @return string, address, bytes32, bool
    */
//   function getEmisionDataFromId (uint tokenId) public view returns (string memory, address, bytes32, bool) {
//     return (emitedTokens[tokenId].caseReference, emitedTokens[tokenId].userOperator,  emitedTokens[tokenId].tokenHash, emitedTokens[tokenId].status);
//   }
}
