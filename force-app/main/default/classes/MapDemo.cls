public with sharing class MapDemo {
    public static void MapDemoMethod() {
        Map<Integer, String> mapName = new Map<Integer, String>();
        mapName.put(1,'A');
        mapName.put(2,'B');
        System.debug('mapName===' + mapName);
        mapName.remove(2);
        System.debug('mapName=after removing==' + mapName);
        System.debug(mapName.size());
        List<String> strLst = new List<String>();
        strLst = mapName.values();
        System.debug('mapName--' + strLst);

    }
}