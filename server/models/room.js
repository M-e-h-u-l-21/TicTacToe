const mongoose = require('mongoose');
const playerSchema = require('./player');
 
const roomSchema = new mongoose.Schema(
    {
        occupancy:{
            type:Number,
            default:2
        },
        maxRounds:{
            type:Number,
            default:6,
        },
        currentRound:{
            type:Number,
            required:true,
            default:1,
        },
        players:[playerSchema],
        isJoined:{
            type:Boolean,
            default:true,
        },
        turn:playerSchema,
        turnIndex:{ //  keeping track of user's turn using index
            type:Number,
            default:0,
        }
    }
);

const gameModel = mongoose.model('Room',roomSchema);
module.exports = gameModel;


