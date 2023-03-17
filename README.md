# solidity
transaction is a message that is sent from one account to another account (which might be the same or empty, see below). It can include binary data (which is called “payload”) and Ether. If the target account contains code, that code is executed and the payload is provided as input data.

In computer programming, a transaction usually means a sequence of information exchange and related work (such as database updating) that is treated as a unit for the purposes of satisfying a request and for ensuring database integrity.

There exist three types of Transaction inside Ethereum: (1) fund Transfer between EOA, (2) deploy a Contract and (3) execution of a contract already deployed Fig.
A smart contract is application code that resides at a specific address on the blockchain known as a contract address. Applications can call the smart contract functions, change their state, and initiate transactions. Smart contracts are written in programming languages such as Solidity and Vyper, and are compiled by the Ethereum Virtual Machine into bytecode and executed on the blockchain

You can pay for transactions using Ether. Ether serves two purposes. First, it prevents bad actors from congesting the network with unnecessary transactions. Second, it acts as an incentive for users to contribute resources and validate transactions (mining). Each transaction in Ethereum constitutes a series of operations to occur on the network (i.e. a transfer of Ether from one account to another or a complex state-changing operation in a smart contract). Each of these operations have a cost, which is measured in gas, the fee-measure in Ethereum. Gas fees are are paid in Ether, and are often measured in a smaller denomination called gwei. [1 ether = 1,000,000,000 gwei (10^9)]

When a transaction triggers a smart contract, all nodes of the network execute every instruction. To do this, Ethereum implements an execution environment on the blockchain called the Ethereum Virtual Machine (EVM). All nodes on the network run the EVM as part of the block verification protocol. In block verification, each node goes through the transactions listed in the block they are verifying and runs the code as triggered by the transactions in the EVM. All nodes on the network do the same calculations to keep their ledgers in sync. Every transaction must include a gas limit and a fee that the sender is willing to pay for the transaction. Miners have the choice of including the transaction and collecting the fee or not. If the total amount of gas needed to process the transaction is less than or equal to the gas limit, the transaction is processed. If the gas expended reaches the gas limit before the transaction is completed, the transaction does not go through and the fee is still lost. All gas not used by transaction execution is reimbursed to the sender as Ether. This means that it's safe to send transactions with a gas limit above the estimates
