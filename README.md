# Svgs 'n Scotty
A DSL for various shapes and transformations which displays the images through scotty.

## The DSL
Drawings consist of transformations, a shape and and some style transforms. Lists of drawings are rendered using scotty.
```
(Transforms,Shape,StyleTrans)
```
### Shapes
The DSL permits the generation of squares and circles (rectangles can be created through scaling)

### Style
The style of the drawing can be modified by adding style transformations which include:

``` 
fill red
```
``` 
stroke blue 
```
``` 
strokeWidth 0.05
```
Multiple styles can __glued__ together into a single style
```
fill red <%> stroke blue <%> strokeWidth 0.05
```

### Transformations
The Svg can be transformed in various ways:

```
translate 5 10
```
```
scale 3 4
```
```
rotate 120
```
Multiple transforms can be __composed__ together
```
translate 5 10 <+> scale 3 4 <+> rotate 120
```

## Building & Running
```
stack build
```
```
stack exec Shapings
```
Navigate to [localhost:3000](http://localhost:3000) where your Svgs will be rendered.

## Modifying
The __Main.hs__ contains some example drawings. Create Svgs in line with these example or study the source for a more indepth understanding.
