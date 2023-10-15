// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract CrowdFunding {
    struct Campaign {
        address owner;
        string title;
        string description;
        uint256 target;
        uint256 deadLine;
        uint256 amountCollected;
        string image;
        address[] donators;
        uint256[] donations;
    }

    mapping(uint256 => Campaign) public campaigns;

    uint256 public numberOfCampaigns = 0;

    // this functions will create a new campaign
    // this will return the id of the campaign
    function createCampaign(address _owner, string memory _title, string memory _description, uint256 _target, uint256 _deadLine, string memory _image) public returns (uint256) {
        Campaign storage campaign = campaigns[numberOfCampaigns]; // in this way we will be filling up our campaigns array

        require(campaign.deadLine < block.timestamp, "The deadLine should be a date in the future");
        // If this is satisfied then only this goes forward else it will throw an error message "The deadLine should be a date in the future".

        campaign.owner = _owner;
        campaign.title = _title;
        campaign.description = _description;
        campaign.target = _target;
        campaign.deadLine = _deadLine;
        campaign.amountCollected = 0;
        campaign.image = _image;

        numberOfCampaigns++;

        return numberOfCampaigns -1; // this will be the index of the most recently created campaign.
    }

    // this function will donate to a particular campaign
    function donateToCampaign(uint256 _id) public payable {
        uint256 amount = msg.value;

        Campaign storage campaign = campaigns[_id];

        campaign.donators.push(msg.sender);
        campaign.donations.push(amount);

        // sent is a variable that will let us know where the transaction has been sent or not
        (bool sent, ) = payable(campaign.owner).call{value: amount}("");

        if (sent) {
            campaign.amountCollected = campaign.amountCollected + amount;
        }

    }

    // this function will get the donators of a particular campaign
    function getDonators(uint256 _id) view public returns (address[] memory, uint256[] memory) {
        return (campaigns[_id].donators, campaigns[_id].donations);
    }

    // to get the list of all campaigns
    function getCampaigns() view public returns (Campaign[] memory) {
        Campaign[] memory allCampaigns = new Campaign[](numberOfCampaigns); // this just creates an empty array which can be filled later.

        for (uint i = 0; i < numberOfCampaigns; ++i) {
            Campaign storage item = campaigns[i];

            allCampaigns[i] = item;
        }

        return allCampaigns;
    }
}