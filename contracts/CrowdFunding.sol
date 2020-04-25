pragma solidity ^0.5.16;
contract CrowdFunding {
  OwningEntity[] private owners;
  Project[] private projects;
  Transaction[] private transactions;

  struct OwningEntity {
    bytes32 name;
    bytes32 phoneNumber;
    bytes32[] projectNames;
  }

  struct Round {
    bytes32 projectName;
    uint startDate;
    uint endDate;
    uint targetAmount;
    uint collectedAmount;
  }

  struct Project {
    bytes32 projectName;
    bytes32 projectDescription;
    bytes32 projectLink;
    uint currentRound;
    uint startDate;
    Round[] rounds;
  }

  struct Transaction {
    uint amount;
    bytes32 projectName;
    uint round;
  }

//Get all projects owned by a single org/entity
function getAllProjectsForAOwningEntity(bytes32 _ownerName) public view returns(bytes32[] memory) {
  uint length = owners.length;
  uint i = length-1;
  while (i >= 0) {
    if (owners[i].name == _ownerName) {
      return owners[i].projectNames;
    }
    i--;
  }
}

//Total funds raised over a period through various rounds
function getAllFundingsOverAPeriod(bytes32 _projectName, uint _startDate, uint _endDate) public view returns(uint fund) {
  uint i = transactions.length-1;
  while (i >= 0) {
    if (transactions[i].projectName == _projectName) {
      fund += transactions[i].amount;
    }
    i--;
  }
  return fund;
}

//Total funds raised in each round
function getTotalFundingRoundWise(bytes32 _projectName) public view returns(uint[] memory, uint[] memory) {
  uint size = projects.length;
  uint i = size-1;
  while (i >= 0) {
    if (projects[i].projectName == _projectName) {
      break;
    }
    i--;
  }
  size = projects[i].rounds.length;
  uint[] memory rounds = new uint[](size);
  uint[] memory funds = new uint[](size);
  uint j = size-1;
  while (j >= 0) {
    funds[i] = projects[i].rounds[j].collectedAmount;
    rounds[i] = j;
    j--;
  }
  return(rounds, funds);
}

//Total funds raised so far in this round
function getTotalFundingCurrentRound(bytes32 _projectName) public view returns(uint fund) {
  uint size = projects.length;
  uint i = size-1;
  while (i >= 0) {
    if (projects[i].projectName == _projectName) {
      break;
    }
    i--;
  }
  size = projects[i].rounds.length;
  uint j = size-1;
  while (j >= 0) {
    if(projects[j].projectName == _projectName) {
      return projects[j].rounds[projects[j].rounds.length - 1].collectedAmount;
    }
    j--;
  }
  return 0;
}

//Total funds raised since the beginning
function getTotalFundingReceived(bytes32 _projectName) public view returns(uint fund) {
  uint size = projects.length;
  uint i = size-1;
  while (i >= 0) {
    if(projects[i].projectName == _projectName) {
      uint roundLength = projects[i].rounds.length;
      uint j = roundLength - 1;
      while (j >= 0) {
        fund += projects[i].rounds[j].collectedAmount;
      }
      return fund;
    }
    i--;
  }
  return 0;
}

//Total funds requested for the current round
function getTargetAmount(bytes32 _projectName, uint _roundNumber) public view returns(uint fund) {
  uint size = projects.length;
  uint i = size-1;
  while (i >= 0) {
    if(projects[i].projectName == _projectName) {
      return projects[i].rounds[_roundNumber].targetAmount;
    }
    i--;
  }
  return 0;
}
}
