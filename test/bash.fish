cp .env.example .env       # fill in BASE_RPC_URL, ETHERSCAN_API_KEY, and one of DEPLOYER (+ keystore) or DEPLOYER_PRIVATE_KEY
# Dry-run (simulation only)
NETWORKS=base forge script script/Deploy.s.sol --sig "run()" -vvv

# Broadcast + verify (keystore-based — preferred)
cast wallet import beta-deployer --interactive   # one-time keystore import
NETWORKS=base forge script script/Deploy.s.sol --sig "run()" -vvv \
    --account beta-deployer --sender $DEPLOYER --broadcast --verify

# Broadcast + verify (raw private key — one-shot)
DEPLOYER_PRIVATE_KEY=0x... NETWORKS=base forge script script/Deploy.s.sol \
    --sig "run()" -vvv --broadcast --verify
cd packages/tool-registry
forge install
forge build
REGISTRY=0x265BB2DBFC0A8165C9A1941Eb1372F349baD2cf1 \
NETWORKS=base forge script script/DeployTraitGatedPredicate.s.sol --sig "run()" -vvv \
    --account beta-deployer --sender $DEPLOYER --broadcast --verify
REGISTRY=0x265BB2DBFC0A8165C9A1941Eb1372F349baD2cf1 \
NETWORKS=base forge script script/DeployERC20BalancePredicate.s.sol --sig "run()" -vvv \
    --account beta-deployer --sender $DEPLOYER --broadcast --verify
