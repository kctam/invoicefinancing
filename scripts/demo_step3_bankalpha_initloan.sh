echo "Company Lambda comes Bank Alpha, asking for an invoice financing with the same invoice."
echo "Bank Alpha invokes initLoan() on this invoice."
echo
peer chaincode invoke -C invoice -n inv --peerAddresses peer0.bankalpha.example.com:7051 --peerAddresses peer0.bankbeta.example.com:7051 -c '{"Args":["initLoan","lambda","inv01","5000"]}'
echo