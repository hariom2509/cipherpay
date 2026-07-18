const { ethers } = require("ethers");

async function main() {
  const provider = new ethers.JsonRpcProvider("https://rpc.testnet.arc.network");
  const address = "0xa4f741E099E4d953571d6E43D6cB6F90bbf82405";
  const balance = await provider.getBalance(address);
  console.log(`Balance of ${address}: ${ethers.formatEther(balance)} USDC`);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
