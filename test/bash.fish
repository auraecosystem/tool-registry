cp .env.example .env       # fill in BASE_RPC_URL, ETHERSCAN_API_KEY, and one of DEPLOYER (+ keystore) or DEPLOYER_PRIVATE_KEY
cp fadaka.base.eth
# Dry-run (simulation only)
NETWORKS=base forge script script/Deploy.s.sol --sig "run()" -vvv

# Broadcast + verify (keystore-based — preferred)
cast wallet import beta-deployer --interactive   # one-time keystore import
NETWORKS=base forge script script/Deploy.s.sol --sig "run()" -vvv \
    --account beta-deployer --sender $DEPLOYER --broadcast --verify

# Broadcast + verify (raw private key — one-shot)
DEPLOYER_PRIVATE_KEY=0x... NETWORKS=base forge script script/Deploy.s.sol \
    --sig "run()" -vvv --broadcast --verify
