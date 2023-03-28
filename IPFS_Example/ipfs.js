var ethers = require("ethers");
var url =
  "https://special-red-daylight.ethereum-goerli.discover.quiknode.pro/3592b7f21a425bc0b0075204359cd73d9a651341/";
var provider = new ethers.providers.JsonRpcProvider(url);
var address = "0x7823e778e1455aA61DF945eE2406BA62a7f8083b";
var abi = [
  {
    inputs: [
      {
        internalType: "string",
        name: "x",
        type: "string",
      },
    ],
    name: "sendHash",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "getHash",
    outputs: [
      {
        internalType: "string",
        name: "",
        type: "string",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
];
var contract = new ethers.Contract(address, abi, provider);

contract.getHash().then((result) => {
  document.getElementById("btn").onclick = function () {
    location.href = "https://ipfs.io/ipfs/" + result;
  };
});
