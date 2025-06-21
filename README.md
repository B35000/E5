# E5 Smart Contracts.

This is the official repository for the E5 smart contracts that run on the Ethereum Virtual Machine Blockchains.

## Setup.

This project uses [Hardhat](https://hardhat.org/hardhat-runner/docs/getting-started#quick-start), [chai](https://www.chaijs.com/guide/installation/), npx([npm](com)) and [node](https://nodejs.org/en). If you havent already, please install them by following the instructions specified in their respective websites; then run `npm install` once done to install all the specified dependencies in the package.json file.
Once you have the project downloaded and unzipped, youll need to set up a `.env` file with specified private keys if you wish to deploy your own E5 on a blockchain of your choice.

These keys are used in the hardhat.config.js file for deploying E5 smart contracts to a selected Blochchain. You can run a local node on your computer by running `npx hardhat node` which would start up a local EVM instance on `http://127.0.0.1:8545`

## Configuring the Boot process.

The boot process occurs when you run `npx hardhat run --network localhost scripts/deploy.js`. In this case, ive specified `localhost` since im running a local node on my computer. If i was to deploy on [Ethereum Classic](https://ethereumclassic.com/) for instance, I would run `npx hardhat run --network etc scripts/deploy.js` with `etc` specified as the network since it has been described as a network in the `hardhat.config.js` file.

The `deploy.js` file contains the boot process for deploying all the smart contracts and linking them to their respective libraries. While booting, specific parameters are specified, specifically the mint limit for the main Spend token and End token:

```
var mint_limit = 3_500_000
var block_limit = 3_600_000
var maturiry_limit = 350_000_000
var default_proposal_expiry_duration_limit = (126000)
```

the `default_proposal_expiry_duration_limit` is the proposal expiration limit enforced by the main contract on all proposals sent to it. See the specifications set at the bottom of the `contracts/E5D/E5.sol` file for more details. The `block_limit` value should be greater than the `mint_limit` by about `500_000` to `1_000_000` depending on the magnitude of the `mint_limit` value, and the `maturity limit` value should be `10x` to `100x` the value of the `mint_limit`. The `default_proposal_expiry_duration_limit` is a magnitude of time specified in seconds.

## Unit Tests and Official First Audit.

Due to the complexity of the E5 smart contracts, an intenal audit has been carried out, with the results documented and posted in the `test/sample-test.js` file. The `sample-test.js` was used alongside the `contracts/E2.sol` file to audit each solidity file and its contents, with the pure functions taking precedence, then the view functions, then the modify functions after; The libraries were audited first before the contracts. To run a test, you first need to uncomment the respective function being called inside the `E2.sol` file, then change the `xit` keyword and run `npx hardhat test`. Please see the official test documentation to learn how to run tests using [chai](https://www.chaijs.com/guide/installation/) in [hardhat](https://hardhat.org/hardhat-runner/docs/guides/test-contracts).

## SPEND Block Limit Reduction Proportion Testing.

The demand pressure response of the official Spend token was tested in the test marked `?????` under the `describe("E5's", function () {...` description, with the results posted inside the test function itself. Two Spend configurations were used, one with a mint limit and block limit of `35_000_000` and another with a mint limit and block limit of `72_000_000`, all with similar expected responses to demand, with their scarcity peaking at `4.2%` mint limit at a frequency of **23** mints per block for a small blockchain with a block size of `12_000_000` gas and `1.8%` mint limit at a frequency of **53** mints per block for a relatively larger blockchain with a block size of `30_000_000` gas.

## Transaction Gas fees.

The gas fees for making each transaction has been measured and recorded at the very bottom of the `test/sample-test.js` file. Each run contains a number of nested transactions, since multiple transaction targets can be specified within a given run, each with individual instances for non-create actions such as transfers for instance. Please not that the values given may not reflect in the final run estimations you see when using [E5](https://b35000.github.io/E5UI/).

## Future works and translation.

The smart contracts can be deployed on any EVM Blockchain (classified as `Ethers` on [E5](https://b35000.github.io/E5UI/)), and will be deployed on all EVM Blockchains eventually. The codebase is simple enough to be translated into other Blockchain protocols given enough time and expertise since it does not contain any special functions that exist only in Solidity.

## License

E5 Smart Contracts are released under the terms of the MIT license.
Copyright (c) 2022 Bry Onyoni.
