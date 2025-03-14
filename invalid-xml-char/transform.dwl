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
