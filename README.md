# dataweave-utilities
Useful DataWeave functions library

### Remove Invalid XML Characters
<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos%2Fdataweave-utilities&path=invalid-xml-char">Dataweave Playground<a>

<details>
  <summary>Function</summary>

```dataweave
%dw 2.0
output application/xml

var removeInvalidChars = (payload) -> 
    if (payload is String) 
        payload replace /[^\p{Print}]/ with "" 
    else if (payload is Object) 
        payload mapObject { 
            ($$): removeInvalidChars($)
        }
    else if (payload is Array) 
        payload map (item) -> removeInvalidChars(item)
    else 
        payload
---

main: removeInvalidChars(payload)

```
</details>

### Simple Cipher
<a href="https://dataweave.mulesoft.com/learn/playground?projectMethod=GHRepo&repo=EduardaSRBastos%2Fdataweave-utilities&path=cipher">Dataweave Playground<a>

<details>
  <summary>Function</summary>

```dataweave
%dw 2.0
output application/json
import * from dw::core::Strings

fun encryptChar(char, index) =
    fromCharCode(
        charCodeAt(char, 0) +
        (((index + 2) mod 8) * 8 - 2) +
        ((index + 2) mod 32) - 16 + 128
    )

fun encryptText(text) =
    if (isEmpty(text)) 
        ""
    else
        reverse(
            (text splitBy "")
                map ((char, index) -> encryptChar(char, index))
                joinBy ""
        )

fun decryptChar(char, index) =
    fromCharCode(
        charCodeAt(char, 0) -
        (((index + 2) mod 8) * 8 - 2) -
        ((index + 2) mod 32) + 16 - 128
    )

fun decryptText(text) =
    if (isEmpty(text)) 
        ""
    else
    (reverse(text) splitBy "")
        map ((char, index) -> decryptChar(char, index))
        joinBy ""

---
{
  "Encrypted message": encryptText(payload.message),
  "Decrypted message": decryptText(encryptText(payload.message))
}
```
</details>