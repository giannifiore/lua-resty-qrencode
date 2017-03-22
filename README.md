lua-resty-qrencode
==========

lua-resty-qrencode is a wrapper of [libqrencode](http://fukuchi.org/works/qrencode/) with libpng for OpenResty(nginx_lua).

## Install

lua-resty-qrencode is dependent on [libqrencode](http://fukuchi.org/works/qrencode/)
and [libpng](http://www.libpng.org/pub/png/libpng.html), so make sure these are installed
before compile it.

### MacOS

```
$ brew install libqrencode
$ git clone https://github.com/orangle/lua-resty-qrencode.git
$ cd lua-resty-qrencode
$ make
$ make install
```

defalut openresty `PREFIX` is `/usr/local/openresty`, if you have a different path, please read `Makefile` and change the path.

### Other

please install libqrencode and libpng, and read Makefile. or you can see http://blog.csdn.net/orangleliu/article/details/64912578#t0


## Example usage

```lua
    location /qrcode {
        content_by_lua_block {
            local qr = require("qrencode")
            local args = ngx.req.get_uri_args()
            local text = args.text

            if text == nil or text== "" then
                ngx.say('need a text param')
                ngx.exit(404)
            end

            ngx.say(qr {
                text=text,
                level="L",
                kanji=false,
                ansi=true,
                size=4,
                margin=2,
                symversion=0,
                dpi=78,
                casesensitive=true,
                foreground="48AF6D",
                background="3FAF6F"
            })
        }
    }
```

test url like
```
curl 'http://127.0.0.1:8008/qrcode?text=http://orangleliu.info'
```

when pass a table, "text" is required and other is optional.


