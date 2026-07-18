const { ethers } = require("ethers");
const fs = require("fs");
const path = require("path");

async function main() {
  const wallet = ethers.Wallet.createRandom();
  console.log("=========================================");
  console.log("Generated New Deployer Wallet:");
  console.log("Address:    ", wallet.address);
  console.log("Private Key:", wallet.privateKey);
  console.log("=========================================");

  const envPath = path.join(__dirname, "..", ".env");
  const envContent = `PRIVATE_KEY="${wallet.privateKey}"\n`;
  fs.writeFileSync(envPath, envContent, { flag: "w" });
  console.log("Saved private key to .env file");
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
