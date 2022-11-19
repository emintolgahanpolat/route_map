# Easy Route
Ek açıklama kullanaran Flutter Navigator 2 için rota yolları haritası oluşturun.

## Bağımlılıklar
        dependencies:  
            easy_route:  
  
        dev_dependencies:  
            easy_route_generator:  
            build_runner: 
## Kurulum

1. EasyRouteInit ek açıklamasıyla Route Generator tanımlayalım.


        import 'easy_route.config.dart';

        @EasyRouteInit()
        Route? onGenerateRoute(RouteSettings routeSettings) => $onGenerateRoute(routeSettings);

2. Matarial App widget içersinde route oluşturucuyu tanımlayalım
        
        MaterialApp(
            initialRoute: EasyRoutes.splash, // başlangıç sayfasını bildirir.
            onGenerateRoute: onGenerateRoute
        );

3. Sayfaları tanımlayalım. 
Not: Kök dizini belirtmek için "/" kullanınız. Kök dizinden bağımsız sayfa oluşturmak için başında "/" bulunmamalıdır.

        @EasyRoute(name: "splash")
        class SplashPage extends StatefulWidget {}

        @EasyRoute(name: "/")
        class HomePage extends StatefulWidget {}

        @EasyRoute(name: "/ara", fullScreenDialog: true)
        class SearchPage extends StatefulWidget {}

4. Sayfalar arası yönlendirme. Yönlendirme esnasında değer göndermek için arguments alanı kullanılabilir.

           Navigator.of(context)
                    .pushNamed(EasyRoutes.detailPage, arguments: "value");

           Navigator.of(context)
                    .pushNamed(EasyRoutes.detailPage, arguments: {"val1":"Easy","val2":"Route"});

5. Arguments ile gelen veriyi okuma.
            
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
