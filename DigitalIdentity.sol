// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DigitalIdentity {
    struct Identity {
        string name;
        uint256 birthDate;
        string nationality;
        bool exists;
    }

    mapping(address => Identity) public identities;

    event IdentityCreated(address indexed user, string name, uint256 birthDate, string nationality);
    event IdentityUpdated(address indexed user, string name, uint256 birthDate, string nationality);

    function createIdentity(string memory name, uint256 birthDate, string memory nationality) external {
        require(!identities[msg.sender].exists, "Identity already exists");
        identities[msg.sender] = Identity(name, birthDate, nationality, true);
        emit IdentityCreated(msg.sender, name, birthDate, nationality);
    }

    function updateIdentity(string memory name, uint256 birthDate, string memory nationality) external {
        require(identities[msg.sender].exists, "Identity does not exist");
        identities[msg.sender] = Identity(name, birthDate, nationality, true);
        emit IdentityUpdated(msg.sender, name, birthDate, nationality);
    }

    function getIdentity(address user) external view returns (string memory name, uint256 birthDate, string memory nationality) {
        Identity storage identity = identities[user];
        require(identity.exists, "Identity does not exist");
        return (identity.name, identity.birthDate, identity.nationality);
    }
}
