echo "Upon all process, Bank Alpha decides to provide \$1,000 loan on this invoice. "
echo "Bank Alpha invokes requestLoan() for this loan."
echo
peer chaincode invoke -C invoice -n inv --peerAddresses peer0.bankalpha.example.com:7051 --peerAddresses peer0.bankbeta.example.com:7051 -c '{"Args":["requestLoan","lambda","inv01","1000"]}'
echo 