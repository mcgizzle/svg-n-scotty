# Svgs 'n Scotty
A DSL for various shapes and transformations which displays the images through scotty.

## The DSL
Shapes consist of transformations, a shape and and some style transforms. Lists of shapes are rendered using scotty.
```
[(Transforms,Shape,StyleTrans)]
```
Below details how to use the DSL to generate your own Svg's, through both the web service and source code.

### Shapes
The DSL permits the generation of squares and circles (rectangles can be created through scaling)

### Style
The style of the drawing can be modified by adding style transformations which include:

| __Code__          | __Web Service__ |
|---|---|
| `fill red`        | `Fill Red`      |
| `stroke blue`     | `Stroke Blue`   |
| `strokeWidth 2.0` | `Width 2.0`     |

Multiple styles can __glued__ together into a single style
```
fill red <%> stroke blue <%> strokeWidth 0.05
```
__Note__ ```Glue (Style) (Style)``` must be used on the web service instead of the infix ```<%>```.

### Transformations
The Svg can be transformed in various ways:

| __Code__          | __Web Service__ |
|---|---|
| `translate 5 10`  | `Translate 5 10`|
| `scale 3 4`       | `Scale 3 4`     |
| `rotate 120`      | `Rotate 120`    |

Multiple transforms can be __composed__ together
```
translate 5 10 <+> scale 3 4 <+> rotate 120
```
__Note__ `Compose (Transform) (Transform)` must be used on the web service instead of the infix `<+>`.

## Building & Running with [stack](https://docs.haskellstack.org/en/stable/README/)
```
stack build
```
```
stack exec Shapings
```
Navigate to [localhost:3000](http://localhost:3000) where you can enter DSL strings to be rendered.

## Modifying
The __Main.hs__ contains some example drawings. Create Svgs in line with these example or study the source for a more indepth understanding.
