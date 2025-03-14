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