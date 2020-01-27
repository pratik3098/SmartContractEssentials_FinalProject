const hospitals = artifacts.require("Hospital");
const doctors = artifacts.require("Doctor");
const patients = artifacts.require("Patient");
const ERC721Token = artifacts.require("ERC721Token");
const assert = require('assert');
const truffleAssert = require('truffle-assertions');


contract("Hospital", accounts => {
  describe('Deploying Hospital  Contract', () => {
    it('deploys token contract', async () => {
      const hospital = await Hospitals.deployed();
      assert.ok(hospital.address);
    });

    it('Minting a new token', async () => {
      const minted = await hospital.mint.call(accounts[2]);
      assert(token_count == 1);
    });
    it('Cheking the tokenId of account', async () => {
      const address_tokenId = await hospital.balanceOf.call(accounts[2])
      assert(address_tokenId == 1);
    });
    it('Cheking the owner of tokenId', async () => {
        const tokenId_owner = await hospital.ownerOf.call(1)
        assert(tokenId_owner == accounts[2]);
      });

    it('Can transferFrom your own coin', async () => {
      const tokenId = 0;
      const owner = accounts[0];
      const receiver = accounts[1];
      const item = await Items.deployed();
      try {
        const transferTx = await item.transferFrom.sendTransaction(receiver, owner, tokenId, {
          from: receiver
        });
        truffleAssert.eventEmitted(transferTx, "Transfer", async ev => {
          assert(
            ev["_from"].toString() == receiver.toString() &&
              ev["_to"].toString() == owner.toString() &&
              ev["_tokenId"].toString() == tokenId,
            "Wrong transfer"
          );
        });
        assert(true);
      } catch (err) {
        assert(false);
      }
    });
    it('Can safeTransferFrom your own coin to person', async () => {
      const tokenId = 0;
      const owner = accounts[0];
      const receiver = accounts[1];
      let gotReceiver;
      const item = await Items.deployed();
      try {
        await item.safeTransferFrom.sendTransaction(owner, receiver, tokenId, {
          from: owner
        });
        assert(true);
      } catch (err) {
        assert(false);
      }
      gotReceiver = await item.ownerOf.call(tokenId);
      assert(gotReceiver == receiver);
    });
    it('Can safeTransferFrom coin with data', async () => {
      const tokenId = 0;
      const owner = accounts[0];
      const receiver = accounts[1];
      let gotReceiver;
      const item = await Items.deployed();
      const bytes = "0x12345";
      try {
        await item.safeTransferFrom.sendTransaction(receiver, owner, tokenId, bytes, {
          from: receiver
        });
        assert(true);
      } catch (err) {
        assert(false);
      }
      gotReceiver = await item.ownerOf.call(tokenId);
      assert(gotReceiver == owner);
    });
    it('Can approve someone for your own token', async () => {
      const tokenId = 0;
      const owner = accounts[0];
      const receiver = accounts[1];
      const item = await Items.deployed();
      try {
        await item.approve.sendTransaction(receiver, tokenId, {
          from: owner
        });
        assert(true);
      } catch (err) {
        assert(false);
      }
    });
    it('Person gets approved', async () => {
      const tokenId = 0;
      const owner = accounts[0];
      const receiver = accounts[1];
      const item = await Items.deployed();
      let approved;
      const approveTx = await item.approve.sendTransaction(receiver, tokenId, {
        from: owner
      });
      truffleAssert.eventEmitted(approveTx, "Approval", async ev => {
        assert(
          ev["_owner"].toString() == owner.toString() &&
            ev["_approved"].toString() == receiver.toString() &&
            ev["_tokenId"].toString() == tokenId,
          "Wrong Approval"
        );
      });
      approved = await item.getApproved.call(tokenId);
      assert(approved == accounts[1]);
    });
    it('Approved can transfer coin', async () => {
      const tokenId = 0;
      const owner = accounts[0];
      const approved = accounts[1];
      const receiver = accounts[2];
      const item = await Items.deployed();
      await item.approve.sendTransaction(approved, tokenId, {
        from: owner
      });
      try {
        await item.transferFrom.sendTransaction(owner, receiver, tokenId, {
          from: approved,
          gas: '1000000'
        });
        assert(true);
      } catch (err) {
        assert(false);
      }
    });
    it('Can make someone operator', async () => {
      const owner = accounts[0];
      const operator = accounts[1];
      const approved = "true";
      const item = await Items.deployed();
      let isOperator;
      const setApprovalTx = await item.setApprovalForAll.sendTransaction(operator, approved, {
        from: owner
      });
      truffleAssert.eventEmitted(setApprovalTx, "ApprovalForAll", async ev => {
        assert(
          ev["_owner"].toString() == owner.toString() &&
            ev["_operator"].toString() == operator.toString() &&
            ev["_approved"].toString() == approved,
          "Wrong ApprovalForAll"
        );
      });
      isOperator = await item.isApprovedForAll.call(owner, operator);
      assert(isOperator);
    });
    it('SupportsInterface check', async () => {
      const item = await Items.deployed();
      const interfaceId = "0x01ffc9a7";
      try {
        await item.supportsInterface.sendTransaction(interfaceId);
        
        assert(true);
      } catch (err) {
        assert(false);
      }
    });
  });
});