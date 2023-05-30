// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
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

  const [booter, addr1, addr2] = await ethers.getSigners();
  const E3 = await hre.ethers.getContractFactory("E3");
  e3 = await E3.deploy();
  await e3.deployed();

  const E32 = await hre.ethers.getContractFactory("E32");
  e32 = await E32.deploy();
  await e32.deployed();

  const E33 = await hre.ethers.getContractFactory("E33");
  e33 = await E33.deploy();
  await e33.deployed();

  const E34 = await hre.ethers.getContractFactory("E34");
  e34 = await E34.deploy();
  await e34.deployed();



  ////////////////////////////////////////
  const F3 = await hre.ethers.getContractFactory("F3");
  f3 = await F3.deploy();
  await f3.deployed();

  const F32 = await hre.ethers.getContractFactory("F32");
  f32 = await F32.deploy();
  await f32.deployed();

  const F33 = await hre.ethers.getContractFactory("F33");
  f33 = await F33.deploy();
  await f33.deployed();

  ////////////////////////////////////////
  const G3 = await hre.ethers.getContractFactory("G3");
  g3 = await G3.deploy();
  await g3.deployed();

  const G32 = await hre.ethers.getContractFactory("G32");
  g32 = await G32.deploy();
  await g32.deployed();

  const G33 = await hre.ethers.getContractFactory("G33");
  g33 = await G33.deploy();
  await g33.deployed();


  ////////////////////////////////////////
  const H3 = await hre.ethers.getContractFactory("H3");
  h3 = await H3.deploy();
  await h3.deployed();

  const H32 = await hre.ethers.getContractFactory("H32");
  h32 = await H32.deploy();
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
  e5 = await E5.connect(booter).deploy();
  await e5.deployed();

  // ////////////////////////////////////////
  const F5 = await hre.ethers.getContractFactory("F5", {
    libraries: {
      F3: f3.address,
      F33: f33.address,
      E3: e3.address,
      E32: e32.address
    },
  });
  f5 = await F5.connect(booter).deploy(e5.address);
  await f5.deployed();

  const E52 = await hre.ethers.getContractFactory("E52", {
    libraries: {
      E3: e3.address,
      E34: e34.address
    },
  });
  e52 = await E52.connect(booter).deploy(f5.address);
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
  g5 = await G5.connect(booter).deploy(f5.address);
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
  g52 = await G52.connect(booter).deploy(f5.address);
  await g52.deployed();


  // ////////////////////////////////////////
  const H5 = await hre.ethers.getContractFactory("H5", {
    libraries: {
      E3: e3.address,
      E32: e32.address,
      E33: e33.address,
      E34: e34.address,
      H3: h3.address,
      H32: h32.address,
    },
  });
  h5 = await H5.connect(booter).deploy(f5.address);
  await h5.deployed();

  const H52 = await hre.ethers.getContractFactory("H52", {
    libraries: {
      E3: e3.address,
      H32: h32.address
    },
  });
  h52 = await H52.connect(booter).deploy(f5.address);
  await h52.deployed();


  /* ---------------------------------- BOOT E5 ------------------------------------- */
  /* 126000: 35hrs 3024000: 35dys */
  var v1/* boot_addresses */ = [e5.address, e52.address, f5.address, g5.address, g52.address, h5.address, h52.address];
  var v2/* boot_data */ = [
    [ /* spend */
      [0, 0, 0, 5], [bgN(35, 6), bgN(35, 6), 3, 0, 126000/* 4 */, bgN(53, 16), bgN(90, 16), bgN(5, 16)/* 7 */, 3, 0, 0, 0, 2/* 12 */, 1, bgN(3, 16), 1, bgN(53, 9), 1, 0], [bgN(1, 72), bgN(1, 72), 0/* 2 */, 0, 0, 0, bgN(100, 16)], [0], [0]
    ],
    [ /* end */
      [0, 0, 0, 3],
      [bgN(35, 12), 0, 0, 0, 0, 0, 0, bgN(3, 16)/* 7 */, 0, 2, 0, bgN(35, 6)/* 11 */, 0, 0, 0, 0/* 15 */, 0, 0, 0], [bgN(1, 72), bgN(1, 72), bgN(1, 70)/* 2 */, 0, 0, 0, 0], [0], [bgN(1, 9)]
    ],
    [ /* main contract */
      [0], [0, bgN(1, 16), 0, bgN(5, 6)/* 3 */, bgN(5, 6), 3024000, 0, 0/* 7 */, 0, bgN(5, 6), bgN(5, 6), bgN(53, 5), 0/* 12 */, 0, 1, 0/* 15 */, 72, 0, 0, 3/* 19 */, 0, 0, 0, bgN(53, 8)/* 23 */, bgN(90, 16), bgN(72, 8), 0, 0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    ]
    //<12>contract_block_invocation_limit - 1
    //<13>contract_time_invocation_limit - 650
  ];
  var v3/* boot_id_data_type_data */ = [[5, 31], [3, 31], [2, 30]];
  var v4/* boot_object_metadata */ = [["e", "e"], ["e2", "e2"], ["e3", "e3"]];
  await e5.connect(booter)./*boot*/f157(v1, v2, v3, v4, v2[2][1]);
  var tt = parseInt(await e5./*get_time*/f147(2/* get_time */));

  console.log(`E5 timestamp: ${tt}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
