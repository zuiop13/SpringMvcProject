package Controller.system;

public class SystemConstants {
    // 엘라스틱 정보
    public static final String SEARCH_HOST = "localhost";
    public static final int    SEARCH_PORT = 9200;
    public static final String SEARCH_SCHME = "http";
    public static final String ID = "elastic";
    public static final String PW = "changeme";

    //DNF api 정보
    public static final String DNF_DOMAIN = "https://api.neople.co.kr";
    public static final String DNF_KEY    = "rBlL4o1MNlRGkZY3p6FeAOSTkMjKQ0r6";
    public static final String DNF_SERVERS_PATH = " df/servers";

    //퍗샵,병원 api 정보
    public static final String LOCALDATA_DOMAIN = "http://www.localdata.go.kr/platform/rest/GR0/openDataApi";
    public static final String LOCALDATA_KEY    = "9rh64zYknhyssMIMxo3iPfeSYrxJBSbjiYGNbrvl7pc=";

    //유기견 공공데이터 api 정보
    public static final String KOSIS_DOMAIN = "http://openapi.animal.go.kr/openapi/service/rest/animalShelterSrvc/shelterInfo";
    public static final String KOSIS_KEY    = "8TnPQAwfcuTSzCAnZqIJvW80asnyB7cZtyyYZcgB8z0lTie4aGNd7TTg9JK8OFt6v%2BsyNmEf162SvTGZi3B%2BvA%3D%3D";

    // xml 파일경로
    public static final String XML_PATH    = "C:/Users/PRO/Desktop/동물보호복지온라인/fulldata_01.xml";

    //DB 정보
    public static final String DB_URL    = "jdbc:postgresql://127.0.1.1:5432/springdata";
    public static final String DB_USER   = "zuiop13";
    public static final String DB_PW     = "pass";
}
