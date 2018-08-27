var Election = artifacts.require("./Election.sol");
var SafeMath = artifacts.require("./SafeMath.sol");

module.exports = function(deployer) {
  deployer.deploy(Election);
};
