// Decompiled by library.dedaub.com
// 2026.02.28 09:17 UTC
// Compiled using the solidity compiler version 0.8.9


// Data structures and variables inferred from the use of storage instructions
uint8 stor_0_0_0; // STORAGE[0x0] bytes 0 to 0
bool _init; // STORAGE[0x0] bytes 1 to 1
uint256 _stakeTax; // STORAGE[0x65]
uint256 stor_66; // STORAGE[0x66]
uint256 _slippage; // STORAGE[0x67]
uint256 _rewardRate; // STORAGE[0x69]
uint256 _lastUpdateBlock; // STORAGE[0x6a]
uint256 _rewardPerTokenStored; // STORAGE[0x6b]
mapping (address => uint256) _userRewardPerTokenPaid; // STORAGE[0x6c]
mapping (address => uint256) _rewards; // STORAGE[0x6d]
mapping (address => uint256) __balances; // STORAGE[0x6e]
address _owner; // STORAGE[0x33] bytes 0 to 19
address _feeAddress; // STORAGE[0x68] bytes 0 to 19
address _rewardsToken; // STORAGE[0x6f] bytes 0 to 19
address _stakingToken; // STORAGE[0x70] bytes 0 to 19
address _fundManager; // STORAGE[0x71] bytes 0 to 19
address _exchange; // STORAGE[0x72] bytes 0 to 19


// Events
SwapSuccess(uint256, uint256);
Initialized(uint8);
OwnershipTransferred(address, address);

function 0x178d(address varg0, address varg1) private { 
    require(_owner == msg.sender, Error('Ownable: caller is not the owner'));
    require(bool(varg1.code.size));
    v0, /* uint256 */ v1 = varg1.balanceOf(address(this)).gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(bool(varg1.code.size));
    v2, /* bool */ v3 = varg1.transfer(varg0, v1).gas(msg.gas);
    require(bool(v2), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v3 == bool(v3));
    return ;
}

function 0x2012() private { 
    require(bool(_stakingToken.code.size));
    v0, /* uint256 */ v1 = _stakingToken.balanceOf(address(this)).gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    if (v1 != 0) {
        v2 = _SafeSub(block.number, _lastUpdateBlock);
        v3 = _SafeMul(v2, _rewardRate);
        v4 = _SafeMul(v3, 10 ** 32);
        v5 = _SafeDiv(v4, v1);
        v6 = _SafeAdd(_rewardPerTokenStored, v5);
        return v6;
    } else {
        return 0;
    }
}

function earned(address account) public payable { 
    require(4 + (msg.data.length - 4) - 4 >= 32);
    v0 = 0x64b(account);
    return v0;
}

function 0x0613ae42() public payable { 
    0x7f5();
}

function rewards(address varg0) public payable { 
    require(4 + (msg.data.length - 4) - 4 >= 32);
    return _rewards[varg0];
}

function stakeTax() public payable { 
    return _stakeTax;
}

function totalSupply() public payable { 
    require(bool(_stakingToken.code.size));
    v0, /* uint256 */ v1 = _stakingToken.balanceOf(address(this)).gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    return v1;
}

function _SafeSub(uint256 varg0, uint256 varg1) private { 
    require(varg0 >= varg1, Panic(17)); // arithmetic overflow or underflow
    return varg0 - varg1;
}

function _SafeMul(uint256 varg0, uint256 varg1) private { 
    require(!(bool(varg0) & (varg1 > uint256.max / varg0)), Panic(17)); // arithmetic overflow or underflow
    return varg0 * varg1;
}

function _SafeDiv(uint256 varg0, uint256 varg1) private { 
    require(varg1, Panic(18)); // division by zero
    return varg0 / varg1;
}

function _SafeAdd(uint256 varg0, uint256 varg1) private { 
    require(varg0 <= uint256.max - varg1, Panic(17)); // arithmetic overflow or underflow
    return varg0 + varg1;
}

function init(address _operator, address _rewardPool, address _baseToken) public payable { 
    require(4 + (msg.data.length - 4) - 4 >= 96);
    v0 = _init;
    v1 = v2 = !v0;
    if (!_init) {
        v1 = v3 = stor_0_0_0 < 1;
    }
    if (!v1) {
        v1 = v4 = (address(this)).code.size <= 0;
        if ((address(this)).code.size <= 0) {
            v1 = stor_0_0_0 == 1;
        }
    }
    require(v1, Error('Initializable: contract is already initialized'));
    stor_0_0_0 = 1;
    if (!_init) {
        _init = 1;
    }
    require(_init, Error('Initializable: contract is not initializing'));
    require(_init, Error('Initializable: contract is not initializing'));
    _owner = msg.sender;
    emit OwnershipTransferred(_owner, msg.sender);
    _stakingToken = _operator;
    _rewardsToken = _rewardPool;
    _feeAddress = msg.sender;
    _stakeTax = 2;
    stor_66 = 2;
    _rewardRate = 10;
    _slippage = 18;
    _fundManager = _baseToken;
    if (!_init) {
        _init = 0;
        emit Initialized(uint8(1));
    }
}

function withdraw(uint256 _amount) public payable { 
    require(4 + (msg.data.length - 4) - 4 >= 32);
    v0 = 0x2012();
    _rewardPerTokenStored = v0;
    _lastUpdateBlock = block.number;
    v1 = 0x64b(msg.sender);
    _rewards[msg.sender] = v1;
    _userRewardPerTokenPaid[msg.sender] = _rewardPerTokenStored;
    require(__balances[msg.sender] >= _amount, Error('Insuficient balance'));
    if (_amount == 0) {
        v2 = v3 = __balances[msg.sender];
    }
    v4 = _SafeSub(__balances[msg.sender], v2);
    __balances[msg.sender] = v4;
    v5 = v6 = 0;
    if (stor_66 > v6) {
        v7 = _SafeMul(v2, _stakeTax);
        v5 = _SafeDiv(v7, 100);
        require(bool(_stakingToken.code.size));
        v8, /* bool */ v9 = _stakingToken.transfer(_feeAddress, v5).gas(msg.gas);
        require(bool(v8), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
        require(v9 == bool(v9));
    }
    v10 = _SafeSub(v2, v5);
    require(bool(_stakingToken.code.size));
    v11, /* bool */ v12 = _stakingToken.transfer(msg.sender, v10).gas(msg.gas);
    require(bool(v11), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v12 == bool(v12));
    0x7f5();
}

function getReward() public payable { 
    v0 = 0x2012();
    _rewardPerTokenStored = v0;
    _lastUpdateBlock = block.number;
    v1 = 0x64b(msg.sender);
    _rewards[msg.sender] = v1;
    _userRewardPerTokenPaid[msg.sender] = _rewardPerTokenStored;
    _rewards[msg.sender] = 0;
    require(bool(_rewardsToken.code.size));
    v2 = _rewardsToken.mint(msg.sender, _rewards[msg.sender]).gas(msg.gas);
    require(bool(v2), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
}

function slippage() public payable { 
    return _slippage;
}

function feeAddress() public payable { 
    return _feeAddress;
}

function rescueTokens(address _token, address _to) public payable { 
    require(4 + (msg.data.length - 4) - 4 >= 64);
    0x178d(_to, _token);
}

function fundManager() public payable { 
    return _fundManager;
}

function forceExit() public payable { 
    v0 = 0x2012();
    _rewardPerTokenStored = v0;
    _lastUpdateBlock = block.number;
    v1 = 0x64b(msg.sender);
    _rewards[msg.sender] = v1;
    _userRewardPerTokenPaid[msg.sender] = _rewardPerTokenStored;
    require(__balances[msg.sender] > 0, Error('No balance'));
    __balances[msg.sender] = 0;
    require(bool(_stakingToken.code.size));
    v2, /* bool */ v3 = _stakingToken.transfer(msg.sender, __balances[msg.sender]).gas(msg.gas);
    require(bool(v2), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v3 == bool(v3));
}

function setExchange(address varg0) public payable { 
    require(4 + (msg.data.length - 4) - 4 >= 32);
    require(_owner == msg.sender, Error('Ownable: caller is not the owner'));
    _exchange = varg0;
}

function _balances(address varg0) public payable { 
    require(4 + (msg.data.length - 4) - 4 >= 32);
    return __balances[varg0];
}

function 0x6fef3eae(uint8 varg0) public payable { 
    require(4 + (msg.data.length - 4) - 4 >= 32);
    require(_owner == msg.sender, Error('Ownable: caller is not the owner'));
    require(varg0 <= 100, Error('Tax cannot be greater than 100%'));
    stor_66 = varg0;
}

function renounceOwnership() public payable { 
    require(_owner == msg.sender, Error('Ownable: caller is not the owner'));
    _owner = 0;
    emit OwnershipTransferred(_owner, address(0x0));
}

function stakingToken() public payable { 
    return _stakingToken;
}

function rewardRate() public payable { 
    return _rewardRate;
}

function destroy() public payable { 
    require(_owner == msg.sender, Error('Ownable: caller is not the owner'));
    require(bool(_stakingToken.code.size));
    v0, /* uint256 */ v1 = _stakingToken.balanceOf(address(this)).gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    require(v1 == 0, Error('Tokens still in pool'));
    selfdestruct(msg.sender);
}

function setFeeAddress(address varg0) public payable { 
    require(4 + (msg.data.length - 4) - 4 >= 32);
    require(_owner == msg.sender, Error('Ownable: caller is not the owner'));
    require(_feeAddress != varg0, Error('New address is the same as old address'));
    require(varg0 != address(0x0), Error('New address cannot be 0x00'));
    _feeAddress = varg0;
}

function 0x8b538f65(uint8 varg0) public payable { 
    require(4 + (msg.data.length - 4) - 4 >= 32);
    require(_owner == msg.sender, Error('Ownable: caller is not the owner'));
    require(varg0 <= 100, Error('Tax cannot be greater than 100%'));
    _stakeTax = varg0;
}

function userRewardPerTokenPaid(address varg0) public payable { 
    require(4 + (msg.data.length - 4) - 4 >= 32);
    return _userRewardPerTokenPaid[varg0];
}

function 0x8d8a7e23() public payable { 
    return stor_66;
}

function owner() public payable { 
    return _owner;
}

function setRewardRate(uint256 varg0) public payable { 
    require(4 + (msg.data.length - 4) - 4 >= 32);
    require(_owner == msg.sender, Error('Ownable: caller is not the owner'));
    v0 = 0x2012();
    _rewardPerTokenStored = v0;
    _lastUpdateBlock = block.number;
    _rewardRate = varg0;
}

function lastUpdateBlock() public payable { 
    return _lastUpdateBlock;
}

function stake(uint256 amount) public payable { 
    require(4 + (msg.data.length - 4) - 4 >= 32);
    v0 = 0x2012();
    _rewardPerTokenStored = v0;
    _lastUpdateBlock = block.number;
    v1 = 0x64b(msg.sender);
    _rewards[msg.sender] = v1;
    _userRewardPerTokenPaid[msg.sender] = _rewardPerTokenStored;
    revert(Error('Staking disabled'));
}

function rewardPerToken() public payable { 
    v0 = 0x2012();
    return v0;
}

function rewardsToken() public payable { 
    return _rewardsToken;
}

function exchange() public payable { 
    return _exchange;
}

function 0xdbafd916(address varg0) public payable { 
    require(4 + (msg.data.length - 4) - 4 >= 32);
    require(_owner == msg.sender, Error('Ownable: caller is not the owner'));
    _fundManager = varg0;
}

function rewardPerTokenStored() public payable { 
    return _rewardPerTokenStored;
}

function setSlippage(uint256 varg0) public payable { 
    require(4 + (msg.data.length - 4) - 4 >= 32);
    require(_owner == msg.sender, Error('Ownable: caller is not the owner'));
    _slippage = varg0;
}

function transferOwnership(address newOwner) public payable { 
    require(4 + (msg.data.length - 4) - 4 >= 32);
    require(_owner == msg.sender, Error('Ownable: caller is not the owner'));
    require(newOwner != address(0x0), Error('Ownable: new owner is the zero address'));
    _owner = newOwner;
    emit OwnershipTransferred(_owner, newOwner);
}

function compound() public payable { 
    v0 = 0x2012();
    _rewardPerTokenStored = v0;
    _lastUpdateBlock = block.number;
    v1 = 0x64b(msg.sender);
    _rewards[msg.sender] = v1;
    _userRewardPerTokenPaid[msg.sender] = _rewardPerTokenStored;
    v2 = v3 = _rewards[msg.sender];
    _rewards[msg.sender] = 0;
    if (_stakeTax > 0) {
        v4 = _SafeMul(v3, _stakeTax);
        v5 = _SafeDiv(v4, 100);
        v2 = v6 = _SafeSub(v3, v5);
        require(bool(_rewardsToken.code.size));
        v7 = _rewardsToken.mint(_feeAddress, v5).gas(msg.gas);
        require(bool(v7), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    }
    require(bool(_rewardsToken.code.size));
    v8 = _rewardsToken.mint(address(this), v2).gas(msg.gas);
    require(bool(v8), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    v9 = _SafeAdd(__balances[msg.sender], v2);
    __balances[msg.sender] = v9;
    0x7f5();
}

function stakedAmount(address varg0) public payable { 
    require(4 + (msg.data.length - 4) - 4 >= 32);
    return __balances[varg0];
}

function 0x64b(address varg0) private { 
    if (__balances[varg0] != 0) {
        v0 = 0x2012();
        v1 = _SafeSub(v0, _userRewardPerTokenPaid[varg0]);
        v2 = _SafeMul(__balances[varg0], v1);
        v3 = _SafeDiv(v2, 10 ** 32);
        v4 = _SafeMul(v3, 10 ** 18);
        v5 = _SafeAdd(v4, _rewards[varg0]);
        return v5;
    } else {
        return _rewards[varg0];
    }
}

function fallback() public payable { 
    revert();
}

function 0x7f5() private { 
    require(bool(_fundManager.code.size));
    v0, /* uint256 */ v1 = _fundManager.pendingRewards().gas(msg.gas);
    require(bool(v0), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
    require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
    if (v1 != 0) {
        require(bool(_fundManager.code.size));
        v2 = _fundManager.claim(v1).gas(msg.gas);
        require(bool(v2), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        require(bool(_exchange.code.size));
        v3, /* address */ v4 = _exchange.busd().gas(msg.gas);
        require(bool(v3), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
        require(v4 == address(v4));
        require(bool((address(v4)).code.size));
        v5, /* uint256 */ v6 = address(v4).balanceOf(address(this)).gas(msg.gas);
        require(bool(v5), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
        require(bool(_rewardsToken.code.size));
        v7, /* uint256 */ v8 = _rewardsToken.balanceOf(address(this)).gas(msg.gas);
        require(bool(v7), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
        require(bool(_exchange.code.size));
        v9, /* address */ v10 = _exchange.busd().gas(msg.gas);
        require(bool(v9), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
        require(v10 == address(v10));
        require(bool((address(v10)).code.size));
        v11, /* bool */ v12 = address(v10).increaseAllowance(_exchange, v8).gas(msg.gas);
        require(bool(v11), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
        MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
        require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
        require(v12 == bool(v12));
        v13 = _SafeMul(v6, _slippage);
        v14 = _SafeDiv(v13, 100);
        v15 = _SafeSub(v6, v14);
        require(bool(_exchange.code.size));
        v16 = v17 = _exchange.buy(v6, v15).gas(msg.gas);
        if (v17) {
            v16 = v18 = 1;
        }
        if (v16) {
            require(bool(_rewardsToken.code.size));
            v19, /* uint256 */ v20 = _rewardsToken.balanceOf(address(this)).gas(msg.gas);
            require(bool(v19), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
            MEM[64] = MEM[64] + (RETURNDATASIZE() + 31 & 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0);
            require(MEM[64] + RETURNDATASIZE() - MEM[64] >= 32);
            v21 = _SafeSub(v20, v8);
            require(bool(_rewardsToken.code.size));
            v22 = _rewardsToken.burn(v21).gas(msg.gas);
            require(bool(v22), 0, RETURNDATASIZE()); // checks call status, propagates error data on error
            emit SwapSuccess(v6, _slippage);
            return ;
        } else {
            emit 0x995a3a8a2e2612b6b89854de70b658cfa9d5b2239a4723cea9c9588b70f7553(v6, _slippage);
            return ;
        }
    } else {
        return ;
    }
}

// Note: The function selector is not present in the original solidity code.
// However, we display it for the sake of completeness.

function __function_selector__( function_selector) public payable { 
    MEM[64] = 128;
    require(!msg.value);
    if (msg.data.length < 4) {
        fallback();
    } else {
        v0 = function_selector >> 224;
        if (0x7b0a47ee > v0) {
            if (0x41275358 > v0) {
                if (0x18160ddd > v0) {
                    if (0x8cc262 == v0) {
                        earned(address);
                    } else if (0x613ae42 == v0) {
                        0x0613ae42();
                    } else if (0x700037d == v0) {
                        rewards(address);
                    } else {
                        require(0x9bc773f == v0);
                        stakeTax();
                    }
                } else if (0x18160ddd == v0) {
                    totalSupply();
                } else if (0x184b9559 == v0) {
                    init(address,address,address);
                } else if (0x2e1a7d4d == v0) {
                    withdraw(uint256);
                } else if (0x3d18b912 == v0) {
                    getReward();
                } else {
                    require(0x3e032a3b == v0);
                    slippage();
                }
            } else if (0x67b1f5df > v0) {
                if (0x41275358 == v0) {
                    feeAddress();
                } else if (0x5431c94e == v0) {
                    rescueTokens(address,address);
                } else if (0x6209ec2d == v0) {
                    fundManager();
                } else {
                    require(0x67acc704 == v0);
                    forceExit();
                }
            } else if (0x67b1f5df == v0) {
                setExchange(address);
            } else if (0x6ebcf607 == v0) {
                _balances(address);
            } else if (0x6fef3eae == v0) {
                0x6fef3eae();
            } else if (0x715018a6 == v0) {
                renounceOwnership();
            } else {
                require(0x72f702f3 == v0);
                stakingToken();
            }
        } else if (0xa694fc3a > v0) {
            if (0x8b876347 > v0) {
                if (0x7b0a47ee == v0) {
                    rewardRate();
                } else if (0x83197ef0 == v0) {
                    destroy();
                } else if (0x8705fcd4 == v0) {
                    setFeeAddress(address);
                } else {
                    require(0x8b538f65 == v0);
                    0x8b538f65();
                }
            } else if (0x8b876347 == v0) {
                userRewardPerTokenPaid(address);
            } else if (0x8d8a7e23 == v0) {
                0x8d8a7e23();
            } else if (0x8da5cb5b == v0) {
                owner();
            } else if (0x9e447fc6 == v0) {
                setRewardRate(uint256);
            } else {
                require(0xa218141b == v0);
                lastUpdateBlock();
            }
        } else if (0xdf136d65 > v0) {
            if (0xa694fc3a == v0) {
                stake(uint256);
            } else if (0xcd3daf9d == v0) {
                rewardPerToken();
            } else if (0xd1af0c7d == v0) {
                rewardsToken();
            } else if (0xd2f7265a == v0) {
                exchange();
            } else {
                require(0xdbafd916 == v0);
                0xdbafd916();
            }
        } else if (0xdf136d65 == v0) {
            rewardPerTokenStored();
        } else if (0xf0fa55a9 == v0) {
            setSlippage(uint256);
        } else if (0xf2fde38b == v0) {
            transferOwnership(address);
        } else if (0xf69e2046 == v0) {
            compound();
        } else {
            require(0xf9931855 == v0);
            stakedAmount(address);
        }
    }
}
