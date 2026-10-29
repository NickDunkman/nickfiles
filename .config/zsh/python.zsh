# let packages that compile C extensions (e.g. via pip/uv) find Homebrew's openssl
export LDFLAGS="-L/opt/homebrew/opt/openssl/lib"
export CFLAGS="-I/opt/homebrew/opt/openssl/include"
