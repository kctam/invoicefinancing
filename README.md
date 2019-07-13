# Invoice-Finance Network
This is a demonstration of an invoice-financing network, showing how to protect against double financing on the same invoice.

This fabric network is composed of **Bank Alpha** and **Bank Beta**. Each bank has two peer nodes (peer0 and peer1). They are sharing the invoices and their current credit position. Each participating bank can open new invoice record, and the chaincode protects against double financing and over financing.

# Prepare a Node for Demonstration
We need a server running with Hyperledger Fabric ready. This node contains 
- Prerequesite of Hyperledger Fabric
- Hyperledger Fabric docker images
- Fabric samples (fabric-samples)
- Hyperledger Fabric tools (in fabric-samples/bin)

You can follow the standard installation process indicated in Hyperledger Fabric (https://hyperledger-fabric.readthedocs.io/en/latest/getting_started.html).

# Prepare the crypto material and channel artifacts
This is needed for the first time when you run this demo. After you clean up the containers indicated below, you can keep the material. *Then you do not need to generate it again in the next demo*.

First we clone this repo inside fabric-samples
```
cd fabric-samples
git clone https://github.com/kctam/invoicefinancing.git
cd invoicefinancing
```

Then we generate the required material for this network.
```
../bin/cryptogen generate --config=./crypto-config.yaml
export FABRIC_CFG_PATH=$PWD
mkdir channel-artifacts
../bin/configtxgen -profile TwoOrgsOrdererGenesis -outputBlock ./channel-artifacts/genesis.block
../bin/configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./channel-artifacts/invoice.tx -channelID invoice
```

# Bring up the network and prepare channel

First we use docker-compose to bring up the network
```
docker-compose -f docker-compose-cli.yaml up -d
```

Go into the `CLI` container
```
docker exec -it cli bash
```

Now we can use the first script `bringupeverything.sh`. This script create the channel **invoice** and have all peer nodes join the channel. After that the chaincode is installed in all nodes and instantiated on channel **invoice**.

```
cd scripts
./bringupeverything.sh
```

Now the network is ready for demonstration.

# Demonstration

Step 1: Company Lambda has an invoice (inv01) of amount $5,000. Lambda tries to apply for loan from Bank Beta. After Bank Beta accepts it as it is a brand-new invoice, it records the invoice into the network.
```
./demo_step1_bankbeta_initloan.sh
```
And we can immediately query about this loan, and we see all nodes (total 4) have this invoice in record.
```
./demo_queryloan_fourpeers.sh
```
*Note: It will take some time to instantiate chaincode containers in this step. It will be much faster in upcoming steps.*

Step 2: Bank Beta keeps the record, and decide to loan $3,000 to Lambda. And again we see this loan is shown in the record.
```
./demo_step2_bankbeta_requestloan.sh
./demo_queryloan_fourpeers.sh
```

Step 3: Lambda tries to use the same invoice to make a loan from Bank Alpha. Bank Alpha checks and finds that this invoice has recorded already in the network.
```
./demo_step3_bankalpha_initloan.sh
```

Step 4: Bank Alpha can simply reject the loan on this invoice to avoid double financing. Nevertheless, Bank Alpha decides to make a loan $1,000 to Lambda as the total borrowed amount still within the invoiced amount.
Unfortunately Bank Alpha inputs a wrong number $10,000.
```
./demo_step4_bankalpha_requestloan_over.sh
```

And we are happy to see the chaincode has protected financing over the total invoiced amount.

Step 5: Finally Bank Alpha inputs correct the amount $1,000.
```
./demo_step5_bankalpha_requestloan_1000.sh
./demo_queryloan_fourpeers.sh
```

And we see the record in the network is updated in all nodes.

# Clean-up
Perform standard clean-up steps for a fabric network once the demo is complete.
```
exit
docker-compose -f docker-compose-cli.yaml down --volumes
docker rm $(docker ps -aq)
docker rmi $(docker images dev-* -q)
```
