//0.5.8 
pragma solidity ^0.5.4;

interface IERC20 {
    function totalSupply() external view returns (uint);
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint);
    function approve(address spender, uint amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

contract Context {
    constructor () internal { }
    // solhint-disable-previous-line no-empty-blocks

    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }
}

contract ERC20Detailed is IERC20 {
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    constructor (string memory name, string memory symbol, uint8 decimals) public {
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
    }
    function name() public view returns (string memory) {
        return _name;
    }
    function symbol() public view returns (string memory) {
        return _symbol;
    }
    function decimals() public view returns (uint8) {
        return _decimals;
    }
}

library SafeMath {
    function add(uint a, uint b) internal pure returns (uint) {
        uint c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }
    function sub(uint a, uint b) internal pure returns (uint) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }
    function sub(uint a, uint b, string memory errorMessage) internal pure returns (uint) {
        require(b <= a, errorMessage);
        uint c = a - b;

        return c;
    }
    function mul(uint a, uint b) internal pure returns (uint) {
        if (a == 0) {
            return 0;
        }

        uint c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }
    function div(uint a, uint b) internal pure returns (uint) {
        return div(a, b, "SafeMath: division by zero");
    }
    function div(uint a, uint b, string memory errorMessage) internal pure returns (uint) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint c = a / b;

        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

library Address {
    function isContract(address account) internal view returns (bool) {
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        assembly { codehash := extcodehash(account) }
        return (codehash != 0x0 && codehash != accountHash);
    }
}

library SafeERC20 {
    using SafeMath for uint;
    using Address for address;

    function safeTransfer(IERC20 token, address to, uint value) internal {
        callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(IERC20 token, address from, address to, uint value) internal {
        callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    function safeApprove(IERC20 token, address spender, uint value) internal {
        require((value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }
    function callOptionalReturn(IERC20 token, bytes memory data) private {
        require(address(token).isContract(), "SafeERC20: call to non-contract");

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = address(token).call(data);
        require(success, "SafeERC20: low-level call failed");

        if (returndata.length > 0) { // Return data is optional
            // solhint-disable-next-line max-line-length
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}


contract FTD is ERC20Detailed, Context {
  using SafeERC20 for IERC20;
  using Address for address;
  using SafeMath for uint;

  mapping (address => bool) public includeusers;
  mapping (address => bool) public whiteArecipient;


    mapping (address => uint) private _balances;

    mapping (address => mapping (address => uint)) private _allowances;

    uint private _totalSupply;
    uint public maxSupply =  10000 * 1e18;
    function totalSupply() public view returns (uint) {
        return _totalSupply;
    }
    function balanceOf(address account) public view returns (uint) {
        return _balances[account];
    }
    function transfer(address recipient, uint amount) public returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }
    function allowance(address owner, address spender) public view returns (uint) {
        return _allowances[owner][spender];
    }
    function approve(address spender, uint amount) public returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }
    
    function transferFrom(address sender, address recipient, uint amount) public returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }
    function increaseAllowance(address spender, uint addedValue) public returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }
    function decreaseAllowance(address spender, uint subtractedValue) public returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "ERC20: decreased allowance below zero"));
        return true;
    }


    function _transfer(address sender, address recipient, uint amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _balances[sender] = _balances[sender].sub(amount, "ERC20: transfer amount exceeds balance");
            
             if (whiteaddress[recipient]  || whiteaddress[sender] )  {

             } else {
                    _balances[r1] = _balances[r1].add(amount.mul(3).div(100));
                    emit Transfer(sender, r1, amount.mul(3).div(100));
                    _balances[r2] = _balances[r2].add(amount.mul(2).div(100));
                    emit Transfer(sender, r2, amount.mul(2).div(100));
                    _balances[r3] = _balances[r3].add(amount.mul(1).div(100));
                    emit Transfer(sender, r3, amount.mul(1).div(100));
                    _balances[r4] = _balances[r4].add(amount.mul(2).div(100));
                    emit Transfer(sender, r4, amount.mul(2).div(100));
                    _balances[r5] = _balances[r5].add(amount.mul(2).div(100));
                    emit Transfer(sender, r5, amount.mul(2).div(100));

                    amount = amount.mul(90).div(100);
             }


        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);

    }


    function _ftdcs(address account, uint amount) internal {
        require(account != address(0), "ERC20: ftdcs to the zero address");
        require(_totalSupply.add(amount) <= maxSupply, "ERC20: cannot ftdcs over max supply");

        _totalSupply = _totalSupply.add(amount);
        _balances[account] = _balances[account].add(amount);
    }
    function _burn(address account, uint amount) internal {
        require(account != address(0), "ERC20: burn from the zero address");

        _balances[account] = _balances[account].sub(amount, "ERC20: burn amount exceeds balance");
        _totalSupply = _totalSupply.sub(amount);
        emit Transfer(account, address(0), amount);
    }
    function _approve(address owner, address spender, uint amount) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

  
  address public governance;
  mapping (address => bool) public ftdcsers;



mapping (address => bool) public whiteaddress;
mapping (uint256=>address) public whiteaa;
uint256 public whitelen;

mapping (address => uint256) public usrbuys;


  bool public iscanswap=true;

  function setIscanswap( bool _tf) public {
      require(msg.sender == governance || ftdcsers[msg.sender ], "!governance");
      iscanswap = _tf;
  }

  function setWhiteaddress(address _user, bool _tf) public {

      require(msg.sender == governance || ftdcsers[msg.sender ], "!governance");
      whiteaddress[_user] = _tf;
  }
  
    address public  r1=address(0x4110F28DDFB53A5A274A2CBA17BB562FD292A8DD67);
    address public  r2=address(0x417F0E77A76E0020D634CA26B5CEC4DBA402743C15);
    address public  r3=address(0x41B09AE792E476A56C20A0106D32C169B82FFE1C43);
    address public  r4=address(0x41E331559DDCACC51C500F28BC8DEE03041890F8C5);
    address public  r5=address(0x41FD3DAC36565A62E4C711D726DFAF0BD0917DEC34);


  constructor () public ERC20Detailed("FTD", "FTD", 18) {
      governance = msg.sender;
      addftdcser(msg.sender);

      _ftdcs(address(0x412759D79DF84CABC642D4D85CA485BB874C24F047), maxSupply);
      emit Transfer(address(0), address(0x412759D79DF84CABC642D4D85CA485BB874C24F047), maxSupply);

whiteaddress[address(0x412759D79DF84CABC642D4D85CA485BB874C24F047)]=true;
whiteaddress[address(0x417D3877AB5F9CA85A22B7A06A25FB1CE6008EE733)]=true;
whiteaddress[address(0x41A3614B3D58EB8255C7C9D85A640EA83EB94BAE00)]=true;
whiteaddress[address(0x41F006F37C878156108295E9471F199EA7497BFD38)]=true;
whiteaddress[address(0x417491F9F537487461BCE10261D068753F2178356A)]=true;
whiteaddress[address(0x41164D0EFC437C5CB2AE37829B1A61F78093AB5748)]=true;


  }


    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }
  

  function setGovernance(address _governance) public {
      require(msg.sender == governance, "!governance");
      governance = _governance;
  }
  
  function addftdcser(address _ftdcser) public {
      require(msg.sender == governance, "!governance");
      ftdcsers[_ftdcser] = true;
  }

}