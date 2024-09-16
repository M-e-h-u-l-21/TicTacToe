const express = require('express');
const http = require('http');
const mongoose = require('mongoose');

const app = express();
const port = process.env.PORT || 3000;
const server = http.createServer(app);
const Room = require("./models/room");

app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  res.header("Access-Control-Allow-Methods", "GET, POST, OPTIONS, PUT, PATCH, DELETE");
  res.header("Access-Control-Allow-Credentials", true);
  next();
});

const DB = "mongodb+srv://mehul21:Mehul7869@mptictactoe.qgudg.mongodb.net/?retryWrites=true&w=majority&appName=MPTicTacToe";

const io = require('socket.io')(server);

io.on('connection', (socket) => {
  console.log("Socket connected!!");

  socket.on("createRoom",async  ({ nickname }) => {// Since its a db related stuff we will need this to be asynchronous
    // console.log("Room created by:", nickname);

    try{
            // Room is to be created
    let room = new Room();
    let player = {
        socketID:socket.id,
        nickname:nickname,
        playerType:'X',
    }

    room.players.push(player);
    room.turn = player;

    // Saving in mongodb
    room = await room.save();
    // room variable will get us some _id which will be created by mongodb and will be used by our players
    // to join in 

    const roomId = room._id;
    console.log(roomId._id);
    socket.join(roomId);
    io.to(roomId._id).emit("CreateRoomSuccess",room);
    } catch(e){
        console.log(e);
    }
  });

  socket.on("joinRoom",async ({nickname,roomId})=>{
    try{
      // Checking whether the roomID present is a valid one even or not
      if(!roomId.match(/^[0-9a-fA-F]{24}$/)) {
        socket.emit('errorOccured','Please enter a valid room ID');
        return;
      }

      let room = await Room.findById(roomId);
      console.log(room);
      if(room.isJoined){
        let player = {
          nickname,
          socketID:socket.id,
          playerType:'O',
        }
        room.isJoined = false;
        socket.join(roomId);
        room.players.push(player);
        room = await room.save();
        io.to(roomId).emit("JoinRoomSuccess",room);
        io.to(roomId).emit("updatePlayers",room.players);
        io.to(roomId).emit("updateRoom",room);
      }else{
        socket.emit('errorOccured','The game is in progress please try again later');

      }
    }catch(e){
      console.log(e);
    }
  });


  socket.on('tap',async ({index,roomId})=>{
    try{
      let room = await Room.findById(roomId);
      let choice = room['turn']['playerType']; 
      if(room['turnIndex'] == 0){
        room['turn'] = room.players[1];
        room['turnIndex'] = 1;
      }else{
        room['turn'] = room.players[0];
        room['turnIndex'] = 0;
      }
      console.log("inside server socket");
      room = await room.save();
      io.to(roomId).emit('tapped',{
        index,
        choice,
        room,
      });
    }catch(e){
      console.log(e);
    }
  });

  socket.on('winner',async ({winnerSocketId,roomId})=>{
    try{
      if(socket.id != winnerSocketId) return;
      let room = await Room.findById(roomId);
      let player = room.players.find((playerr)=> playerr.socketID == winnerSocketId); 
      player.points+=1;
      room = await room.save();

      if(player.points>=room.maxRounds){
        io.to(roomId).emit('endGame',player);
      }else{
        io.to(roomId).emit('pointIncrease',player);
      }

    }catch(e){
      console.log(e);
    }
  });

});

mongoose.connect(DB).then(() => {
  console.log("Connection Successful!!");
}).catch((e) => {
  console.log("Connection error:", e);
});

server.listen(port, '0.0.0.0', () => {
  console.log(`Server started and running on ${port}`);
});