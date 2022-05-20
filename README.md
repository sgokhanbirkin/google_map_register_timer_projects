# Google Map Kullanımı , Register Page (Cubit) , Timer 

## Proje Demosu



## Çalıştırmak İçin Yapılması Gerekenler

### geolocator

Öncelikle geolocator paketinin bazı gereksinimleri mevcut. Bunun için pub.dev üzerinden paketin gereksinimlerini yerine getirmemiz gerekiyor.
Android ve Ios için https://pub.dev/packages/geolocator adresinden gerekli izinleri yapıp devam edebiliriz.

### Google Maps Platform

Google cloud üzerinden google maps platform sekmesine gidip yeni proje oluşturmamız gerekiyor.
Creadentials kısmından bir API keys oluşturup google maps'e bağlantı için gerekli adımlara geçiyoruz.

https://console.cloud.google.com/projectselector2/google/maps-apis/overview?supportedpurview=project


### Google Maps API Key

#### Android için AndroidManifest.xml dosyasının en alt satırına aşağıdaki kodu ekliyoruz. <APIKEY> kısmına oluşturduğunuz ApiKeyi giriyoruz.
  
`<meta-data android:name="com.google.android.geo.API_KEY" android:value="<APIKEY>"/>`

#### Ios için Runner/AppDelegate.swift dosyasında aşağıdaki kodları ekliyoruz.
  
   `import GoogleMaps`



  
  `GMSServices.provideAPIKey("<API KEY>")`
  
   
  ### İzinler bu kadar gerisi kodda :) Kullanım için ben .env dosyası içerisinde oluşturup kullanmıştım. Sizde öyle yapabilirsiniz.
