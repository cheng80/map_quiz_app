import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;

class Home extends StatefulWidget {
  final Function(ThemeMode) onChangeThemeMode;
  final Function() getTheme;
  
  const Home({super.key, required this.onChangeThemeMode, required this.getTheme});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Property
  //late 는 초기화를 나중으로 미룸
  
  late MapController mapController;  //지도 컨트롤러
  late bool canRun;  //위치 정보 가져오기 가능 여부
  late List<String> _locationName; //위치 정보 리스트
  late latlng.LatLng _initLocation; //초기 위치 정보
  late List<latlng.LatLng> _latlngList; //위도, 경도 리스트
  late List<Color> _markerColorList; //마커 색상 리스트
  

  @override
  void initState() { //페이지가 새로 생성 될때 무조건 1번 사용 됨
    super.initState();
    mapController = MapController();

    _locationName = ['혜화문', '흥인지문', '창의문', '숙정문']; //지도에 보여줄 위치 이름 리스트
    // markerColorList = [const Color.fromARGB(255, 145, 77, 255), const Color.fromARGB(255, 243, 65, 33), const Color.fromARGB(255, 71, 25, 255), const Color.fromARGB(255, 14, 8, 55)];
    _markerColorList = [];

    _latlngList = [
      latlng.LatLng(37.5878892, 127.0037098), //혜화문
      latlng.LatLng(37.5711907, 127.009506), //흥인지문
      latlng.LatLng(37.5926027 , 126.9664771), //창의문
      latlng.LatLng(37.5956584, 126.9810576), //숙정문
    ];
    // _initLocation = latlng.LatLng(37.593, 126.985); 
    _initLocation = _centroidSimple(_latlngList); //초기 위치를 좌표 리스트(4개의 마커 좌표)의 단순 평균 중심점 계산
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body:_flutterMap()
    );
  }


  //--------Functions ------------

  _flutterMap()
  {
    _addMakerColor();
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: latlng.LatLng(_initLocation.latitude, _initLocation.longitude),
        initialZoom: 13.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.tj.app',
        ),
        
        MarkerLayer(markers: [
          for(int kindChoice=0; kindChoice<_locationName.length; kindChoice++)
          Marker(
            width: 150.0,
            height: 80.0,
            point: latlng.LatLng(_latlngList[kindChoice].latitude, _latlngList[kindChoice].longitude),
            child: Column(
              children: [
                Text( 
                  _locationName[kindChoice], 
                  style: 
                    TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _markerColorList[kindChoice])
                  ),
                Icon(Icons.pin_drop, size: 50, color: _markerColorList[kindChoice],),

              ],
            ),
          ),

          Marker(
            width: 150.0,
            height: 80.0,
            point: latlng.LatLng(_initLocation.latitude, _initLocation.longitude),
            child: Column(
              children: [
                Text( 
                  "중심점", 
                  style: 
                    TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.red)
                  ),
                Icon(Icons.pin_drop, size: 50, color: Colors.red,),

              ],
            ),
          ),

        ]),
        
      ],
      
    );
  }
  _addMakerColor() {
    _markerColorList.add(Theme.of(context).colorScheme.primary);
    _markerColorList.add(Theme.of(context).colorScheme.secondary);
    _markerColorList.add(Theme.of(context).colorScheme.tertiary);
    _markerColorList.add(Theme.of(context).colorScheme.error);
  }

  // 좌표 리스트를 받아서 단순 평균 중심점 계산
  latlng.LatLng _centroidSimple(List<latlng.LatLng> points) { 
    if (points.isEmpty) {
      throw ArgumentError('points 리스트가 비어 있습니다.');
    }

    double sumLat = 0.0;
    double sumLng = 0.0;

    for (final p in points) {
      sumLat += p.latitude;
      sumLng += p.longitude;
    }

    final n = points.length.toDouble();
    return latlng.LatLng(sumLat / n, sumLng / n);
  }
  //------------------------------
}