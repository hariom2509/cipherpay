async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with:", deployer.address);

  const Token = await ethers.getContractFactory("ConfidentialToken");
  const token = await Token.deploy();
  await token.waitForDeployment();

  console.log("Token deployed to:", await token.getAddress());

  const Payroll = await ethers.getContractFactory("ConfidentialPayroll");
  const payroll = await Payroll.deploy(await token.getAddress());
  await payroll.waitForDeployment();

  console.log("Payroll deployed to:", await payroll.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
