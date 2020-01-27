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
      const hospital = await Hospitals.deployed();
      const minted = await hospital.mint.call(accounts[2]);
      assert(token_count == 1);
    });
    it('Cheking the tokenId of account', async () => {
      const hospital = await Hospitals.deployed();
      const minted = await hospital.mint.call(accounts[2]);
      const address_tokenId = await hospital.balanceOf.call(accounts[2])
      assert(address_tokenId == 1);
    });
    it('Cheking the owner of tokenId', async () => {
        const hospital = await Hospitals.deployed();
        const minted = await hospital.mint.call(accounts[2]);
        const tokenId_owner = await hospital.ownerOf.call(1)
        assert(tokenId_owner == accounts[2]);
      });


    it('Transfering the ownership', async () => {
     const hospital = await Hospitals.deployed();
      const minted = await hospital.mint.call(accounts[2]);
      const _tokenId = 1;
      const _from = accounts[2];
      const _to = accounts[1];
      const call_data = "0x12345";
      try {
        const transferTx = await hospital.safeTransferFrom.sendTransaction(_from, _to, _tokenId,call_data, {
          from: _from
        });
        truffleAssert.eventEmitted(transferTx, "Transfer", async ev => {
          assert(
              ev["_from"].toString() == _from.toString() &&
              ev["_to"].toString() == _to.toString() &&
              ev["_tokenId"].toString() == _tokenId,
            "SafeTransfer failed"
          );
        });
        assert(true);
      } catch (err) {
        console.error('Error: ',err);
        assert(false);
      }
    });

    it('Aprroving the ownership', async () => {
        const hospital = await Hospitals.deployed();
         const minted = await hospital.mint.call(accounts[2]);
         const _tokenId = 1;
         const _from = accounts[2];
         const owner = accounts[0];
         try {
           const transferTx = await hospital.approve.sendTransaction(_from, _tokenId, {
             from: _from
           });
           truffleAssert.eventEmitted(transferTx, "Approval", async ev => {
             assert(
                 ev["_approved"].toString() == _from.toString() &&
                 ev["owner"].toString() == owner.toString() &&
                 ev["_tokenId"].toString() == _tokenId,
               "Approval failed"
             );
           });
           assert(true);
         } catch (err) {
           console.error('Error: ',err);
           assert(false);
         }
        })
})
})