// Deployment Artifacts for the Color Contracts
var sigedToken = artifacts.require("SigedToken");
var tokenRegistry = artifacts.require("TokenRegistry");

//var activityRegistry = artifacts.require("ActivityRegistry");

module.exports = async function(deployer, accounts, [owner]) {
  //deployer.deploy(activityRegistry);
  
  deployer.deploy(tokenRegistry);
  deployer.link(tokenRegistry, sigedToken);
  deployer.deploy(sigedToken);
};
