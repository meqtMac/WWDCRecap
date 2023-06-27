# DocC in Xcode 15

This is a sample Document eperiment for DocC Documentation and Xcode 15 Documentation Preview.

@Metadata {
    @CallToAction(
                  purpose: link,
                  url: "https://developer.apple.com/wwdc23/10244")
    @PageImage(
              purpose: card,
               source: "DocumentPreview",
               alt: "Documentation Preview")
    @PageImage(
               purpose: icon,
               source: "DocumentPreview",
               alt: "A technology icon representing the document preview"
               )
    @PageColor(purple)
    
}

## Overview


### Features
@Links(visualStyle: detailedGrid) {
    - <doc:DocCDemo>
}


### Docomentation Preview

![](DocumentPreview)

### Extended formatting

#### @Row/@Column

@Row {
    @Column {
        ``` swift
        let x = 1024
        ```
    }
        
    @Column {
        ``` swift
        var y = 1024
        ```
    }
}

#### TavNavigator
@TabNavigator {
    @Tab("English") {
        Hello, world.
    }
        
    @Tab("中文")  {
        你好
    }
        
    @Tab("Emoji") {
        😀
    }
}
    
#### Video
Missed, as I have no apporiate source for this part.
    
### Metadata
- `@CallToAction`, link
- `@PageKind`, article, sampleCode
- `@PageImage`, icon, card
- `@Links`, list, detailedGrid

### Theming
```json
// theme-setting.json
{
    "theme": {
        "color": {
            "standard-green": "#83ac38"
        },
        "typography": {
            "html-font": "serif"
        }
    }
}
```

### Swift-DocC quick navigation
Don't know if it's only for web.
