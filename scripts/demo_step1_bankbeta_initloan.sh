echo "Company Lambda comes Bank Beta, asking for an invoice financing with invoice number inv01 with amount \$5,000."
echo "Bank Beta invokes initLoan() on this invoice."
echo
CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/bankbeta.example.com/users/Admin@bankbeta.example.com/msp CORE_PEER_ADDRESS=peer0.bankbeta.example.com:7051 CORE_PEER_LOCALMSPID="BankBetaMSP" peer chaincode invoke -o orderer.example.com:7050 -C invoice -n inv --peerAddresses peer0.bankalpha.example.com:7051 --peerAddresses peer0.bankbeta.example.com:7051 -c '{"Args":["initLoan","lambda","inv01","5000"]}'
echo