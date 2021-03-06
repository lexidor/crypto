namespace Nuxed\Crypto\Symmetric\Authentication;

use namespace Nuxed\Crypto;
use namespace HH\Lib\SecureRandom;
use namespace Nuxed\Crypto\{Binary, Exception, Symmetric};

final class SignatureKey extends Symmetric\Key {
  const int LENGTH = \SODIUM_CRYPTO_AUTH_KEYBYTES;

  public function __construct(Crypto\HiddenString $keyMaterial) {
    if (
      Binary\length($keyMaterial->toString()) !== \SODIUM_CRYPTO_AUTH_KEYBYTES
    ) {
      throw new Exception\InvalidKeyException(
        'Authentication key must be const(Key::LENGTH) bytes long',
      );
    }

    parent::__construct($keyMaterial);
  }

  public static function generate(): this {
    return new self(
      new Crypto\HiddenString(SecureRandom\string(static::LENGTH)),
    );
  }
}
