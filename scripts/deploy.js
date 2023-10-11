// We require the Hardhat Runtime Environment explicitly here. This is optional 
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  
  const DutchAuction = await hre.ethers.getContractFactory("DutchAuction");
  const dutchAuction = await DutchAuction.deploy();
  await dutchAuction.deployed();
  console.log("dutchAuction deployed to:", dutchAuction.address);

  const CodePanther = await hre.ethers.getContractFactory("CodePanther");
  const codePanther = await CodePanther.deploy();
  await codePanther.deployed();
  console.log("codePanther deployed to:", codePanther.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
