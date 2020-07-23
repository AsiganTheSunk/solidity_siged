// Deployment Artifact for the SigedService Contract
var sigedService = artifacts.require("SigedService");

// Deployment Artifacts for the SigedToken Contracts
var sigedToken = artifacts.require("SigedToken");

// Deployment Artifacts for the SigedService Libraries
var caseRegistry = artifacts.require("CaseRegistry");
var userRegistry = artifacts.require("UserRegistry");

module.exports = async function(deployer, accounts, [owner]) {
    deployer.deploy(userRegistry);
    deployer.deploy(caseRegistry);
    
    deployer.link(userRegistry, sigedService);
    deployer.link(caseRegistry, sigedService);
    
    // Deployment Variables for the SigedService Contract
    deployer.deploy(sigedService, sigedToken.address).then(async () => {

        var sigedServiceInstance = await sigedToken.deployed();
    
        // Transfer CustomTokens To the Crowdsale Contract
        await sigedServiceInstance.transferOwnership(sigedService.address);
    });
};
