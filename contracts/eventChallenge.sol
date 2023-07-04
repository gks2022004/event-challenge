// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Bank {
    mapping(address => uint) private balances;

    event Deposit(address indexed owner, uint indexed amount);
    event Withdraw(address indexed owner, uint indexed amount);
    event Transfer(address indexed from, address indexed to, uint indexed amount);
    event Purchase(address indexed buyer, string itemName, uint indexed quantity);
    event Reward(address indexed recipient, uint indexed amount);
    event Penalty(address indexed recipient, uint indexed amount);

    function deposit(address _account, uint _number) public payable {
        balances[_account] += _number;
        emit Deposit(_account, _number);
    }

    function withdraw(address _account, uint _number) public payable {
        require(balances[_account] >= _number, "Insufficient balance");
        balances[_account] -= _number;
        emit Withdraw(_account, _number);
    }

    function transfer(address _from, address _to, uint _number) public payable {
        require(balances[_from] >= _number, "Insufficient balance for transfer");
        balances[_from] -= _number;
        balances[_to] += _number;
        emit Transfer(_from, _to, _number);
    }

    function purchaseItem(address _buyer, string memory _itemName, uint _quantity) public payable {
        require(balances[_buyer] >= _quantity, "Insufficient balance for purchase");
        balances[_buyer] -= _quantity;
        emit Purchase(_buyer, _itemName, _quantity);
    }

    function rewardUser(address _recipient, uint _amount) public payable {
        balances[_recipient] += _amount;
        emit Reward(_recipient, _amount);
    }

    function penalizeUser(address _recipient, uint _amount) public payable {
        require(balances[_recipient] >= _amount, "Insufficient balance for penalty");
        balances[_recipient] -= _amount;
        emit Penalty(_recipient, _amount);
    }

    function getBalance(address _address) public view returns(uint) {
        return balances[_address];
    }
}
