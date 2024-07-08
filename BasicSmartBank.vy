#pragma version ^0.3.10

owner: address
totalContractBalance: uint256

@view    
@external
def get_contract_balance() -> uint256:
    return self.totalContractBalance


balances: HashMap[address, uint256]
depositTimestamps: HashMap[address, uint256]



@payable
@external
def add_balance():
    self.owner = msg.sender
    self.balances[self.owner] = msg.value
    self.totalContractBalance = self.totalContractBalance + msg.value
    self.depositTimestamps[self.owner] = block.timestamp



@view
@internal
def get_balance(userAddress: address) -> uint256: 
    principal: uint256 = self.balances[userAddress]
    timeElapsed: uint256 = block.timestamp - self.depositTimestamps[userAddress]
    return principal



@payable
@external
def withdraw():
    amountToTransfer: uint256 = self.get_balance(self.owner)
    send(self.owner, amountToTransfer)
    self.totalContractBalance = self.totalContractBalance - amountToTransfer
    self.balances[self.owner] = 0   



