contract CrowdFunding {

  Owner[] public owners;
  Project[] public projects;
  Transaction[] public transactions;

  struct Owner {
    bytes32 firstName,
    bytes32 phoneNumber,
    bytes32[] projectNames
  }

  struct Round {
    bytes32 projectName,
    uint256 startDate,
    uint256 endDate,
    uint256 targetAmount,
    uint256 collectedAmount
  }

  struct Project {
    bytes32 projectName,
    bytes32 projectDescription,
    bytes32 projectLink,
    uint currentRound,
    uint256 startDate,
    Round[] rounds
  }

  struct Transaction {
    uint256 amount,
    bytes32 projectName,
    uint round
  }

}
