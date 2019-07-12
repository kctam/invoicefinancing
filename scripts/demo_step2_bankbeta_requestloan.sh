echo "Upon all process, Bank Beta decides to provide \$3,000 loan on this invoice. "
echo "Bank Beta invokes requestLoan() for this loan."
echo
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bankbeta.example.com/users/Admin@bankbeta.example.com/msp CORE_PEER_ADDRESS=peer0.bankbeta.example.com:7051 CORE_PEER_LOCALMSPID="BankBetaMSP" peer chaincode invoke -o orderer.example.com:7050 -C invoice -n inv --peerAddresses peer0.bankalpha.example.com:7051 --peerAddresses peer0.bankbeta.example.com:7051 -c '{"Args":["requestLoan","lambda","inv01","3000"]}'
echo