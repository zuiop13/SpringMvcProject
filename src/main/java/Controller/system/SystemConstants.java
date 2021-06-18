package Controller.system;

public class SystemConstants {
    // 엘라스틱 정보
    public static final String SEARCH_HOST = "localhost";
    public static final int    SEARCH_PORT = 9200;
    public static final String SEARCH_SCHME = "http";
    public static final String ID = "elastic";
    public static final String PW = "changeme";

    //DNF api 정보
    public static final String DNF_DOMAIN       = "https://api.neople.co.kr";
    public static final String DNF_KEY          = "rBlL4o1MNlRGkZY3p6FeAOSTkMjKQ0r6";
    public static final String DNF_SERVERS_PATH = " df/servers";

    //퍗샵,병원 api 정보
    public static final String LOCALDATA_DOMAIN = "http://www.localdata.go.kr/platform/rest/GR0/openDataApi";
    public static final String LOCALDATA_KEY    = "9rh64zYknhyssMIMxo3iPfeSYrxJBSbjiYGNbrvl7pc=";

    //유기견 공공데이터 api 정보
    public static final String KOSIS_DOMAIN = "http://openapi.animal.go.kr/openapi/service/rest/animalShelterSrvc/shelterInfo";
    public static final String KOSIS_KEY    = "8TnPQAwfcuTSzCAnZqIJvW80asnyB7cZtyyYZcgB8z0lTie4aGNd7TTg9JK8OFt6v%2BsyNmEf162SvTGZi3B%2BvA%3D%3D";

    public static final String XML_PATH01   = "/usr/local/tomcat/webapps/SpringMvcProject/file/fulldata_02_03_01_P_동물병원.xml";             // 운영 xml 파일경로
    public static final String XML_PATH02   = "/usr/local/tomcat/webapps/SpringMvcProject/file/fulldata_02_03_02_P_동물약국.xml";             // 운영 xml 파일경로
    public static final String XML_PATH03   = "/usr/local/tomcat/webapps/SpringMvcProject/file/fulldata_02_03_03_P_동물용의료용구판매업.xml";   // 운영 xml 파일경로
    public static final String XML_PATH04   = "/usr/local/tomcat/webapps/SpringMvcProject/file/fulldata_02_03_04_P_동물용의약품도매상.xml";     // 운영 xml 파일경로
    public static final String XML_PATH05   = "/usr/local/tomcat/webapps/SpringMvcProject/file/fulldata_02_03_05_P_동물장묘업.xml";           // 운영 xml 파일경로
    public static final String XML_PATH06   = "/usr/local/tomcat/webapps/SpringMvcProject/file/fulldata_02_03_06_P_동물판매업.xml";           // 운영 xml 파일경로

    //public static final String XML_PATH01   = "C:/Users/PRO/Desktop/동물보호복지온라인/xml/fulldata_02_03_01_P_동물병원.xml";            // xml 파일경로
    //public static final String XML_PATH02   = "C:/Users/PRO/Desktop/동물보호복지온라인/xml/fulldata_02_03_02_P_동물약국.xml";            // xml 파일경로
    //public static final String XML_PATH03   = "C:/Users/PRO/Desktop/동물보호복지온라인/xml/fulldata_02_03_03_P_동물용의료용구판매업.xml";  // xml 파일경로
    //public static final String XML_PATH04   = "C:/Users/PRO/Desktop/동물보호복지온라인/xml/fulldata_02_03_04_P_동물용의약품도매상.xml";    // xml 파일경로
    //public static final String XML_PATH05   = "C:/Users/PRO/Desktop/동물보호복지온라인/xml/fulldata_02_03_05_P_동물장묘업.xml";           // xml 파일경로
    //public static final String XML_PATH06   = "C:/Users/PRO/Desktop/동물보호복지온라인/xml/fulldata_02_03_06_P_동물판매업.xml";           // xml 파일경로

    //DB 정보
    //public static final String DB_URL    = "jdbc:postgresql://3.36.203.84:5432/springdata"; //운영
    public static final String DB_URL    = "jdbc:postgresql://127.0.1.1:5432/springdata"; //개발
    public static final String DB_USER   = "zuiop13";
    public static final String DB_PW     = "pass";
}
