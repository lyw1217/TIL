# HPACK: Header Compression for HTTP/2

## 1. HPACK?

HTTP/1.1([RFC7230](https://datatracker.ietf.org/doc/html/rfc7230))에서는 헤더 필드를 압축하지 않았습니다. 하지만 웹의 발전에 따라 웹 페이지가 수십, 수백 개의 요청을 처리하게 되었고, 요청마다 중복되는 헤더 필드는 불필요하게 대역폭을 소비해서 레이턴시가 늘어나버렸습니다.

중복 헤더 필드를 제거하고 보안 공격에 대한 취약성을 

### Overview

The format defined in this specification treats a list of header fields as an ordered collection of name-value pairs that can include duplicate pairs.  Names and values are considered to be opaque sequences of octets, and the order of header fields is preserved after being compressed and decompressed. Encoding is informed by header field tables that map header fields to indexed values.  These header field tables can be incrementally updated as new header fields are encoded or decoded. In the encoded form, a header field is represented either literally or as a reference to a header field in one of the header field tables.  Therefore, a list of header fields can be encoded using a mixture of references and literal values. Literal values are either encoded directly or use a static Huffman code. The encoder is responsible for deciding which header fields to insert as new entries in the header field tables.  The decoder executes the modifications to the header field tables prescribed by the encoder, reconstructing the list of header fields in the process.  This enables decoders to remain simple and interoperate with a wide variety of encoders. Examples illustrating the use of these different mechanisms to represent header fields are available in Appendix C.

## 참고 자료
- [IETF RFC 7541 HPACK: Header Compression for HTTP/2](https://datatracker.ietf.org/doc/html/rfc7541)
- [Luavis' Dev Story - RFC 7541(HTTP 2/HPACK) HPACK](https://luavis.me/http2/http2-header)