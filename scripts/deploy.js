const hre = require("hardhat");

async function main() { 
  const Bank = await hre.ethers.getContractFactory("Bank");
  const bank = await Bank.deploy();

  await bank.deployed();

  bank.on("Deposit", (owner, amount) => {
    console.log(`New deposit: ${owner} ${amount.toString()} WEI`);
  });

  bank.on("Withdraw", (owner, amount) => {
    console.log(`New withdraw: ${owner} ${amount.toString()} WEI`);
  });

  bank.on("Transfer", (from, to, amount) => {
    console.log(`New transfer: ${from} ${to} ${amount.toString()} WEI`);
  });

  bank.on("Purchase", (buyer, itemName, quantity) => {
    console.log(`New purchase: ${buyer} bought ${quantity.toString()} of ${itemName}`);
  });

  bank.on("Reward", (recipient, amount) => {
    console.log(`New reward: ${recipient} received ${amount.toString()} WEI`);
  });

  bank.on("Penalty", (recipient, amount) => {
    console.log(`New penalty: ${recipient} incurred a penalty of ${amount.toString()} WEI`);
  });

  console.log(
    `Contract deployed to ${bank.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
