abstract contract Initializable {
    struct InitializableStorage {
        uint64 _initialized;
        bool _initializing;
    }
    bytes32 private constant INITIALIZABLE_STORAGE = 0xf0c57e16840df040f15088dc2f81fe391c3923bec73e23a9662efc9c229c6a00;
    error InvalidInitialization();
    error NotInitializing();
    event Initialized(uint64 version);
    modifier initializer() {
        InitializableStorage storage $ = _getInitializableStorage();
        bool isTopLevelCall = !$._initializing;
        uint64 initialized = $._initialized;
        bool initialSetup = initialized == 0 && isTopLevelCall;
        bool construction = initialized == 1 && address(this).code.length == 0;
        if (!initialSetup && !construction) {
            revert InvalidInitialization();
        }
        $._initialized = 1;
        if (isTopLevelCall) {
            $._initializing = true;
        }
        _;
        if (isTopLevelCall) {
            $._initializing = false;
            emit Initialized(1);
        }
    }
    modifier reinitializer(uint64 version) {
        InitializableStorage storage $ = _getInitializableStorage();
        if ($._initializing || $._initialized >= version) {
            revert InvalidInitialization();
        }
        $._initialized = version;
        $._initializing = true;
        _;
        $._initializing = false;
        emit Initialized(version);
    }
    modifier onlyInitializing() {
        _checkInitializing();
        _;
    }
    function _checkInitializing() internal view virtual {
        if (!_isInitializing()) {
            revert NotInitializing();
        }
    }
    function _disableInitializers() internal virtual {
        InitializableStorage storage $ = _getInitializableStorage();
        if ($._initializing) {
            revert InvalidInitialization();
        }
        if ($._initialized != type(uint64).max) {
            $._initialized = type(uint64).max;
            emit Initialized(type(uint64).max);
        }
    }
    function _getInitializedVersion() internal view returns (uint64) {
        return _getInitializableStorage()._initialized;
    }
    function _isInitializing() internal view returns (bool) {
        return _getInitializableStorage()._initializing;
    }
    function _getInitializableStorage() private pure returns (InitializableStorage storage $) {
        assembly {
            $.slot := INITIALIZABLE_STORAGE
        }
    }
}
abstract contract ContextUpgradeable is Initializable {
    function __Context_init() internal onlyInitializing {
    }
    function __Context_init_unchained() internal onlyInitializing {
    }
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
    function _contextSuffixLength() internal view virtual returns (uint256) {
        return 0;
    }
}
interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 value) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}
interface IERC20Metadata is IERC20 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
}
interface IERC20Errors {
    error ERC20InsufficientBalance(address sender, uint256 balance, uint256 needed);
    error ERC20InvalidSender(address sender);
    error ERC20InvalidReceiver(address receiver);
    error ERC20InsufficientAllowance(address spender, uint256 allowance, uint256 needed);
    error ERC20InvalidApprover(address approver);
    error ERC20InvalidSpender(address spender);
}
interface IERC721Errors {
    error ERC721InvalidOwner(address owner);
    error ERC721NonexistentToken(uint256 tokenId);
    error ERC721IncorrectOwner(address sender, uint256 tokenId, address owner);
    error ERC721InvalidSender(address sender);
    error ERC721InvalidReceiver(address receiver);
    error ERC721InsufficientApproval(address operator, uint256 tokenId);
    error ERC721InvalidApprover(address approver);
    error ERC721InvalidOperator(address operator);
}
interface IERC1155Errors {
    error ERC1155InsufficientBalance(address sender, uint256 balance, uint256 needed, uint256 tokenId);
    error ERC1155InvalidSender(address sender);
    error ERC1155InvalidReceiver(address receiver);
    error ERC1155MissingApprovalForAll(address operator, address owner);
    error ERC1155InvalidApprover(address approver);
    error ERC1155InvalidOperator(address operator);
    error ERC1155InvalidArrayLength(uint256 idsLength, uint256 valuesLength);
}
abstract contract ERC20Upgradeable is Initializable, ContextUpgradeable, IERC20, IERC20Metadata, IERC20Errors {
    struct ERC20Storage {
        mapping(address account => uint256) _balances;
        mapping(address account => mapping(address spender => uint256)) _allowances;
        uint256 _totalSupply;
        string _name;
        string _symbol;
    }
    bytes32 private constant ERC20StorageLocation = 0x52c63247e1f47db19d5ce0460030c497f067ca4cebf71ba98eeadabe20bace00;
    function _getERC20Storage() private pure returns (ERC20Storage storage $) {
        assembly {
            $.slot := ERC20StorageLocation
        }
    }
    function __ERC20_init(string memory name_, string memory symbol_) internal onlyInitializing {
        __ERC20_init_unchained(name_, symbol_);
    }
    function __ERC20_init_unchained(string memory name_, string memory symbol_) internal onlyInitializing {
        ERC20Storage storage $ = _getERC20Storage();
        $._name = name_;
        $._symbol = symbol_;
    }
    function name() public view virtual returns (string memory) {
        ERC20Storage storage $ = _getERC20Storage();
        return $._name;
    }
    function symbol() public view virtual returns (string memory) {
        ERC20Storage storage $ = _getERC20Storage();
        return $._symbol;
    }
    function decimals() public view virtual returns (uint8) {
        return 18;
    }
    function totalSupply() public view virtual returns (uint256) {
        ERC20Storage storage $ = _getERC20Storage();
        return $._totalSupply;
    }
    function balanceOf(address account) public view virtual returns (uint256) {
        ERC20Storage storage $ = _getERC20Storage();
        return $._balances[account];
    }
    function transfer(address to, uint256 value) public virtual returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, value);
        return true;
    }
    function allowance(address owner, address spender) public view virtual returns (uint256) {
        ERC20Storage storage $ = _getERC20Storage();
        return $._allowances[owner][spender];
    }
    function approve(address spender, uint256 value) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, value);
        return true;
    }
    function transferFrom(address from, address to, uint256 value) public virtual returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, value);
        _transfer(from, to, value);
        return true;
    }
    function _transfer(address from, address to, uint256 value) internal {
        if (from == address(0)) {
            revert ERC20InvalidSender(address(0));
        }
        if (to == address(0)) {
            revert ERC20InvalidReceiver(address(0));
        }
        _update(from, to, value);
    }
    function _update(address from, address to, uint256 value) internal virtual {
        ERC20Storage storage $ = _getERC20Storage();
        if (from == address(0)) {
            $._totalSupply += value;
        } else {
            uint256 fromBalance = $._balances[from];
            if (fromBalance < value) {
                revert ERC20InsufficientBalance(from, fromBalance, value);
            }
            unchecked {
                $._balances[from] = fromBalance - value;
            }
        }
        if (to == address(0)) {
            unchecked {
                $._totalSupply -= value;
            }
        } else {
            unchecked {
                $._balances[to] += value;
            }
        }
        emit Transfer(from, to, value);
    }
    function _mint(address account, uint256 value) internal {
        if (account == address(0)) {
            revert ERC20InvalidReceiver(address(0));
        }
        _update(address(0), account, value);
    }
    function _burn(address account, uint256 value) internal {
        if (account == address(0)) {
            revert ERC20InvalidSender(address(0));
        }
        _update(account, address(0), value);
    }
    function _approve(address owner, address spender, uint256 value) internal {
        _approve(owner, spender, value, true);
    }
    function _approve(address owner, address spender, uint256 value, bool emitEvent) internal virtual {
        ERC20Storage storage $ = _getERC20Storage();
        if (owner == address(0)) {
            revert ERC20InvalidApprover(address(0));
        }
        if (spender == address(0)) {
            revert ERC20InvalidSpender(address(0));
        }
        $._allowances[owner][spender] = value;
        if (emitEvent) {
            emit Approval(owner, spender, value);
        }
    }
    function _spendAllowance(address owner, address spender, uint256 value) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            if (currentAllowance < value) {
                revert ERC20InsufficientAllowance(spender, currentAllowance, value);
            }
            unchecked {
                _approve(owner, spender, currentAllowance - value, false);
            }
        }
    }
}
abstract contract ReentrancyGuardUpgradeable is Initializable {
    uint256 private constant NOT_ENTERED = 1;
    uint256 private constant ENTERED = 2;
    struct ReentrancyGuardStorage {
        uint256 _status;
    }
    bytes32 private constant ReentrancyGuardStorageLocation = 0x9b779b17422d0df92223018b32b4d1fa46e071723d6817e2486d003becc55f00;
    function _getReentrancyGuardStorage() private pure returns (ReentrancyGuardStorage storage $) {
        assembly {
            $.slot := ReentrancyGuardStorageLocation
        }
    }
    error ReentrancyGuardReentrantCall();
    function __ReentrancyGuard_init() internal onlyInitializing {
        __ReentrancyGuard_init_unchained();
    }
    function __ReentrancyGuard_init_unchained() internal onlyInitializing {
        ReentrancyGuardStorage storage $ = _getReentrancyGuardStorage();
        $._status = NOT_ENTERED;
    }
    modifier nonReentrant() {
        _nonReentrantBefore();
        _;
        _nonReentrantAfter();
    }
    function _nonReentrantBefore() private {
        ReentrancyGuardStorage storage $ = _getReentrancyGuardStorage();
        if ($._status == ENTERED) {
            revert ReentrancyGuardReentrantCall();
        }
        $._status = ENTERED;
    }
    function _nonReentrantAfter() private {
        ReentrancyGuardStorage storage $ = _getReentrancyGuardStorage();
        $._status = NOT_ENTERED;
    }
    function _reentrancyGuardEntered() internal view returns (bool) {
        ReentrancyGuardStorage storage $ = _getReentrancyGuardStorage();
        return $._status == ENTERED;
    }
}
interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}
struct SlotBaseInfo {
    address issuer;
    address currency;
    uint64 valueDate;
    uint64 maturity;
    uint64 createTime;
    bool transferable;
    bool isValid;
}
interface IOpenFundSftDelegate {
    function concrete() external view returns (address);
}
interface IOpenFundSftConcrete {
    function slotBaseInfo(uint256 slot) external view returns (SlotBaseInfo memory);
}
contract BitcoinReserveOffering is ISftWrappedToken, ERC20Upgradeable, ReentrancyGuardUpgradeable {
    address public wrappedSftAddress;
    uint256 public wrappedSftSlot;
    uint256 public holdingValueSftId;
    uint256[] internal _holdingEmptySftIds;
    address public solvBTCAddress;
    uint256 public exchangeRate;
    modifier onlyWrappedSft() {
        require(msg.sender == wrappedSftAddress, "SftWrappedToken: only wrapped sft");
        _;
    }
    constructor() {
        _disableInitializers();
    }
    function initialize(
        string memory name_,
        string memory symbol_,
        address wrappedSftAddress_,
        uint256 wrappedSftSlot_,
        uint256 exchangeRate_,
        address solvBTCAddress_
    ) external virtual initializer {
        require(wrappedSftAddress_ != address(0), "SftWrappedToken: invalid sft address");
        require(wrappedSftSlot_ != 0, "SftWrappedToken: invalid sft slot");
        require(exchangeRate_ != 0, "SftWrappedToken: invalid exchange rate");
        require(solvBTCAddress_ != address(0), "SftWrappedToken: invalid solv btc address");
        ERC20Upgradeable.__ERC20_init(name_, symbol_);
        ReentrancyGuardUpgradeable.__ReentrancyGuard_init();
        wrappedSftAddress = wrappedSftAddress_;
        wrappedSftSlot = wrappedSftSlot_;
        exchangeRate = exchangeRate_;
        solvBTCAddress = solvBTCAddress_;
    }
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return 
            interfaceId == type(IERC3525Receiver).interfaceId || 
            interfaceId == type(IERC721Receiver).interfaceId || 
            interfaceId == type(IERC165).interfaceId;
    }
    function decimals() public view virtual override returns (uint8) {
        return IERC3525(wrappedSftAddress).valueDecimals();
    }
    function onERC3525Received(
        address, 
        uint256 fromSftId_,
        uint256 sftId_,
        uint256 sftValue_,
        bytes calldata 
    ) external virtual override onlyWrappedSft returns (bytes4) {
        address fromSftOwner = IERC3525(wrappedSftAddress).ownerOf(fromSftId_);
        if (fromSftOwner == address(this)) {
            return IERC3525Receiver.onERC3525Received.selector;
        }
        require(sftValue_ > 0, "SftWrappedToken: mint zero not allowed");
        if (holdingValueSftId == 0) {
            require(wrappedSftSlot == IERC3525(wrappedSftAddress).slotOf(sftId_), "SftWrappedToken: unreceivable slot");
            require(address(this) == IERC3525(wrappedSftAddress).ownerOf(sftId_), "SftWrappedToken: not owned sft id");
            holdingValueSftId = sftId_;
        } else {
            require(holdingValueSftId == sftId_, "SftWrappedToken: not holding value sft id");
        }
        uint256 value = sftValue_ * exchangeRate / (10 ** decimals());
        _mint(fromSftOwner, value);
        return IERC3525Receiver.onERC3525Received.selector;
    }
    function onERC721Received(address,  address from_, uint256 sftId_, bytes calldata  )
        external
        virtual
        override
        onlyWrappedSft
        returns (bytes4)
    {
        require(wrappedSftSlot == IERC3525(wrappedSftAddress).slotOf(sftId_), "SftWrappedToken: unreceivable slot");
        require(address(this) == IERC3525(wrappedSftAddress).ownerOf(sftId_), "SftWrappedToken: not owned sft id");
        if (from_ == address(this)) {
            return IERC721Receiver.onERC721Received.selector;
        }
        uint256 sftValue = IERC3525(wrappedSftAddress).balanceOf(sftId_);
        require(sftValue > 0, "SftWrappedToken: mint zero not allowed");
        if (holdingValueSftId == 0) {
            holdingValueSftId = sftId_;
        } else {
            ERC3525TransferHelper.doTransfer(wrappedSftAddress, sftId_, holdingValueSftId, sftValue);
            _holdingEmptySftIds.push(sftId_);
        }
        uint256 value = sftValue * exchangeRate / (10 ** decimals());
        _mint(from_, value);
        return IERC721Receiver.onERC721Received.selector;
    }
    function mint(uint256 sftId_, uint256 amount_) external virtual override nonReentrant {
        require(wrappedSftSlot == IERC3525(wrappedSftAddress).slotOf(sftId_), "SftWrappedToken: slot does not match");
        require(msg.sender == IERC3525(wrappedSftAddress).ownerOf(sftId_), "SftWrappedToken: caller is not sft owner");
        require(amount_ > 0, "SftWrappedToken: mint amount cannot be 0");
        uint256 sftBalance = IERC3525(wrappedSftAddress).balanceOf(sftId_);
        if (amount_ == sftBalance) {
            ERC3525TransferHelper.doSafeTransferIn(wrappedSftAddress, msg.sender, sftId_);
        } else if (amount_ < sftBalance) {
            if (holdingValueSftId == 0) {
                holdingValueSftId = ERC3525TransferHelper.doTransferIn(wrappedSftAddress, sftId_, amount_);
            } else {
                ERC3525TransferHelper.doTransfer(wrappedSftAddress, sftId_, holdingValueSftId, amount_);
            }
        } else {
            revert("SftWrappedToken: mint amount exceeds sft balance");
        }
        uint256 value = amount_ * exchangeRate / (10 ** decimals());
        _mint(msg.sender, value);
    }
    function burn(uint256 amount_, uint256 sftId_) external virtual override nonReentrant returns (uint256 toSftId_) {
        require(amount_ > 0, "SftWrappedToken: burn amount cannot be 0");
        _burn(msg.sender, amount_);
        uint256 sftValue = amount_ * (10 ** decimals()) / exchangeRate;
        if (sftId_ == 0) {
            if (_holdingEmptySftIds.length == 0) {
                toSftId_ =
                    ERC3525TransferHelper.doTransferOut(wrappedSftAddress, holdingValueSftId, msg.sender, sftValue);
            } else {
                toSftId_ = _holdingEmptySftIds[_holdingEmptySftIds.length - 1];
                _holdingEmptySftIds.pop();
                ERC3525TransferHelper.doTransfer(wrappedSftAddress, holdingValueSftId, toSftId_, sftValue);
                ERC3525TransferHelper.doTransferOut(wrappedSftAddress, msg.sender, toSftId_);
            }
        } else {
            require(
                wrappedSftSlot == IERC3525(wrappedSftAddress).slotOf(sftId_), "SftWrappedToken: slot does not match"
            );
            require(msg.sender == IERC3525(wrappedSftAddress).ownerOf(sftId_), "SftWrappedToken: not sft owner");
            ERC3525TransferHelper.doTransfer(wrappedSftAddress, holdingValueSftId, sftId_, sftValue);
            toSftId_ = sftId_;
        }
    }
    function getValueByShares(uint256 shares) external view virtual override returns (uint256 value) {
        return shares * exchangeRate / (10 ** decimals());
    }
    function getSharesByValue(uint256 value) external view virtual override returns (uint256 shares) {
        return value * (10 ** decimals()) / exchangeRate;
    }
    function underlyingAsset() external view returns (address) {
        return solvBTCAddress;
    }
}
interface IERC721Receiver {
    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) external returns (bytes4);
}
interface IERC3525Receiver {
    function onERC3525Received(address operator, uint256 fromTokenId, uint256 toTokenId, uint256 value, bytes calldata data) external returns (bytes4);
}
interface ISftWrappedToken is IERC20, IERC721Receiver, IERC3525Receiver, IERC165 {
	function mint(uint256 sftId_, uint256 amount_) external;
    function burn(uint256 amount_, uint256 sftId_) external returns (uint256 toSftId_);
    function getValueByShares(uint256 shares) external view returns (uint256 value);
    function getSharesByValue(uint256 value) external view returns (uint256 shares);
    function underlyingAsset() external view returns (address underlyingAsset);
}
interface IERC721 {
    function balanceOf(address owner) external view returns (uint256);
    function ownerOf(uint256 tokenId) external view returns (address);
    function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256);
    function getApproved(uint256 tokenId) external view returns (address);
    function isApprovedForAll(address owner, address operator) external view returns (bool);
    function approve(address approved, uint256 tokenId) external payable;
    function setApprovalForAll(address operator, bool approved) external;
    function transferFrom(address from, address to, uint256 tokenId) external payable;
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external payable;
    function safeTransferFrom(address from, address to, uint256 tokenId) external payable;
}
interface IERC3525 is IERC721 {
    function valueDecimals() external view returns (uint8);
    function balanceOf(uint256 tokenId) external view returns (uint256);
    function slotOf(uint256 tokenId) external view returns (uint256);
    function allowance(uint256 tokenId, address operator) external view returns (uint256);
    function approve(address operator, uint256 tokenId) external payable;
    function approve(uint256 tokenId, address operator, uint256 value) external payable;
    function transferFrom(uint256 fromTokenId, uint256 toTokenId, uint256 value) external payable;
    function transferFrom(uint256 fromTokenId, address to, uint256 value) external payable returns (uint256);
}
interface ERC721Interface {
    function approve(address to, uint256 tokenId) external;
    function transferFrom(address from, address to, uint256 tokenId) external;
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
}
interface ERC3525Interface {
    function approve(uint256 tokenId, address to, uint256 allowance) external payable;
    function transferFrom(uint256 fromTokenId, uint256 toTokenId, uint256 value) external payable;
    function transferFrom(uint256 fromTokenId, address to, uint256 value) external payable returns (uint256); 
}
library ERC3525TransferHelper {
    function doApproveId(address underlying, address to, uint256 tokenId) internal {
        ERC721Interface token = ERC721Interface(underlying);
        token.approve(to, tokenId);
    }
    function doApproveValue(address underlying, uint256 tokenId, address to, uint256 allowance) internal {
        ERC3525Interface token = ERC3525Interface(underlying);
        token.approve(tokenId, to, allowance);
    }
    function doTransferIn(address underlying, address from, uint256 tokenId) internal {
        ERC721Interface token = ERC721Interface(underlying);
        token.transferFrom(from, address(this), tokenId);
    }
    function doSafeTransferIn(address underlying, address from, uint256 tokenId) internal {
        ERC721Interface token = ERC721Interface(underlying);
        token.safeTransferFrom(from, address(this), tokenId);
    }
    function doSafeTransferOut(address underlying, address to, uint256 tokenId) internal {
        ERC721Interface token = ERC721Interface(underlying);
        token.safeTransferFrom(address(this), to, tokenId);
    }
    function doTransferOut(address underlying, address to, uint256 tokenId) internal {
        ERC721Interface token = ERC721Interface(underlying);
        token.transferFrom(address(this), to, tokenId);
    }
    function doTransferIn(address underlying, uint256 fromTokenId, uint256 value) internal returns (uint256 newTokenId) {
        ERC3525Interface token = ERC3525Interface(underlying);
        return token.transferFrom(fromTokenId, address(this), value);
    }
    function doTransferOut(address underlying, uint256 fromTokenId, address to, uint256 value) internal returns (uint256 newTokenId) {
        ERC3525Interface token = ERC3525Interface(underlying);
        newTokenId = token.transferFrom(fromTokenId, to, value);
    }
    function doTransfer(address underlying, address from, address to, uint256 tokenId) internal {
        ERC721Interface token = ERC721Interface(underlying);
        token.transferFrom(from, to, tokenId);
    }
    function doTransfer(address underlying, uint256 fromTokenId, uint256 toTokenId, uint256 value) internal {
        ERC3525Interface token = ERC3525Interface(underlying);
        token.transferFrom(fromTokenId, toTokenId, value);
    }
}