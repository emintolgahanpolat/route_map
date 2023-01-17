# Route Map
Ek açıklama kullanaran Flutter Navigator 2 için rota yolları haritası oluşturun.


<a href="https://www.buymeacoffee.com/emintpolat" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

## Bağımlılıklar
        dependencies:  
            route_map:  
  
        dev_dependencies:  
            route_map_generator:  
            build_runner: 
## Kurulum

1. RouteMapInit ek açıklamasıyla Route Generator tanımlayalım.


        import 'route_map.config.dart';

        @RouteMapInit()
        Route? onGenerateRoute(RouteSettings routeSettings) => $onGenerateRoute(routeSettings);

2. Matarial App widget içersinde route oluşturucuyu tanımlayalım
        
        MaterialApp(
            initialRoute: RouteMaps.splash, // başlangıç sayfasını bildirir.
            onGenerateRoute: onGenerateRoute
        );

3. Sayfaları tanımlayalım. 
Not: Kök dizini belirtmek için "/" kullanınız. Kök dizinden bağımsız sayfa oluşturmak için başında "/" bulunmamalıdır.

        @RouteMap(name: "splash")
        class SplashPage extends StatefulWidget {}

        @RouteMap(name: "/")
        class HomePage extends StatefulWidget {}

        @RouteMap(name: "/ara", fullScreenDialog: true)
        class SearchPage extends StatefulWidget {}
4. Sayfa arası yönlendrimelerde veri taşımanın daha kolay yolu için yönlendirilecek sınıf nesnesinden yararlanabilirsiniz. Navigator sınıfının tüm fonksiyonlarını kullanabilirsiniz.
        
        DetailPage(id: "0",name: "push",isShow: false).push(context);
        DetailPage(id: "0",name: "push",isShow: false).popAndPush(context);

5. Sayfalar arası yönlendirme. Yönlendirme esnasında değer göndermek için arguments alanı kullanılabilir.

           Navigator.of(context)
                    .pushNamed(RouteMaps.detailPage, arguments: "value");

           Navigator.of(context)
                    .pushNamed(RouteMaps.detailPage, arguments: {"val1":"Easy","val2":"Route"});

6. Arguments ile gelen veriyi okuma.
            
            String value = context.routeArgs();

            String val1 = context.routeArgs()["val1"];
            String val2 = context.routeArgs()["val2"];


### Run the generator 
Use the [watch] flag to watch the files' system for edits and rebuild as necessary.
```terminal  
flutter packages pub run build_runner watch  
```
if you want the generator to run one time and exits use
```terminal  
flutter packages pub run build_runner build  
```
