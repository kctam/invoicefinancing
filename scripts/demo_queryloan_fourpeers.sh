echo "Check this invoice loan from peer0 of Bank Alpha"
peer chaincode query -C invoice -n inv -c '{"Args":["queryLoan","lambda","inv01"]}'
echo 
echo "Check this invoice loan from peer1 of Bank Alpha"
CORE_PEER_ADDRESS=peer1.bankalpha.example.com:7051 peer chaincode query -C invoice -n inv -c '{"Args":["queryLoan","lambda","inv01"]}'
echo 
echo "Check this invoice loan from peer0 of Bank Beta"
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bankbeta.example.com/users/Admin@bankbeta.example.com/msp CORE_PEER_ADDRESS=peer0.bankbeta.example.com:7051 CORE_PEER_LOCALMSPID="BankBetaMSP" peer chaincode query -C invoice -n inv -c '{"Args":["queryLoan","lambda","inv01"]}'
echo
echo "Check this invoice loan from peer1 of Bank Beta"
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bankbeta.example.com/users/Admin@bankbeta.example.com/msp CORE_PEER_ADDRESS=peer1.bankbeta.example.com:7051 CORE_PEER_LOCALMSPID="BankBetaMSP" peer chaincode query -C invoice -n inv -c '{"Args":["queryLoan","lambda","inv01"]}'
echo