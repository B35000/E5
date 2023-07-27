require("@nomicfoundation/hardhat-toolbox");
require('hardhat-contract-sizer');

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
    defaultNetwork: "hardhat",
    networks: {
        hardhat: {
            blockGasLimit: 80_000_000, // Network block gasLimit
            allowUnlimitedContractSize: true
        },
    },

    solidity: {
      version: "0.8.4",
      settings: {
        optimizer: {
          enabled: false,
          runs: 1,     // Optimized for SmartContract usage, not deployment cost.
        },
      },
    },
};
