pragma experimental ABIEncoderV2;

import "./IERC721.sol";import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC721/IERC721.sol";
import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC721/IERC721Receiver.sol";
import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/utils/Address.sol";
import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/drafts/Counters.sol";
import "github.com/OpenZeppelin/openzeppelin-solidity/contracts/introspection/ERC165.sol";

contract SolidityTest {   
    
    uint256 gameplan;
    address constant public player_1 = 0xE0f5206BBD039e7b0592d8918820024e2a7437b9;
    address constant public player_2 = 0x8019b2DAaa9631353e2c0c26e747eDcE4A7a0e24;
    attributes defender;
    attributes attacker;
    attributes midfielder;
    matchResult overallMatchResult;
    PlayerAction[] actions;
    uint256 GK = 0;
    uint256 DF = 1;
    uint256 MD = 2;
    uint256 ST = 3;
    
    mapping(uint256 => attributes) public player_1_players;
    mapping(uint256 => attributes) public player_2_players;
    
    
   constructor() public{
       gameplan = getBooleanRepresentation();
       defender = attributes(1,20,20,20,20,20);
       midfielder = attributes(2,20,20,20,20,20);
       attacker = attributes(3,20,20,20,20,20);
       player_1_players[0] = defender;
       player_1_players[1] = midfielder;
       player_1_players[2] = attacker;
       player_2_players[0] = defender;
       player_2_players[1] = midfielder;
       player_2_players[2] = attacker;
       overallMatchResult = matchResult(0,0);
   }
   
   enum PlayerState {
        PassForward,
        PassAcross,
        PassBack,
        Hold,
        Pressured,
        ThroughBall,
        Shoot,
        Cross,
        LoseBall,
        Save,
        Kickoff,
        DivingHeader,
        BicycleKick,
        PeleFlick
    }
    
    struct PlayerAction {
        uint256 tokenId;
        PlayerState state;
        uint256 confidence;
    }
    
    struct matchResult {
        uint256 player_1_goals;
        uint256 player_2_goals;
    }
    
    function playMatch() public returns (matchResult memory) {
        
        PlayerAction memory currentAction;
        uint i = 0;
        
        while(i < 10) {
            
            if(i==0) {
                PlayerAction memory kickoffAction = PlayerAction(1, PlayerState.Kickoff, 100);
                actions.push(kickoffAction);
                i++;
                PlayerAction memory defenderHold = PlayerAction(0, PlayerState.Hold, 100);
                actions.push(defenderHold);
                
                currentAction = defenderHold;
            } else {
            
                if(player_1_players[currentAction.tokenId].position == DF) {
                    currentAction = defenderPlay(player_1_players[currentAction.tokenId], player_2_players[2]);
                }
                
                if(player_1_players[currentAction.tokenId].position == MD) {
                    
                }
            }
            i++;
        }
        return overallMatchResult;
    }
    
    function getSummary() public view returns (PlayerAction[] memory) {
        return actions;
    }
   
   function getGameplan() public view returns (uint256) {
       return gameplan;
   }
   
  function kickoff() public view returns (bool) {
      uint isPlayer1Kickoff = addmod(uint256(player_1), gameplan, 2);
      return isPlayer1Kickoff == 0;
  }
  
  function defenderPlay(attributes memory defenderInPlay, attributes memory attackerInPlay) public view returns (PlayerAction memory) {
      //Calculate acceptable state
      return PlayerAction(1, PlayerState.Hold, 20);
  }
  
  function goalkeeper() public view returns (bool) {
      uint isPlayer1Kickoff = addmod(uint256(player_1), gameplan, 2);
      return isPlayer1Kickoff == 0;
  }
  
  struct attributes {
        uint256 position; 
        uint256 strength;
        uint256 speed;
        uint256 intelligence;
        uint256 skill;
        uint256 special;
    }
  
   
   function getBooleanRepresentation() private view returns (uint256) {
       return uint256(keccak256(abi.encode(block.timestamp, block.difficulty)));
   }
   
//   function integerToString(uint _i) internal pure 
//       returns (string memory) {
      
//       if (_i == 0) {
//          return "0";
//       }
//       uint j = _i;
//       uint len;
      
//       while (j != 0) {
//          len++;
//          j /= 10;
//       }
//       bytes memory bstr = new bytes(len);
//       uint k = len - 1;
      
//       while (_i != 0) {
//          bstr[k--] = byte(uint8(48 + _i % 10));
//          _i /= 10;
//       }
//       return string(bstr);
//   }
   
   
}
