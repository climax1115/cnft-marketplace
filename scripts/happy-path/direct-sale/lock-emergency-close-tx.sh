set -eux

thisDir=$(dirname "$0")
baseDir=$thisDir/../..
tempDir=$baseDir/../temp

DATUM_PREFIX=${1:-0}
offset=${2:-500000}

$baseDir/generate-datums.sh $offset
sleep 2
$baseDir/hash-datums.sh

$baseDir/core/direct-sale/lock-1-input-tx.sh \
  $(cat ~/$BLOCKCHAIN_PREFIX/seller.addr) \
  ~/$BLOCKCHAIN_PREFIX/seller.skey \
  "1724100 lovelace + 1 d6cfdbedd242056674c0e51ead01785497e3a48afbbb146dc72ee1e2.123456" \
  $(cat $tempDir/$BLOCKCHAIN_PREFIX/datums/$DATUM_PREFIX/buy-emergency-close-hash.txt)
