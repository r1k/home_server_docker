#!/usr/bin/env python3

import hashlib
import getpass
import random
import sys
import locale
import warnings
import platform

salt_len = 12
algorithm = 'sha1'

# to deal with the possibility of sys.std* not being a stream at all
def get_stream_enc(stream, default=None):
    """Return the given stream's encoding or a default.
    There are cases where ``sys.std*`` might not actually be a stream, so
    check for the encoding attribute prior to returning it, and return
    a default if it doesn't exist or evaluates as False. ``default``
    is None if not provided.
    """
    if not hasattr(stream, 'encoding') or not stream.encoding:
        return default
    else:
        return stream.encoding


# Less conservative replacement for sys.getdefaultencoding, that will try
# to match the environment.
# Defined here as central function, so if we find better choices, we
# won't need to make changes all over IPython.
def getdefaultencoding(prefer_stream=True):
    """Return IPython's guess for the default encoding for bytes as text.

    If prefer_stream is True (default), asks for stdin.encoding first,
    to match the calling Terminal, but that is often None for subprocesses.

    Then fall back on locale.getpreferredencoding(),
    which should be a sensible platform default (that respects LANG environment),
    and finally to sys.getdefaultencoding() which is the most conservative option,
    and usually ASCII on Python 2 or UTF8 on Python 3.
    """
    enc = None
    if prefer_stream:
        enc = get_stream_enc(sys.stdin)
    if not enc or enc == 'ascii':
        try:
            # There are reports of getpreferredencoding raising errors
            # in some cases, which may well be fixed, but let's be conservative here.
            enc = locale.getpreferredencoding()
        except Exception:
            pass
    enc = enc or sys.getdefaultencoding()
    # On windows `cp0` can be returned to indicate that there is no code page.
    # Since cp0 is an invalid encoding return instead cp1252 which is the
    # Western European default.
    if enc == 'cp0':
        warnings.warn(
            "Invalid code page cp0 detected - using cp1252 instead."
            "If cp1252 is incorrect please ensure a valid code page "
            "is defined for the process.", RuntimeWarning)
        return 'cp1252'
    return enc

DEFAULT_ENCODING = getdefaultencoding()

def no_code(x, encoding=None):
    return x

def encode(u, encoding=None):
    encoding = encoding or DEFAULT_ENCODING
    return u.encode(encoding, "replace")

if sys.version_info[0] >= 3 or platform.python_implementation() == 'IronPython':
    str_to_bytes = encode
else:
    str_to_bytes = no_code

def cast_bytes(s, encoding=None):
    if not isinstance(s, bytes):
        return encode(s, encoding)
    return s

passphrase = getpass.getpass('Passphrase: ')

h = hashlib.new(algorithm)
salt = ('%0' + str(salt_len) + 'x') % random.getrandbits(4 * salt_len)
h.update(cast_bytes(passphrase, 'utf-8') + str_to_bytes(salt, 'ascii'))

print(':'.join((algorithm, salt, h.hexdigest())))

