// Deployment Artifacts for the Color Contracts
var sigedToken = artifacts.require("SigedToken");

var activityRegistry = artifacts.require("ActivityRegistry");
var ipfsEvidenceRegistry = artifacts.require("IPFSRegistry");
var tokenRegistry = artifacts.require("TokenRegistry");

module.exports = async function(deployer, accounts, [owner]) {
  deployer.deploy(activityRegistry);
  deployer.deploy(ipfsEvidenceRegistry);
    
  deployer.deploy(tokenRegistry);
  deployer.link(tokenRegistry, sigedToken);
  deployer.deploy(sigedToken);
};
