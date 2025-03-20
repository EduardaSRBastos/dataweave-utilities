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
