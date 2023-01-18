# Route Map
Ek açıklama kullanaran Flutter Navigator 2 için rota yolları haritası oluşturun.

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

## İçindekiler
- [Route Map](#route-map)
  - [README Translation](#readme-translation)
  - [İçindekiler](#i̇çindekiler)
  - [Bağımlılıklar](#bağımlılıklar)
  - [Kurulum](#kurulum)
  - [Oluşturucuyu çalıştırın](#oluşturucuyu-çalıştırın)
  - [Kod oluşturucu ile ilgili bir sorun mu var?](#kod-oluşturucu-ile-ilgili-bir-sorun-mu-var)
  - [Kütüphaneyi destekleyin](#kütüphaneyi-destekleyin)

---
## Bağımlılıklar
```yaml  
dependencies:  
  # route_map'i dependencies'e ekleyin  
  route_map:  
  
dev_dependencies:  
  # route_map_generator paketimizi dev_dependencies'e ekleyin
  route_map_generator:  
  # eğer henüz eklenmediyse build_runner ekleyin  
  build_runner:  
```  
## Kurulum

1. RouteMapInit ek açıklamasıyla Route Generator tanımlayalım.
```dart
import 'route_map.config.dart';

@RouteMapInit()
Route? onGenerateRoute(RouteSettings routeSettings) => $onGenerateRoute(routeSettings);
```
2. `MaterialApp` widget içerisinde route oluşturucuyu tanımlayalım
```dart        
MaterialApp(
        initialRoute: RouteMaps.splash, // başlangıç sayfasını bildirir.
        onGenerateRoute: onGenerateRoute
);
```
3. Sayfalarınıza `@RouteMap` ile açıklama ekleyin.
>Not: Kök dizini belirtmek için "/" kullanınız. Kök dizinden bağımsız sayfa oluşturmak için başında "/" bulunmamalıdır.
```dart
@RouteMap(name: "splash")
class SplashPage extends StatefulWidget {}

@RouteMap(name: "/")
class HomePage extends StatefulWidget {}

@RouteMap(name: "/ara", fullScreenDialog: true)
class SearchPage extends StatefulWidget {}
```
4. Sayfa arası yönlendrimelerde veri taşımanın daha kolay yolu için yönlendirilecek sınıf nesnesinden yararlanabilirsiniz. Navigator sınıfının tüm fonksiyonlarını kullanabilirsiniz.
```dart  
DetailPage(id: "0",name: "push",isShow: false).push(context);

DetailPage(id: "0",name: "push",isShow: false).popAndPush(context);
```
5. Standart Navigator kullanarak sayfalar arası yönlendirme
   >**Yönlendirme esnasında değer göndermek için arguments alanı kullanılabilir.**
```dart
Navigator.of(context)
        .pushNamed(RouteMaps.detailPage, arguments: "value");

Navigator.of(context)
        .pushNamed(RouteMaps.detailPage, arguments: {"val1":"Easy","val2":"Route"});
```
1. Önceki ekrandan gönderilen verileri `routeArgs()` ile okuma
```dart
String value = context.routeArgs();

String val1 = context.routeArgs()["val1"];

String val2 = context.routeArgs()["val2"];
```

## Oluşturucuyu çalıştırın 
Düzenlemeler için dosyaların sistemini izlemek ve gerekirse yeniden oluşturmak için **[watch]** bayrağını kullanın.
```terminal  
flutter packages pub run build_runner watch --delete-conflicting-outputs 
```
Kod oluşturucusunu tek seferlik çalıştırmak istiyorsanız;
```terminal  
flutter packages pub run build_runner build --delete-conflicting-outputs 
```

## Kod oluşturucu ile ilgili bir sorun mu var?

Oluşturucuyu çalıştırmadan önce dosyalarınızı her zaman **kaydettiğinizden** emin olun, bu işe yaramazsa her zaman temizlemeyi ve yeniden oluşturmayı deneyebilirsiniz.

```terminal  
flutter packages pub run build_runner clean  
```  

## Kütüphaneyi destekleyin

- Kitaplığı [Github](https://github.com/emintolgahanpolat/route_map)'da yıldızlayarak ve [pub.dev](https://pub.dev/packages/route_map)'de beğenerek destekleyebilir veya karşılaştığınız hataları bildirebilirsiniz.
- Ayrıca bir öneriniz varsa veya bir şeyin daha iyi uygulanabileceğini düşünüyorsanız, bir **issue** açın ve bunun hakkında konuşalım.
