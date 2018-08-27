pragma solidity 0.4.24;

// Import safeMath.sol library //
import "./safeMath.sol";

contract Election {
    /* Store multiple candidates, and store multiple attributes about each candidate 
        and multiple attributes about each candidate.  */
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Store accounts that have voted //
    mapping(address => bool) public voters;
    
    // Store Candidates that have been added via the addCandidate function and assigns an ID //
    mapping(uint => Candidate) public candidates;
    
    // Store the number of candidates in the election //
    uint public candidatesCount;

    // Generates public event on the blockchain that will notify web3.js to listen for smart contract events // 
    event votedEvent (
        uint indexed _candidateId
    );


    /* Constructor function that gets deployed when the Election contract is called.
        Uses the addCandidate function to add new candidates */
    constructor() public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }


    /* Function that allows the owner of the contract to add Candidates to the election
        Adds to the candidate count and creates a candidate mapping */
    function addCandidate (string _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }


    /*  Function that allows users to vote in the election and increases the candidate's
        vote count by reading the Candidate struct out of the "candidates" mapping and increases the over all vote count */
    
        function vote (uint _candidateId) public {
        // require address hasn't voted before //
        require(!voters[msg.sender]);

        // require candidates are valid //
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record's address has voted //
        voters[msg.sender] = true;

        // update candidate vote count //
        candidates[_candidateId].voteCount ++;

        /* trigger voted event whenever a vote is cast and updates client-side application when an account has voted. */
        emit votedEvent(_candidateId);
    }
}
