echo "create channel invoice..."
peer channel create -o orderer.example.com:7050 -c invoice -f ../channel-artifacts/invoice.tx
sleep 3

echo
echo "join channel from all peer nodes..."
echo "- peer0.bankalpha"
peer channel join -b invoice.block
sleep 3
echo "- peer1.bankalpha"
CORE_PEER_ADDRESS=peer1.bankalpha.example.com:7051 peer channel join -b invoice.block
sleep 3
echo "- peer0.bankbeta"
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bankbeta.example.com/users/Admin@bankbeta.example.com/msp CORE_PEER_ADDRESS=peer0.bankbeta.example.com:7051 CORE_PEER_LOCALMSPID="BankBetaMSP" peer channel join -b invoice.block
sleep 3
echo "- peer1.bankbeta"
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bankbeta.example.com/users/Admin@bankbeta.example.com/msp CORE_PEER_ADDRESS=peer1.bankbeta.example.com:7051 CORE_PEER_LOCALMSPID="BankBetaMSP" peer channel join -b invoice.block
sleep 3

echo
echo "install chaincode on all peer nodes..."
echo "- peer0.bankalpha"
peer chaincode install -n inv -v 1 -p github.com/chaincode/invfinancing/

echo "- peer1.bankalpha"
CORE_PEER_ADDRESS=peer1.bankalpha.example.com:7051 peer chaincode install -n inv -v 1 -p github.com/chaincode/invfinancing/

echo "- peer0.bankbeta"
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bankbeta.example.com/users/Admin@bankbeta.example.com/msp CORE_PEER_ADDRESS=peer0.bankbeta.example.com:7051 CORE_PEER_LOCALMSPID="BankBetaMSP" peer chaincode install -n inv -v 1 -p github.com/chaincode/invfinancing/

echo "- peer1.bankbeta"
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bankbeta.example.com/users/Admin@bankbeta.example.com/msp CORE_PEER_ADDRESS=peer1.bankbeta.example.com:7051 CORE_PEER_LOCALMSPID="BankBetaMSP" peer chaincode install -n inv -v 1 -p github.com/chaincode/invfinancing/


echo "instantiate chaincode from peer0.bankalpha..."
peer chaincode instantiate -C invoice -n inv -v 1 -c '{"Args":[]}' -P "AND ('BankAlphaMSP.member','BankBetaMSP.member')"

