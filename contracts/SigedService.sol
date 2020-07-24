// Current Solidity Version
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;

/**
 * @title Imports
 * Import SigedToken Module from CustomToken.sol
 * Import Ownable Module from cannonical-weth Library
 */
import "./erc721/SigedToken.sol";
import "./managers/UserManager.sol";
import "./managers/CaseManager.sol";
import "./managers/IPFSManager.sol";
import "./managers/ActivityManager.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./registry/TokenRegistry.sol";
/**
 * @title SigedService Params
 */
contract SigedService is Ownable, UserManager, CaseManager, IPFSManager, ActivityManager {
    SigedToken public token;
    using TokenRegistry for TokenRegistry.TokenReference;
    /**
      * Events to track during SigedService operations
      */
//     event VisualizationRequest (address _from, SigedToken _token);
//     event AdmisionRequest (address _from, SigedToken _token);
//   
//     event SuccessfulAdmision (address _from, SigedToken _token);
//     event SuccessfulVisualization (address _to, string ref_number);
// 
//     event SigedTokenRequest (address _to, string ref_number);
//     event SucessfulEmision (address _to, string ref_number);
//     event FailedEmision (address _to, string ref_number);

    // Contract Constructor for SigedService
    constructor(address tokenAddress) public {
        token = SigedToken(tokenAddress);
    }

    /** 
     * SIGED TOKEN FUNCTIONS
     */
    function emitToken(string memory case_reference, address user_operator) public onlyOwner returns (bool) {
      // Emit the Event for new token creation
      token.mint(case_reference, user_operator);
     
      // token_references.addTokenToRegistry(case_reference, new_token);

      // Emit the Event for new token emision
      // emit EmitSigedToken(user_operator, case_reference);
    return true;
    }

  function getEmisionData() public view returns (TokenRegistry.TokenReference [] memory) {
    return token.getEmisionData();
  }
    
  function getEmisionDataFromId(uint id) public view returns (TokenRegistry.TokenReference memory) {
    return token.getEmisionDataFromId(id);
  }
     
//     function requestAdmision() public view returns (bool) {
//       return true;
//     }
}
