# ColorKit

<p align="center"><img src="Assets/colorkit_banner.jpg"/></p>

**ColorKit** is your companion to work with colors on iOS.

- [Features](#features)
- [Installation](#installation)
- [Contributin](#contributin)
- [License](#license)

## Features

### Dominant Colors
**ColorKit** makes it easy to find the dominant colors of an image. It returns a color palette of the most common colors on the image.

```swift
let dominantColors = try image.dominantColors()
```

<p align="center">
    <img src="Assets/dominant_colors.jpg">
</p>

---

### Average Color

To compute the average color of an image, simply call the `averageColor` function on a `UIImage` instance.
```swift
let averageColor = try image.averageColor()
```

---

### Color Difference (DeltaE)

Perceptual color difference / comparaison is a common problem of color science.  
It simply consists of calculating how different two colors look from each other, to the human eye. This is commonly referenced as the DeltaE.

**ColorKit** makes it a breaze to compare two colors.

```swift
let colorDifference = UIColor.green.difference(from: .white) // 120.34
```

While this may seem trivial, simply using the RGB color model often yields non-accurate results for human perception.
This is because RGB is not perceptually uniform.

Here is an example highlighting the limitations of using the RGB color model to compare colors.

<p align="center">
    <img src="Assets/color_difference_deltaE_RGB.jpg">
</p>

As you can see, the difference between the two greens (left) is considered greater than the difference between the pink and gray colors (right). In other words, the pink and gray are considered to look more similar than the two greens.  
This obviously does not match the expectation of the human eye.

Thankfully, **ColorKit** provides algorithms that make it possible to compare colors just like the human eye would: **CIE76**, **CIE94** and **CIE2000**.

```swift
let colorDifference = UIColor.green.difference(from: .white, using: .CIE94) 
```

Here is the same example as above, using the **CIE94** algorithm.

<p align="center">
    <img src="Assets/color_difference_deltaE_CIE94.jpg">
</p>

The **CIE94** algorithm successfuly realizes that the two greens (left) look closer from each other than the pink and gray (right) do.

More information about color difference can be found [here](https://en.wikipedia.org/wiki/Color_difference).

---

### Contrast Ratio

To calculate the contrast ratio between two colors, simply use the `contrastRatio` function.
```swift
let contrastRatio = UIColor.green.contrastRatio(with: UIColor.white)
```
The contrast ratio is particularly important when displaying text.
To ensure that it's readable by everyone, **ColorKit** makes it easy for you to follow the accessibility guidelines set by WCAG 2.

---

### Color Space Conversions

**ColorKit** assists you when translating a color from a color space to another.
They're simply supported as extensions on `UIColor`.  
**CIELAB**, **XYZ** and **CMYK** are supported.

---

### More

There is a lot more that **ColorKit** is capable of.
Here is a short list of examples:
- Working with Hex color codes
```swift
let hexValue = UIColor.green.hex
let color = UIColor(hex: "eb4034")
```
- Generating random colors.
```swift
let randomColor = UIColor.random()
```
- Calculating the relative luminance of a color
```swift
let relativeLuminance = UIColor.green.relativeLuminance
```
- Calculating complementary colors
```swift
let complementaryColor = UIColor.green.complementaryColor
```