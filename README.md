# Route Map
Generate route paths map for Flutter Navigator 2 using annotation.

<p>    
<a href="https://img.shields.io/badge/License-MIT-green"><img     
align="center" src="https://img.shields.io/badge/License-MIT-green" alt="MIT License"></a>      
<a href="https://github.com/emintolgahanpolat/route_map"><img align="center" src="https://img.shields.io/github/stars/emintolgahanpolat/route_map?style=flat&logo=github&colorB=green&label=stars" alt="stars"></a>      
<a href="https://pub.dev/packages/route_map"><img     
align="center" src="https://img.shields.io/pub/v/route_map.svg?" alt="pub version"></a>      
<a href="https://www.buymeacoffee.com/emintpolat" target="_blank"><img align="center" src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="30px" width= "108px"></a>    
<p>  

## README Translation
- [English](README.md)
- [Türkçe](README.tr.md)
## Table of Contents
- [Route Map](#route-map)
  - [README Translation](#readme-translation)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [Setup](#setup)
  - [Run the generator](#run-the-generator)
  - [Problems with the generation?](#problems-with-the-generation)
  - [Support the Library](#support-the-library)

---  
## Installation

```yaml  
dependencies:  
  # add route_map to your dependencies  
  route_map:  
  
dev_dependencies:  
  # add the generator to your dev_dependencies  
  route_map_generator:  
  # add build runner if not already added  
  build_runner:  
```  
## Setup

1. First, define Route Generator with RouteMapInit annotation.
```dart
import 'route_map.config.dart';

        @RouteMapInit()
        Route? onGenerateRoute(RouteSettings routeSettings) => $onGenerateRoute(routeSettings);
```
2. Define the route builder in the  `MaterialApp` widget
   
```dart
MaterialApp(
        initialRoute: RouteMaps.splash, // defining the initial page
        onGenerateRoute: onGenerateRoute
);
```

3. Annotate your pages with `@RouteMap` and let the generator do the work. 
>Note: Use "/" to specify the root directory. To create a root-independent page, there must be no "/" at the beginning.
```dart
@RouteMap(name: "splash")
class SplashPage extends StatefulWidget {}

@RouteMap(name: "/")
class HomePage extends StatefulWidget {}

@RouteMap(name: "/search", fullScreenDialog: true)
class SearchPage extends StatefulWidget {}
```

4. You can take advantage of the class object to be redirected when passing data between pages. You can use all the functions of the standart Navigator class.
```dart
DetailPageRoute(id: "0",name: "push").push(context);

DetailPageRoute(id: "0",name: "push").popAndPush(context);
```
5. Redirection between pages using standart Navigator class
>**The arguments field can be used to send values during routing.**
```dart
Navigator.of(context)
        .pushNamed(RouteMaps.detailPage, arguments: "value");

Navigator.of(context)
        .pushNamed(RouteMaps.detailPage, arguments: {"val1":"Easy","val2":"Route"});
```
6. Reading the values with `routeArgs()` passed from previous screen via Navigator.
```dart
String value = context.routeArgs();

String val1 = context.routeArgs()["val1"];

String val2 = context.routeArgs()["val2"];
```

## Run the generator 
Use the **[watch]** flag to watch the files' system for edits and rebuild as necessary.
```terminal  
flutter packages pub run build_runner watch --delete-conflicting-outputs  
```
if you want the generator to run one time and exits use
```terminal  
flutter packages pub run build_runner build --delete-conflicting-outputs  
```

## Problems with the generation?

Make sure you always **Save** your files before running the generator, if that does not work you can always try to clean and rebuild.

```terminal  
flutter packages pub run build_runner clean  
```  

## Support the Library

- You can support the library by staring it on [Github](https://github.com/emintolgahanpolat/route_map) && liking it on [pub.dev](https://pub.dev/packages/route_map) or report any bugs you encounter.
- Also, if you have a suggestion or think something can be implemented in a better way, open an issue and let's talk about it.