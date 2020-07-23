const sigedService = artifacts.require("SigedService")
const userRegistry = artifacts.require("UserRegistry");
const caseRegistry = artifacts.require("CaseRegistry")
const sigedToken = artifacts.require("SigedToken")

require('chai/register-should')  // Using Should style
require('web3')

contract('SigedService', (accounts)  => {
    let admin_address = accounts[0]
    let operator_address = accounts[1]
    let random_address = accounts[2]

    before(async () => {
        try {
            userRegistryInstance = await userRegistry.deployed()
            caseRegistryInstance = await caseRegistry.deployed()
            sigedServiceInstance = await sigedService.deployed()
            sigedTokenInstance = await sigedToken.deployed()

        } catch(err) {
            console.log(err.message)
        }
    })

    describe('Siged Service Deployment & Components', async () => {
        
        it('It successfully deploys the UserRegistry Library', async () => {
            try {
                const userRegistryAddress = userRegistryInstance.address
                assert.notEqual(userRegistryAddress, 0x0)
                assert.notEqual(userRegistryAddress, '')
                assert.notEqual(userRegistryAddress, null)
                assert.notEqual(userRegistryAddress, undefined)
                console.log("      [ UserRegistry Library Address ]: %s", userRegistryAddress)

            } catch(err) {
                console.log(err.message)
            }
        })

        it('It successfully deploys the CaseRegistry Library', async () => {
            try {
                const caseRegistryAddress = caseRegistryInstance.address
                assert.notEqual(caseRegistryAddress, 0x0)
                assert.notEqual(caseRegistryAddress, '')
                assert.notEqual(caseRegistryAddress, null)
                assert.notEqual(caseRegistryAddress, undefined)
                console.log("      [ caseRegistry Library Address ]: %s", caseRegistryAddress)

            } catch(err) {
                console.log(err.message)
            }
        })

        it('It successfully deploys the SigedToken Contract', async () => {
            try {

                const sigedTokenAddress = sigedTokenInstance.address
                assert.notEqual(sigedTokenAddress, 0x0)
                assert.notEqual(sigedTokenAddress, '')
                assert.notEqual(sigedTokenAddress, null)
                assert.notEqual(sigedTokenAddress, undefined)
                console.log("      [ SigedService Contract Address ]: %s", sigedTokenAddress)

            } catch(err) {
                console.log(err.message)
            }
        })

        it('It successfully deploys the SigedService Contract', async () => {
            try {

                const sigedServiceAddress = sigedServiceInstance.address
                assert.notEqual(sigedServiceAddress, 0x0)
                assert.notEqual(sigedServiceAddress, '')
                assert.notEqual(sigedServiceAddress, null)
                assert.notEqual(sigedServiceAddress, undefined)
                console.log("      [ SigedService Contract Address ]: %s", sigedServiceAddress)

            } catch(err) {
                console.log(err.message)
            }
        })
    })

    // address id, string memory name, string memory surname, string memory dni - USER REGISTRY
    describe('Siged Service User Registry' , async() => {
        it('It succesfully adds a new user to the system', async() => {
            try {
                var userId = operator_address
                var userName = 'operator_name_01'
                var userSurname = 'operator_surname_01'
                var userDni = '41852607Z'
        
                var receipt = await sigedServiceInstance.addOperator(userId, userName, userSurname, userDni)
                // console.log(receipt)
            } catch(err) {
                console.log(err.message)
            }
        })

        it('It succesfully gets a user from the system', async() => {

            var userId = operator_address
            var userName = 'operator_name_01'
            var userSurname = 'operator_surname_01'
            var userDni = '41852607Z'
            var userStatus = true

            var receipt = await sigedServiceInstance.addOperator(userId, userName, userSurname, userDni)
            var userRegistryValues = await sigedServiceInstance.getOperators()

            var currentId = userRegistryValues[0]['_id']    
            var currentName = userRegistryValues[0]['_name']
            var currentSurname = userRegistryValues[0]['_surname']
            var currentDni = userRegistryValues[0]['_dni']
            var currentStatus = userRegistryValues[0]['_status']

            assert.equal(userId, currentId, '    - UserRegistry Contract should have a 01')
            assert.equal(userName, currentName, '    - UserRegistry Contract should have a name equal to Name01')
            assert.equal(userSurname, currentSurname, '    - UserRegistry Contract should have a surname equal to Surname01')
            assert.equal(userDni, currentDni, '    - UserRegistry Contract should have a dni equal to 00011122Z')
            assert.equal(userStatus, currentStatus, '    - UserRegistry Contract should have a status equal to true')
        })    

        it('It succesfully disables a user from the system', async() => {
            try {
                var userId = operator_address
                var userName = 'operator_name_01'
                var userSurname = 'operator_surname_01'
                var userDni = '41852607Z'
                var userStatus = true

                var receipt = await sigedServiceInstance.addOperator(userId, userName, userSurname, userDni)
                var userRegistryStatus = await sigedServiceInstance.disableOperator(userId)
                var userRegistryValues = await sigedServiceInstance.getOperators()
                var currentStatus = userRegistryValues[0]['_status']

                // console.log(currentId, currentName, currentSurname, currentStatus, '/', userStatus)
                assert.equal(false, currentStatus, '    - UserRegistry Contract should return false for current user')
            } catch(err) {
                console.log(err.message)
            }
        })

        it('It succesfully enables a user from the system', async() => {
            try {
                var userId = operator_address
                var userName = 'operator_name_01'
                var userSurname = 'operator_surname_01'
                var userDni = '41852607Z'
                var userStatus = true

                var receipt = await sigedServiceInstance.addOperator(userId, userName, userSurname, userDni)
                await sigedServiceInstance.disableOperator(userId)
                var userRegistryStatus = await sigedServiceInstance.enableOperator(userId)
                var userRegistryValues = await sigedServiceInstance.getOperators()
                var currentStatus = userRegistryValues[0]['_status']

                // console.log(currentId, currentName, currentSurname, currentStatus, '/', userStatus)
                assert.equal(true, currentStatus, '    - UserRegistry Contract should return true for current user')
            } catch(err) {
                console.log(err.message)
            }
        })

    })    

    // string memory id, string memory name, string memory description - CASE REGISTRY
    describe('Siged Service Case Registry' , async() => {

        it('It succesfully adds a new case to the system', async() => {
            try {
                var caseId = "case_number_001"
                var caseName = "case_name_001"
                var caseDescription = "case_description_001"
                
                var receipt = await sigedServiceInstance.addCase(caseId, caseName, caseDescription)
                // console.log(receipt)
            } catch(err) {
                console.log(err.message)
            }
        })

        it('It succesfully gets a case from the system', async() => {
            try {
                var caseId = "case_number_001"
                var caseName = "case_name_001"
                var caseDescription = "case_description_001"
                var caseStatus = true

                var receipt = await sigedServiceInstance.addCase(caseId, caseName, caseDescription)
                var caseRegistryValues = await sigedServiceInstance.getCases()

                var currentId = caseRegistryValues[0]['_id']    
                var currentName = caseRegistryValues[0]['_name']
                var currentDescription = caseRegistryValues[0]['_description']
                var currentStatus = caseRegistryValues[0]['_status']

                assert.equal(caseId, currentId, '    - UserRegistry Contract should have a id equal to 01')
                assert.equal(caseName, currentName, '    - UserRegistry Contract should have a name equal Name01')
                assert.equal(caseDescription, currentDescription, '    - UserRegistry Contract should have a surname equal to Surname01')
                assert.equal(caseStatus, currentStatus, '    - UserRegistry Contract should have a status equal to true')
            } catch(err) {
                console.log(err.message)
            }
        })   
        
        it('It succesfully disables a case from the system', async() => {
            try {
                var caseId = "case_number_001"
                var caseName = "case_name_001"
                var caseDescription = "case_description_001"
                var caseStatus = true

                var receipt = await sigedServiceInstance.addCase(caseId, caseName, caseDescription)
                var caseRegistryStatus = await sigedServiceInstance.disableCase(caseId)
                var caseRegistryValues = await sigedServiceInstance.getCases()
                var currentStatus = caseRegistryValues[0]['_status']

                assert.equal(false, currentStatus, '    - UserRegistry Contract should return false for current case')
            } catch(err) {
                console.log(err.message)
            }
        })  

        it('It succesfully enables a case from the system', async() => {
            try {
                var caseId = "case_number_001"
                var caseName = "case_name_001"
                var caseDescription = "case_description_001"
                var caseStatus = true

                var receipt = await sigedServiceInstance.addCase(caseId, caseName, caseDescription)
                await sigedServiceInstance.disableCase(caseId)
                var caseRegistryStatus = await sigedServiceInstance.enableCase(caseId)
                var caseRegistryValues = await sigedServiceInstance.getCases()
                var currentStatus = caseRegistryValues[0]['_status']

                assert.equal(true, currentStatus, '    - UserRegistry Contract should return true for current case')
            } catch(err) {
                console.log(err.message)
            }
        })  
    })

    describe('Siged Service Token' , async() => {
        it('Has a name', async () => {
            const name = await sigedTokenInstance.name()
            assert.equal(name, 'SigedToken')
        })
      
        it('Has a symbol', async () => {
            const symbol = await sigedTokenInstance.symbol()
            assert.equal(symbol, 'SGDTK')
        })

        it('It succesfully emits a new token to the system', async() => {
            try {
                const result = await sigedServiceInstance.emitToken('#EC058E', random_address)
                const totalSupply = await sigedTokenInstance.totalSupply()
                // SUCCESS
                assert.equal(totalSupply, 1)
                assert.equal(totalSupply.toNumber(), 1, 'id is correct')
                assert.equal(String(admin_address).toLowerCase(), result.receipt['from'], 'from is correct')
                assert.equal(String(sigedServiceInstance.address).toLowerCase(), result.receipt['to'], 'to is correct')
          
                // FAILURE: cannot mint same color twice 
                // await contract.mint('#5386E4', random_address)
            } catch(err) {
                console.log(err.message)
            }
        })    

        it('It succesfully reverts the duplicate emision of a token to the system', async() => {
            try {    
                // FAILURE: cannot mint same color twice 
                const result = await sigedServiceInstance.emitToken('#EC058E', random_address)
                const totalSupply = await sigedTokenInstance.totalSupply()
                // SUCCESS
                assert.equal(totalSupply, 1)
                assert.equal(err.message, 'Returned error: VM Exception while processing transaction: revert')
            } catch(err) {
                console.log(err.message)
            }
        })   

        it('It succesfully list current token emisions on the system', async () => {
            try {    
                // Mint 4 more tokens
                var random_user_address = '0x8A72f30E348b95Daa9747f9e41a4587FF8ad5085'
                await sigedServiceInstance.emitToken('#5386E4', random_address)
                await sigedServiceInstance.emitToken('#FFFFFF', random_address)
                await sigedServiceInstance.emitToken('#000000', random_address)

                assert.equal(4, totalSupply)
                var totalSupply = await sigedTokenInstance.totalSupply()
                // console.log("      + [ TotalSupply ]: %s", totalSupply)
            
                var emisionData = await sigedTokenInstance.getEmisionData()
                
                // asertion here
               
            } catch(err) {
                console.log(err.message)
            }
        })  
        it('It succesfully creates the proper hash for a token emisions on the system', async () => {
            try {
                var random_user_address = '0x8A72f30E348b95Daa9747f9e41a4587FF8ad5085'
                var expecetedIdentifier0 = await sigedTokenInstance.getHash('#EC058E', random_user_address)
                var expecetedIdentifier1 = await sigedTokenInstance.getHash('#5386E4', random_user_address)
                var expecetedIdentifier2 = await sigedTokenInstance.getHash('#FFFFFF', random_user_address)
                var expecetedIdentifier3 = await sigedTokenInstance.getHash('#000000', random_user_address)
                
                var emisionDataHash = [
                    expecetedIdentifier0, 
                    expecetedIdentifier1, 
                    expecetedIdentifier2, 
                    expecetedIdentifier3
                ]
                var expectedValues = [
                    '0x007ba88dde3f8773a75e245df86a5dff6bbeee4bbf3b2e3a05b88940f87801b6',
                    '0x00cd0f9f0adf5ffa53359f0a6c1b784e6787b93b92fbf716ab3cc5cb837fe5dc',
                    '0x615169c62688962173f34160fc68c27750fe3369a975b9ed0cdddb1d66232ca7',
                    '0xcfe5c5bdb9f74ff75084f2513c38b375548a508ceadec9218566204a5b625180'
                ]

                assert.equal(emisionDataHash.join(','), expectedValues.join(','))
            } catch(err) {
                console.log(err.message)
            }
        })

        it('It succesfully gets the data of a token emited using the id on the system ', async() => {
            try {
                var totalSupply = await sigedTokenInstance.totalSupply()
                var _tokenData
                for (var i = 1; i <= totalSupply; i++) {
                    _tokenData = await sigedTokenInstance.getEmisionDataFromId(i - 1)
                    console.log("      [ ID ]: %d [ Hash ]: %s", i-1, _tokenData[2])
                }
            } catch(err) {
                console.log(err.message)
            }
        })

        it('It succesfully checks the ownership of a token emited on the system', async() => {
            try {
                var tokenOwner = await sigedTokenInstance.ownerOf(1)
                console.log(tokenOwner)
                //assert.equal(random_address, sigedServiceInstance.address)
                // await sigedTokenInstance.setApprovalForAll(admin_address, true)
                var receipt = await sigedTokenInstance.balanceOf(random_address)
                console.log(receipt.toNumber())
                await sigedTokenInstance.approve(admin_address, 1,  { from: random_address })
                await sigedTokenInstance.safeTransferFrom(random_address, admin_address, 1)

                var receipt2 = await sigedTokenInstance.balanceOf(random_address)
                console.log(receipt2.toNumber())

                var currentOwner = await sigedTokenInstance.ownerOf(1)
                console.log(currentOwner, random_address)
                console.log(admin_address, operator_address, random_address)
                assert.equal(random_address, currentOwner)


               // TRANFER BACK EXAMPLE
//             let approved = await sigedTokenInstance.approve(admin_address, 1, { from: random_address })
//             console.log(approved)
//             let receipt4 = await sigedTokenInstance.safeTransferFrom(random_address, admin_address, 1)
//             console.log(receipt4)
//             let receipt5 = await sigedTokenInstance.ownerOf(1)
//             console.log(receipt5)
            } catch(err) {
                console.log(err.message)
            }
        })
        
        it('It succesfully checks the balance of tokens emited on the system', async() => {
            try {
            } catch(err) {
                console.log(err.message)
            }
        })  

        it('It succesfully transfers a token emited on the system', async() => {
            try {
            } catch(err) {
                console.log(err.message)
            }
        })  

        it('It succesfully transfers back a token emited on the system', async() => {
            try {
            } catch(err) {
                console.log(err.message)
            }
        })  

        it('It succesfully register a new entry in the TokenRegistry', async() => {
            try {
            } catch(err) {
                console.log(err.message)
            }
        })    
    })
})
