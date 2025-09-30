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


// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const { ethers } = require("hardhat");
const hre = require("hardhat");


let e5; let e52;   
let f5;    
let g5; let g52;   
let h5; let h52;

/* LIBRARIES */
let e3; let e32; let e33; let e34;    
let f3; let f32; let f33; 
let g3; let g32; let g33;    
let h3; let h32;


function bgN(number, power) {
  return ethers.utils.parseUnits(number.toString(), power);
}


async function main() {
  // npx hardhat run deploy.js
  // const booter_private_key = '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80';
  // const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/')
  // const booter = new ethers.Wallet(booter_private_key, provider);
  
  const [booter] = await ethers.getSigners();

  /* ------------------------------------------- DEPLOY LIBRARIES ------------------------------------ */
  const E3 = await hre.ethers.getContractFactory("E3");
  e3 = await E3.deploy(/* {nonce: base_nonce} */);
  await e3.deployed();


  const E32 = await hre.ethers.getContractFactory("E32");
  e32 = await E32.deploy(/* {nonce: base_nonce+1} */);
  await e32.deployed();

  

  const E33 = await hre.ethers.getContractFactory("E33");
  e33 = await E33.deploy(/* {nonce: base_nonce+2} */);
  await e33.deployed();

  

  const E34 = await hre.ethers.getContractFactory("E34");
  e34 = await E34.deploy(/* {nonce: base_nonce+3} */);
  await e34.deployed();

  


  ////////////////////////////////////////
  const F3 = await hre.ethers.getContractFactory("F3");
  f3 = await F3.deploy(/* {nonce: base_nonce+4} */);
  await f3.deployed();

  

  const F32 = await hre.ethers.getContractFactory("F32");
  f32 = await F32.deploy(/* {nonce: base_nonce+5} */);
  await f32.deployed();

  

  const F33 = await hre.ethers.getContractFactory("F33");
  f33 = await F33.deploy(/* {nonce: base_nonce+6} */);
  await f33.deployed();

  

  ////////////////////////////////////////
  const G3 = await hre.ethers.getContractFactory("G3");
  g3 = await G3.deploy(/* {nonce: base_nonce+7} */);
  await g3.deployed();

  

  const G32 = await hre.ethers.getContractFactory("G32");
  g32 = await G32.deploy(/* {nonce: base_nonce+8} */);
  await g32.deployed();

  

  const G33 = await hre.ethers.getContractFactory("G33");
  g33 = await G33.deploy(/* {nonce: base_nonce+9} */);
  await g33.deployed();

  


  ////////////////////////////////////////
  const H3 = await hre.ethers.getContractFactory("H3");
  h3 = await H3.deploy(/* {nonce: base_nonce+10} */);
  await h3.deployed();

  

  const H32 = await hre.ethers.getContractFactory("H32");
  h32 = await H32.deploy(/* {nonce: base_nonce+11} */);
  await h32.deployed();

  



  console.log(`E3 address : ${e3.address}`);
  // console.log(`H32 address : ${h32.address}`);




  /* ---------------------------------- DEPLOY E5s ----------------------------------------- */
  const E5 = await hre.ethers.getContractFactory("E5", {
    libraries: {
      E3: e3.address,
      E32: e32.address,
      E33: e33.address
    },
  });
  e5 = await E5.connect(booter).deploy(/* {nonce: base_nonce+12} */);
  await e5.deployed();

  

  // ////////////////////////////////////////
  const F5 = await hre.ethers.getContractFactory("F5", {
    libraries: {
      F3: f3.address,
      F33: f33.address,
      E3: e3.address,
      E32: e32.address,
      E33: e33.address
    },
  });
  f5 = await F5.connect(booter).deploy(e5.address, /* {nonce: base_nonce+13} */);
  await f5.deployed();

  

  const E52 = await hre.ethers.getContractFactory("E52", {
    libraries: {
      E3: e3.address,
      E34: e34.address
    },
  });
  e52 = await E52.connect(booter).deploy(f5.address, /* {nonce: base_nonce+14} */);
  await e52.deployed();

  

  // ////////////////////////////////////////
  const G5 = await hre.ethers.getContractFactory("G5", {
    libraries: {
      E3: e3.address,
      G3: g3.address,
      G33: g33.address,
      E32: e32.address,
      E33: e33.address,
      F32: f32.address,
    },
  });
  g5 = await G5.connect(booter).deploy(f5.address, /* {nonce: base_nonce+15} */);
  await g5.deployed();

  

  const G52 = await hre.ethers.getContractFactory("G52", {
    libraries: {
      G32: g32.address,
      G33: g33.address,
      E3: e3.address,
      E32: e32.address,
      F32: f32.address,
    },
  });
  g52 = await G52.connect(booter).deploy(f5.address, /* {nonce: base_nonce+16} */);
  await g52.deployed();


  

  // ////////////////////////////////////////
  const H5 = await hre.ethers.getContractFactory("H5", {
    libraries: {
      E3: e3.address,
      E32: e32.address,
      E33: e33.address,
      // E34: e34.address,
      H3: h3.address,
      // H32: h32.address,
      F33: f33.address,
    },
  });
  h5 = await H5.connect(booter).deploy(f5.address, /* {nonce: base_nonce+17} */);
  await h5.deployed();

  

  const H52 = await hre.ethers.getContractFactory("H52", {
    libraries: {
      E3: e3.address,
      H32: h32.address
    },
  });
  h52 = await H52.connect(booter).deploy(f5.address, /* {nonce: base_nonce+18} */);
  await h52.deployed();

  

  /* ---------------------------------- BOOT E5 ------------------------------------- */
  var v1/* boot_addresses */ = [e5.address, e52.address, f5.address, g5.address, g52.address, h5.address, h52.address];
  var v2/* boot_data */ = [
    [
      [0, 0, 0, 5], [72_000_000, 73_000_000, 3, 0, 190800/* 4 */, bgN(53, 16), bgN(90, 16), bgN(5, 16)/* 7 */, 1, 2, 2/* 10 */, 0, 3/* 12 */, 1, 0, 1, 72_000_000_000, 1, 0], [bgN(1, 72), bgN(1, 72), 0/* 2 */, 0, 0, 0, bgN(100, 16)], [0], [0]
    ],
    [
      [0, 0, 0, 3],
      [72_000_000, 0, 0, 0, 540/* 4 */, 0, 0, bgN(3, 16)/* 7 */, 0, 2, 0, 72_000_000/* 11 */, 0, 0, 0, 0/* 15 */, 0, 0, 0], 
      [bgN(1, 72), bgN(1, 72), bgN(1, 70)/* 2 */, 0, 0, 0, 0], [0], [bgN(1, 9)]
    ],
    [
      [0], [0, bgN(5, 16), 0, 72_000/* 3 */, 72_000, 604800, 0, 0/* 7 */, 0, 72_000, 72_000, bgN(530, 35), 0/* 12 */, 0, 0, 0/* 15 */, 7200, 0, 0, 0/* 19 */, 0, 0, 0, bgN(53, 8)/* 23 */, bgN(90, 16), bgN(72, 8), 0, 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    ]
  ];
  var v3 = [[5, 31], [3, 31], [2, 30]];
  var v4 = [["e", "e"], ["e2", "e2"], ["e3", "e3"]];
  await e5.connect(booter)./*boot*/f157(v1, v2, v3, v4, v2[2][1], /* {nonce: base_nonce+19} */);
  await e5.connect(booter)./* record_addresses */f2023(v1, /* {nonce: base_nonce+20} */);
  var tt = parseInt(await e5./*get_time*/f147(2/* get_time */));
  var block = parseInt(await e5./* get_block */f147(3/* get_block */));
  console.log(`E5 timestamp: ${tt}`);
  console.log(`E5 block: ${block}`);
  console.log(`E5 address: ${e5.address}`);
  console.log(`E52 address: ${e52.address}`);
  console.log(`F5 address: ${f5.address}`);
  console.log(`G5 address: ${g5.address}`);
  console.log(`G52 address: ${g52.address}`);
  console.log(`H5 address: ${h5.address}`);
  console.log(`H52 address: ${h52.address}`);
}


// async function sub() {
//   var priv = '0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d';

//   const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/')
//   const signer = new ethers.Wallet(priv, provider);
//   console.log(signer.address);

//   var bal = await provider.getBalance(signer.address);
//   console.log(bal);

// }


async function sub2(){
  const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545/')

  const senderPrivateKey = '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80';
  const wallet = new ethers.Wallet(senderPrivateKey, provider);
  // const recipientAddress = '0x322b1F1F4bEa43030B2efd9BeB55eca986f57efB';//bry
  // const recipientAddress = '0xA16fa4F1f00899B0Ac3Aeb9271eb1a4759482dB6'//jayson
  const recipientAddress = '0xa88FcDa55dFE3929E3f089FbEce6Ce2728f8bf3a'//alice
  const amountToSend = ethers.utils.parseEther('10');;


  const transactionObject = {
    to: recipientAddress,
    value: amountToSend
  };

  const sendPromise = wallet.sendTransaction(transactionObject);
  sendPromise.then((transaction) => {
    console.log('Transaction hash:', transaction.hash);
    
    provider.getBalance(recipientAddress).then((balance) => {
      console.log('balance after: '+balance);
    });
    
  }).catch((error) => {
    console.error('Failed to send Ether:', error);
  });
}



main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});



// sub().catch((error) => {
//   console.error(error);
//   process.exitCode = 1;
// });



// sub2().catch((error) => {
//   console.error(error);
//   process.exitCode = 1;
// });


