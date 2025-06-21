// Copyright (c) 2022 Bry Onyoni
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
// SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.
require("@nomicfoundation/hardhat-toolbox");
require('hardhat-contract-sizer');
require('dotenv/config')


/** @type import('hardhat/config').HardhatUserConfig */
const ETC_PRIVATE_KEY = process.env.ETC_PRIVATE_KEY
const ONE_PRIVATE_KEY = process.env.ONE_PRIVATE_KEY
const CELO_PRIVATE_KEY = process.env.CELO_PRIVATE_KEY
const FLR_PRIVATE_KEY = process.env.FLR_PRIVATE_KEY
const XDAI_PRIVATE_KEY = process.env.XDAI_PRIVATE_KEY
const FUSE_PRIVATE_KEY = process.env.FUSE_PRIVATE_KEY
const GLMR_PRIVATE_KEY = process.env.GLMR_PRIVATE_KEY
const MOVR_PRIVATE_KEY = process.env.MOVR_PRIVATE_KEY
const SYS_PRIVATE_KEY = process.env.SYS_PRIVATE_KEY
const MATIC_PRIVATE_KEY = process.env.MATIC_PRIVATE_KEY
const BNB_PRIVATE_KEY = process.env.BNB_PRIVATE_KEY
const XDC_PRIVATE_KEY = process.env.XDC_PRIVATE_KEY
const TT_PRIVATE_KEY = process.env.TT_PRIVATE_KEY
const NRG_PRIVATE_KEY = process.env.NRG_PRIVATE_KEY
const VIC_PRIVATE_KEY = process.env.VIC_PRIVATE_KEY
const EVMOS_PRIVATE_KEY = process.env.EVMOS_PRIVATE_KEY

module.exports = {
    defaultNetwork: "hardhat",
    networks: {
        hardhat: {
            blockGasLimit: 80_000_000, // Network block gasLimit
            allowUnlimitedContractSize: true
        },
        etc:{
          url: "https://etc.etcdesktop.com",
          accounts: [ETC_PRIVATE_KEY],
          gasPrice: 1_000_000_000
        },
        one:{
          url:'https://api.harmony.one',
          accounts:[ONE_PRIVATE_KEY],
          gasPrice: 100_000_000_000
        },
        celo:{
          url:'https://forno.celo.org',
          accounts:[CELO_PRIVATE_KEY],
          gas_price:5_000_000_000
        },
        flr:{
          url:'https://rpc.ftso.au/flare',
          accounts:[FLR_PRIVATE_KEY],
          gas_price:26_000_000_000
        },
        xdai:{
          url:'https://rpc.gnosis.gateway.fm',
          accounts:[XDAI_PRIVATE_KEY],
          gas_price:11_000_000_000
        },
        fuse:{
          url:'https://rpc.fuse.io/',
          accounts:[FUSE_PRIVATE_KEY],
          gas_price:10_000_000_000
        },
        glmr:{
          url:'https://moonbeam.publicnode.com',
          accounts:[GLMR_PRIVATE_KEY],
          gas_price:127_000_000_000
        },
        movr:{
          url:'https://rpc.api.moonriver.moonbeam.network',
          accounts:[MOVR_PRIVATE_KEY],
          gas_price:2_000_000_000
        },
        sys:{
          url:'https://syscoin-evm.publicnode.com',
          accounts:[SYS_PRIVATE_KEY],
          gas_price:35_000_000_000
        },
        matic:{
          url:'https://polygon.drpc.org',
          accounts:[MATIC_PRIVATE_KEY],
          gas_price:40_000_000_000
        },
        bnb:{
          url:'https://bsc-dataseed1.bnbchain.org',
          accounts:[BNB_PRIVATE_KEY],
          gas_price:3_000_000_000
        },
        xdc:{
          url:'https://erpc.xinfin.network',
          accounts:[XDC_PRIVATE_KEY],
          gas_price:60_000_000_000
        },
        tt:{
          url:'https://mainnet-rpc.thundercore.com',
          accounts:[TT_PRIVATE_KEY],
          gas_price:1100_000_000_000
        },
        nrg:{
          url:'https://nodeapi.energi.network',
          accounts:[NRG_PRIVATE_KEY],
          gas_price:120_000_000_000
        },
        vic:{
          url:'https://rpc.tomochain.com',
          accounts:[VIC_PRIVATE_KEY],
          gas_price:1_000_000_000
        },
        evmos:{
          url:'https://evmos-jsonrpc.theamsolutions.info',
          accounts:[EVMOS_PRIVATE_KEY],
          gas_price:30_000_000_000
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