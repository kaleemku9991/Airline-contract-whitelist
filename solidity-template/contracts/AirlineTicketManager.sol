// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.22 <0.9.0;

// parent contract
contract AirlineTicketMangerfactory {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    AirlineTicketManger[] private _airlineTicketMangers;

    //modifier
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    //creating AirlineTicketManager Instances
    function createAirlineTicketManager() public onlyOwner {
        AirlineTicketManger airlineTicketManger = new AirlineTicketManger();
        _airlineTicketMangers.push(airlineTicketManger);
    }

    //retrieves all AirlineTicketManager Instances
    function _airlineTicket_Managers()
        public
        pure
        returns (AirlineTicketManger[] memory coll)
    {
        return coll;
    }
}

//child contract
contract AirlineTicketManger {
    // uint256 Economy_price = 5000000000000000 wei; //0.005 ether
    // uint256 Business_price = 7000000000000000 wei; //0.007ether
    // uint256 First_class_price = 10000000000000000 wei; //0.01ether
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Task number 1
    struct User {
        // Declaring differentstructure elements
        string name;
        string destination;
        address passportID;
        uint256 airlineClass;
    }

    // Creating a mapping
    mapping(address => User) public info;

    // userinfo
    function userInfo(
        address _passportID,
        string memory _name,
        string memory _destination,
        uint256 _airlineClas
    ) public {
        require(msg.sender == owner, "You are not the owner!");
        info[_passportID] = User(
            _name,
            _destination,
            _passportID,
            _airlineClas
        );
    }

    // Task number 2

    // Creating an enumerator
    enum airline_class {
        first_class,
        business,
        economy
    }

    // Declaring variables of  type enumerator
    airline_class class;

    airline_class choice;

    // Setting a default value
    airline_class constant default_value = airline_class.economy;

    // set values
    function setValues(uint256 _value) public {
        require(uint256(airline_class.economy) >= _value);
        choice = airline_class(_value);
    }

    // get values
    function getValue() public view returns (uint256) {
        return uint256(choice);
    }

    // Defining function to return default value
    function getdefaultclass() public pure returns (airline_class) {
        return default_value;
    }

    uint256 _choiceSelect = getValue();

    //  add new struct to previous info
    //  function addinfoStruct(address _passportID)  public{

    //     info[_passportID].push(User.airlineClass)
    //   }

    // task number 3 and 4

    // for contract transfer and recieve ethers
    fallback() external payable {}

    receive() external payable {
        // custom function code
    }

    //modifier
    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // booking successfull
    function ticketBook() public payable onlyOwner returns (string memory) {
        if (_choiceSelect == 0) {
            msg.value == 10000000000000000 wei; //0.01ether first class
            payable(address(this)).transfer(msg.value);
        }
        if (_choiceSelect == 1) {
            msg.value == 7000000000000000 wei; //0.01ether business class
            payable(address(this)).transfer(msg.value);
        }
        if (_choiceSelect == 2) {
            msg.value == 5000000000000000 wei; //0.01ether economy class
            payable(address(this)).transfer(msg.value);
        }
        return "ticket booked successfully";
    }

    // task number 5
    //list address add and remove
    mapping(address => bool) whitelist;
    event AddedToWhitelist(address indexed account);
    event RemovedFromWhitelist(address indexed account);

    modifier onlyWhitelisted() {
        require(isWhitelisted(msg.sender));
        _;
    }

    function add(address _address) public onlyOwner {
        whitelist[_address] = true;
        emit AddedToWhitelist(_address);
    }

    function remove(address _address) public onlyOwner {
        whitelist[_address] = false;
        emit RemovedFromWhitelist(_address);
    }

    function isWhitelisted(address _address) public view returns (bool) {
        return whitelist[_address];
    }
}
