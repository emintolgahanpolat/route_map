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
- [English](https://github.com/emintolgahanpolat/route_map/blob/main/route_map/README.md)
- [Türkçe](https://github.com/emintolgahanpolat/route_map/blob/main/route_map/README.tr.md)

## İçindekiler
- [Route Map](#route-map)
  - [README Translation](#readme-translation)
  - [İçindekiler](#i̇çindekiler)
  - [Bağımlılıklar](#bağımlılıklar)
  - [Kurulum](#kurulum)
  - [Oluşturucuyu çalıştırın](#oluşturucuyu-çalıştırın)
  - [Kod oluşturucu ile ilgili bir sorun mu var?](#kod-oluşturucu-ile-ilgili-bir-sorun-mu-var)
  - [Kütüphaneyi destekleyin](#kütüphaneyi-destekleyin)

## Öğretici 
-  [Bottom navigation bar](https://medium.com/@emintolgahanpolat/flutter-bottom-navigation-bar-with-multiple-navigators-676eacdc0611) ile kullanımı.


![Bottom navigation bar](/route_map/example/art/bottom_nav_bar.gif "Bottom navigation bar")


![web](/route_map/example/art/web.gif "web")

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

2. Yönlendirme, uygulama durumuna göre konumu yenisiyle değiştirir. Örneğin, kullanıcı oturum açmamışsa bir oturum açma ekranını görüntülemek için yeniden yönlendirme kullanılabilir.

```dart
import 'route_map.config.dart';

        @RouteMapInit()
        Route? onGenerateRoute(RouteSettings routeSettings) => $onGenerateRoute(routeSettings,redirect:(){
                bool isLogin = false;
                if(isLogin){
                   return RouteMap.login;
                }
           return null;
        });
```
3. `MaterialApp` widget içerisinde route oluşturucuyu tanımlayalım
```dart        
MaterialApp(
        initialRoute: RouteMaps.splash, // başlangıç sayfasını bildirir.
        onGenerateRoute: onGenerateRoute
);
```
4. Sayfalarınıza `@RouteMap` ile açıklama ekleyin.
>Not: Kök dizini belirtmek için "/" kullanınız. Kök dizinden bağımsız sayfa oluşturmak için başında "/" bulunmamalıdır.

```dart
// İsimle sayfa yönlendirme kök dizinden bağımsız sayfa
@RouteMap(name: "splash")
class SplashPage extends StatefulWidget {}
// İsimle sayfa yönlendirme kök dizin
@RouteMap(name: "/")
class HomePage extends StatefulWidget {}
// İsimle sayfa yönlendirme kök dizin bağımlı sayfa
// tam ekran dialog
@RouteMap(name: "/ara", fullScreenDialog: true)
class SearchPage extends StatefulWidget {}
// İsimle sayfa yönlendirme kök dizin bağımlı sayfa
// Path ile yönlendirme web ve deeplink kullanımı için
@RouteMap(name: "/detail", path:"/detail/:id/:name")
class DetailPage extends StatefulWidget {}
```
5. Sayfa arası yönlendrimelerde veri taşımanın daha kolay yolu için yönlendirilecek sınıf nesnesinden yararlanabilirsiniz. Navigator sınıfının tüm fonksiyonlarını kullanabilirsiniz.
```dart  
// Tip korumalı sayfa yönlendirme
DetailPageRoute(id: "0",name: "push",isShow: false).push(context);

DetailPageRoute(id: "0",name: "push",isShow: false).popAndPush(context);
```
6. Standart Navigator kullanarak sayfalar arası yönlendirme
   >**Yönlendirme esnasında değer göndermek için arguments alanı kullanılabilir.**
```dart
// sayfalar arası veri taşıma
Navigator.of(context)
        .pushNamed(RouteMaps.detailPage, arguments: "value");
// sayfalar arası çoklu veri taşıma
Navigator.of(context)
        .pushNamed(RouteMaps.detailPage, arguments: {"val1":"Easy","val2":"Route"});
// path ile yönlendirme
Navigator.pushNamed(
                context,
                "/detail/1234/tolga/?isShow=true",
                arguments: CustomModel(name: 'test'),
              );
```
7. Önceki ekrandan gönderilen verileri `routeArgs()` ile okuma
```dart
String value = context.routeArgs();

String val1 = context.routeArgs()["val1"];

String val2 = context.routeArgs()["val2"];
```
8. Özel bir model kullanılıyorsa, @RouteMapArg() ile işaretlenmelidir.
```dart
@RouteMapArg()
class CustomModel {
  String name;
  CustomModel({required this.name});
}
```
9. Özelleştirilmiş inşa edici kullanılabilir. Örneğin sayfanızı ChangeNotifierProvider ile sarmalamak isteyebilirsiniz.
```dart
Widget homeBuilder(Widget child) {
  return ChangeNotifierProvider(
    create: (_) => HomeViewModel(),
    child: child,
  );
}

@RouteMap(name: "home", builder: homeBuilder)
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
