namespace Nuxed\Crypto\Symmetric\Authentication;

use namespace Nuxed\Crypto\{Binary, Exception, Str};

/**
 * Verify the authenticity of a message, given a shared MAC key
 */
function verify(string $message, SignatureKey $key, string $mac): bool {
  if (Binary\length($mac) !== \SODIUM_CRYPTO_GENERICHASH_BYTES_MAX) {
    throw new Exception\InvalidSignatureException(
      'Message Authentication Code is not the correct length; is it encoded?',
    );
  }

  $calc = \sodium_crypto_generichash(
    $message,
    $key->toString(),
    \SODIUM_CRYPTO_GENERICHASH_BYTES_MAX,
  );
  $result = Str\equals($mac, $calc);
  \sodium_memzero(inout $calc);
  return $result;
}
