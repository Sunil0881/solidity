//SPDX-License-Identifier:MIT
pragma solidity ^0.8.1;

contract Devfolio {


    struct Organizer {
        string name;
        string email;
        string password;
        bool authorized;
    }

    struct Participant {
        string name;
        uint256 age;
        string dob;
        string resume;
        string profession;
        string githubLink;
        string twitterLink;
        string linkedinLink;
    }

    struct hackathon {

        string  title;
        string community;
        string description;
        uint max_team_size;
        string web_url;
        uint app_open;
        uint app_close;
        uint rsvp_days;
        string tracks;
        uint track_price;
        uint no_winners_track;
        
    }

    address public organizer;
    uint256 public projectCount;
   

    enum Login { Organizer, Participant }
    Login public login;

    

    mapping(address => hackathon[]) public projects;
    mapping(address => Organizer) public organizers;
    mapping(address => Participant) public participants;
   

    constructor() {
        organizer = msg.sender;
    }

    modifier onlyOrganizer() {
        require(login == Login.Organizer, "Access denied. Organizer login required.");
        _;
    }

    modifier onlyParticipant() {
        require(login == Login.Participant, "Access denied. Participant login required.");
        _;
    }

    function organizerLogin(string memory email, string memory password) public {
        require(msg.sender == organizer, "Only the organizer can log in as an organizer.");
        require(keccak256(bytes(organizers[msg.sender].email)) == keccak256(bytes(email)), "Invalid email.");
        require(keccak256(bytes(organizers[msg.sender].password)) == keccak256(bytes(password)), "Invalid password.");
        login = Login.Organizer;
    }

    function participantLogin(string memory name, string memory dob) public {
        require(keccak256(bytes(participants[msg.sender].name)) == keccak256(bytes(name)), "Invalid name.");
        require(keccak256(bytes(participants[msg.sender].dob)) == keccak256(bytes(dob)), "Invalid date of birth.");
        login = Login.Participant;
    }

function createProject(
        string memory _title,  
        string memory _community,  
        string memory _description,  
        uint _max_team_size,   
        string memory _web_url,  
        uint _app_open, 
        uint _app_close, 
        uint _rsvp_days, 
        string memory _tracks, 
        uint _track_price, 
        uint _no_winners_track
    ) public {
        hackathon memory newProject = hackathon(_title, _community, _description, _max_team_size, _web_url, _app_open, _app_close, _rsvp_days, _tracks, _track_price, _no_winners_track);
        projects[msg.sender].push(newProject);
        projectCount++;
    }

          
    function applyForProject(
        string memory name,
        uint256 age,
        string memory dob,
        string memory resume,
        string memory profession,
        string memory githubLink,
        string memory twitterLink,
        string memory linkedinLink
    ) public {
        Participant storage participant = participants[msg.sender];
        participant.name = name;
        participant.age = age;
        participant.dob = dob;
        participant.resume = resume;
        participant.profession = profession;
        participant.githubLink = githubLink;
        participant.twitterLink = twitterLink;
        participant.linkedinLink = linkedinLink;}
         // project.participants[msg.sender] = true; 
 }


