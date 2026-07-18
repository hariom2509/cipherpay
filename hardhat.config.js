require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

const PRIVATE_KEY = process.env.PRIVATE_KEY || "0x0000000000000000000000000000000000000000000000000000000000000000";

module.exports = {
  solidity: "0.8.20",
  networks: {
    arcTestnet: {
      url: "https://rpc.testnet.arc.network",
      chainId: 5042002,
      accounts: [PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: {
      arcTestnet: "any-string-value",
    },
    customChains: [
      {
        network: "arcTestnet",
        chainId: 5042002,
        urls: {
          apiURL: "https://testnet.arcscan.app/api",
          browserURL: "https://testnet.arcscan.app",
        },
      },
    ],
  },
};
